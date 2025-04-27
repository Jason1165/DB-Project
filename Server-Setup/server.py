from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import pandas as pd
from werkzeug.security import check_password_hash, generate_password_hash
import os

app = Flask(__name__)

app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"

app.config['MYSQL_HOST'] = os.environ.get('MYSQLHOST', '127.0.0.1')
app.config['MYSQL_PORT'] = int(os.environ.get('MYSQLPORT', 3306))
app.config['MYSQL_USER'] = os.environ.get('MYSQLUSER', 'root')
app.config['MYSQL_PASSWORD'] = os.environ.get('MYSQLPASSWORD', '')
app.config['MYSQL_DB'] = os.environ.get('MYSQLDATABASE', 'db4')


mysql = MySQL(app)
app.secret_key = "SOMESECRETKEY"

def execute_sql_file(cursor, filename):
    delimiter = ';'
    statement = ''
    line_number = 0

    with open(filename, 'r') as f:
        for line in f:
            line_number += 1
            line = line.strip()
            if not line or line.startswith('--'):
                continue

            if line.lower().startswith('delimiter'):
                delimiter = line.split()[1]
                continue

            statement += ' ' + line

            if statement.strip().endswith(delimiter):
                final_statement = statement.strip()[:-len(delimiter)].strip()
                if final_statement:
                    try:
                        print(f"Line {line_number}: Executing SQL: {final_statement[:100]}...")
                        cursor.execute(final_statement)
                    except Exception as e:
                        print(f"Line {line_number}: Error executing SQL: {final_statement[:100]}...")
                        print(f"Error Execute: {str(e)}")
                statement = ''
    print("DONE.")


@app.route('/initdb/<secret>')
def initdb(secret):
    if secret != os.environ.get('INITDB_SECRET'):
        return "Unauthorized", 403
    try:
        cursor = mysql.connection.cursor()
        execute_sql_file(cursor, 'ms4.sql')
        mysql.connection.commit()
        cursor.close()
        return "Database successfully initialized!"
    except Exception as e:
        return f"Error Init: {str(e)}", 500


def execute_query(query, params = None, fetchone = False, fetchall = False, commit = False):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query, params or ())
    result = None
    if fetchone:
        result = cursor.fetchone()
    elif fetchall:
        result = cursor.fetchall()
    if commit:
        mysql.connection.commit()
    cursor.close()
    return result


@app.route("/")
def index():
    if 'user_id' in session:
        return render_template('home.html')
    else:
        return redirect(url_for('login'))


@app.route("/register", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        username = request.form.get('username')
        password = request.form.get('password')

        if len(username) < 1 or len(password) < 1:
            error = "Username or password should be longer than one character."
            return render_template("register.html", error=error)
        
        if not (username.isalnum()) or not (password.isalnum()):
            error = "Username and password must only contain letters and numbers."
            return render_template("register.html", error=error)


        existing_user = execute_query (
            "SELECT * FROM user WHERE username = %s",
            (username,),
            fetchone=True
        )

        if existing_user:
            error = "Username already taken. Try another one."
            return render_template("register.html", error=error)

        hashed_password = generate_password_hash(password)
        execute_query(
            "INSERT INTO user (username, password) VALUES (%s, %s)",
            (username, hashed_password),
            commit = True
        )

        #execute_query messes up when trying to grant users roles, tried cursor approach
        cursor = mysql.connection.cursor()
        try:
            cursor.execute(f"CREATE USER IF NOT EXISTS `{username}`@'%' IDENTIFIED BY %s", (password,))
        except Exception as e:
            print("User creation error:", e)

        try:
            cursor.execute(f"GRANT Suser TO `{username}`@'%'")
        except Exception as e:
            print("Grant error:", e)

        mysql.connection.commit()
        cursor.close()

        return redirect(url_for('login'))
    return render_template('register.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        user = execute_query(
            "SELECT * FROM user WHERE username = %s",
            (username,),
            fetchone=True
        )

        if user and check_password_hash(user['password'], password):
            session['user_id'] = user['u_id']
            session['username'] = user['username']
            return redirect(url_for('index'))
        else:
            error = "Invalid username or password."
            return render_template('login.html', error=error)    
    return render_template('login.html')


@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route('/players', methods=['GET', 'POST'])
def players():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        search_value = request.form.get('player_name')
        search_field = request.form.get('search_field')

        procedures = {
            'name': 'GetPlayerByName',
            'team': 'GetPlayerByTeam',
            'position': 'GetPlayerByPosition',
        }

        procedure_name = procedures.get(search_field)

        if procedure_name:
            players_data = execute_query(
                f"CALL {procedure_name}(%s)",
                (f"%{search_value}%",),
                fetchall=True
            )
    else:
        # Get all players with team names
        players_data = execute_query(
            """
            SELECT p.playerID, p.name AS Name, p.position AS Position, p.number AS Number,
                p.height AS Height, p.age AS Age, p.salary AS Salary,
                t.name AS TeamName
            FROM player p
            LEFT JOIN team t ON p.teamID = t.teamID
            ORDER BY p.playerID
            """,
            fetchall=True
        )

    return render_template('players.html', players_data=players_data)

@app.route('/bracket', methods=['GET', 'POST'])
def search_bracket():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    error = None
    brackets = []

    if request.method == 'POST':
        search_type = request.form.get('search_type')
        search_value = request.form.get('search_value')

        if search_type == 'team':
            query = "CALL GetBracketByTeam(%s)"
        elif search_type == 'season':
            query = "CALL GetBracketBySeason(%s)"
        else:
            error = "Invalid search type selected."
            return render_template('bracket.html', error=error)

        brackets = execute_query(
            query,
            (search_value,),
            fetchall=True
        )

        if not brackets:
            error = "No brackets found for your search."

    return render_template('bracket.html', error=error, brackets=brackets)


@app.route('/player/<int:player_id>')
def player_detail(player_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    # Get player details
    player = execute_query(
        """
        SELECT p.*, t.name AS team_name
        FROM player p
        LEFT JOIN team t ON p.teamID = t.teamID
        WHERE p.playerID = %s
        """,
        (player_id,),
        fetchone=True
    )

    if not player:
        return "Player not found", 404

    return render_template('player_detail.html', player=player)


@app.route('/playerSearch', methods=['GET', 'POST'])
def search():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    
    print(session['user_id'])

    player_data = None

    if request.method == 'POST':
        search_value = request.form.get('player_name')
        search_field = request.form.get('search_field')

        procedures = {
            'name': 'GetPlayerByName',
            'team': 'GetPlayerByTeam',
            'position': 'GetPlayerByPosition',
        }

        procedure_name = procedures.get(search_field)

        if procedure_name:
            player_data = execute_query(
                f"CALL {procedure_name}(%s)",
                (f"%{search_value}%",),
                fetchall=True
            )
    return render_template('playerSearch.html', player_data=player_data)

@app.route('/match/<int:match_id>')
def view_match(match_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    match = execute_query(
        """
        SELECT m.matchID, 
               m.bracketID, 
               th.name AS home_team, 
               tv.name AS visiting_team,
               m.homeScore, 
               m.visitingScore,
               m.date,
               s.name AS stadium_name,
               r.name AS referee_name,
               ss.streamingLink,
               ss.name AS streaming_service_name
        FROM `match` m
        LEFT JOIN team th ON m.homeTeamID = th.teamID
        LEFT JOIN team tv ON m.visitingTeamID = tv.teamID
        LEFT JOIN stadium s ON m.stadiumID = s.stadiumID
        LEFT JOIN referee r ON m.refereeID = r.refereeID
        LEFT JOIN streaming_service ss ON m.streamingID = ss.streamingID
        WHERE m.matchID = %s
        """,
        (match_id,),
        fetchone=True
    )

    if not match:
        return "Match not found", 404

    return render_template('matchNum.html', match=match)

@app.route('/bracket/<int:bracket_id>')
def view_bracket(bracket_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))
    
    # Assign round numbers
    execute_query(
        "CALL OrganizeBracketMatches(%s)",
        (bracket_id,),
        commit=True
    )

    # Get matches organized by round
    matches = execute_query(
        """
        SELECT m.matchID, t1.name AS homeTeam, t2.name AS visitingTeam,
            m.homeScore, m.visitingScore, m.round
        FROM `match` m
        LEFT JOIN team t1 ON m.homeTeamID = t1.teamID
        LEFT JOIN team t2 ON m.visitingTeamID = t2.teamID
        WHERE m.bracketID = %s
        ORDER BY m.round ASC, m.matchID ASC
        """,
        (bracket_id,),
        fetchall=True
    )
 
    # Group matches by round numbers
    bracket = {}
    for match in matches:
        rnd = match['round']
        if rnd not in bracket:
            bracket[rnd] = []
        bracket[rnd].append(match)

    return render_template('bracketNum.html', bracket=bracket, bracket_id=bracket_id)

@app.route('/streaming_services')
def streaming_services():
    services = execute_query("SELECT * FROM streaming_service", fetchall=True)
    return render_template('streaming_services.html', services=services)

@app.route('/teams', methods=['GET'])
def teams():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    # Get all teams from the database with conferenceID included
    teams_data = execute_query(
        """
        SELECT t.teamID, t.name, t.Championships_Won as championships_won, t.playoffs_won, t.earnings,
               t.conferenceID, c.side AS conference_side
        FROM team t
        LEFT JOIN conference c ON t.conferenceID = c.conferenceID
        ORDER BY t.conferenceID, t.name
        """,
        fetchall=True
    )

    return render_template('teams.html', teams_data=teams_data)

@app.route('/team/<int:team_id>')
def team_detail(team_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    # Get basic team information
    team = execute_query(
        """
        SELECT t.*, c.side AS conference_name
        FROM team t
        LEFT JOIN conference c ON t.conferenceID = c.conferenceID
        WHERE t.teamID = %s
        """,
        (team_id,),
        fetchone=True
    )

    if not team:
        return "Team not found", 404

    player_count_result = execute_query(
        "SELECT countPlayersByTeam(%s) AS player_count",
        (team_id,),
        fetchone=True
    )
    player_count = player_count_result['player_count'] if player_count_result else 0

    # Get team players
    players = execute_query(
        """
        SELECT p.playerID, p.name, p.position, p.number, p.height, p.age, p.salary
        FROM player p
        WHERE p.teamID = %s
        ORDER BY p.position, p.name
        """,
        (team_id,),
        fetchall=True
    )

    # Get coach information
    coach = execute_query(
        """
        SELECT c.*
        FROM coach c
        WHERE c.coachID = %s
        """,
        (team['coachID'],),
        fetchone=True
    )

    # Get stadium information
    stadium = execute_query(
        """
        SELECT s.*
        FROM stadium s
        WHERE s.stadiumID = %s
        """,
        (team['stadiumID'],),
        fetchone=True
    )

    # Get top 3 referees (simplified for now)
    refs = execute_query(
        """
        SELECT r.*
        FROM referee r
        LIMIT 3
        """,
        fetchall=True
    )

    # Get sponsor information
    sponsor = execute_query(
        """
        SELECT s.*
        FROM sponsor s
        WHERE s.sponsorID = %s
        """,
        (team['sponsorID'],),
        fetchone=True
    )

    return render_template('team_detail.html',
                          team=team,
                          players=players,
                          coach=coach,
                          stadium=stadium,
                          refs=refs,
                          sponsor=sponsor,
                          player_count=player_count)

@app.route('/streaming_services/<int:service_id>', methods=['GET', 'POST'])
def manage_rating(service_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']

    if request.method == 'POST':
        score = int(request.form.get('rating'))
        existing = execute_query(
            "SELECT * FROM rating WHERE u_id = %s AND streamingID = %s",
            (user_id, service_id),
            fetchone=True
        )

        if existing:
            execute_query(
                "UPDATE rating SET score = %s WHERE u_id = %s AND streamingID = %s",
                (score, user_id, service_id),
                commit=True
            )
        else:
            execute_query(
                "INSERT INTO rating (score, u_id, streamingID) VALUES (%s, %s, %s)",
                (score, user_id, service_id),
                commit=True
            )

    ratings = execute_query(
        "SELECT r.score, u.username FROM rating r JOIN user u ON r.u_id = u.u_id WHERE streamingID = %s",
        (service_id,),
        fetchall=True
    )

    my_rating = execute_query(
        "SELECT * FROM rating WHERE u_id = %s AND streamingID = %s",
        (user_id, service_id),
        fetchone=True
    )

    return render_template('manage_rating.html', ratings=ratings, my_rating=my_rating, service_id=service_id)


@app.route('/streaming_services/<int:service_id>/delete', methods=['POST'])
def delete_rating(service_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    user_id = session['user_id']

    execute_query(
        "DELETE FROM rating WHERE u_id = %s AND streamingID = %s",
        (user_id, service_id),
        commit=True
    )

    return redirect(url_for('manage_rating', service_id=service_id))




if __name__ == '__main__':
    app.run(port=8792)

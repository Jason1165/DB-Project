from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import pandas as pd
from werkzeug.security import check_password_hash, generate_password_hash

app = Flask(__name__)

app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"

app.config['MYSQL_HOST'] = '127.0.0.1'
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_PASSWORD"] = ''
app.config["MYSQL_DB"] = 'db4'
app.config['MYSQL_PORT'] = 3306

mysql = MySQL(app)
app.secret_key = "SOMESECRETKEY"

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
    return render_template("index.html")

@app.route("/register", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        username = request.form['username']
        password = request.form['password']

        existing_user = execute_query (
            "SELECT * FROM user WHERE username = %s",
            (username,),
            fetchone=True
        )

        if existing_user:
            return "Username already taken. Try another one.", 409

        hashed_password = generate_password_hash(password)
        execute_query(
            "INSERT INTO user (username, password) VALUES (%s, %s)",
            (username, hashed_password),
            COMMIT = True
        )
        return redirect(url_for('login'))

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        user = execute_query(
            "SELECT * FROM user WHERE username = %s",
            (username,),
            fetchone=True
        )

        if user and check_password_hash(user['password'], password):
            session['user_id'] = user['u_id']
            session['username'] = user['username']
            return redirect(url_for('dashboard'))
        else:
            return "Invalid username or password.", 401

    return render_template('login.html')


if __name__ == '__main__':
    app.run(port=8792)


from flask import Flask, render_template
from flask_mysqldb import MySQL
import pandas as pd

app = Flask(__name__)

app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"

app.config["MYSQL_HOST"] = '127.0.0.1'
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_PASSWORD"] = ''
app.config["MYSQL_DB"] = 'db3' # change this later

mysql = MySQL(app)

def runqueries(query):
    cursor = mysql.connection.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    df = ""
    if (cursor.description):
        column_names = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns=column_names)
    mysql.connection.commit()
    cursor.close()
    return df


@app.route("/")
def index():
    # players_df = runstatement("SELECT * FROM players;")
    return render_template("index.html")

if __name__ == '__main__':
    app.run(port=8792)


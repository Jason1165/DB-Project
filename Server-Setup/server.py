from flask import Flask
from flask_mysqldb import MySQL
import pandas as pd

app = Flask(__name__)

app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"

app.config["MYSQL_HOST"] = '127.0.0.1'
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_PASSWORD"] = ''
app.config["MYSQL_DB"] = 'db3'

mysql = MySQL(app)


if __name__ == '__main__':
    app.run(port=8792)


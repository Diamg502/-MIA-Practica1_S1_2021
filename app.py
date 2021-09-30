from flask import Flask, jsonify, request
from flask_cors import CORS
import psycopg2
import os

app = Flask(__name__)

CORS(app)
DB_HOST = 'localhost'
DB_NAME = 'prueba'
DB_USER = 'postgres'
DB_PASS = 'root'

try:
    con = psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASS,
        host=DB_HOST)

    cur = con.cursor()
    print(con.status)

    

    @app.route("/")
    def helloWorld():
        return "Hello, cross-origin-world!"

    @app.route("/consulta1", methods=['GET'])
    def fetch_all_movies():
        cur.execute('SELECT * FROM movies')
        rows = cur.fetchall()
        print(rows)

        return jsonify(rows)

    if __name__ =="__main__":
        app.run(host='0.0.0.0')


except:
    print('error')
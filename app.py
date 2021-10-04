from flask import Flask, json, jsonify, request
from flask_cors import CORS
import psycopg2
import os

app = Flask(__name__)

CORS(app)
DB_HOST = 'localhost'
DB_NAME = 'blockbuster'
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
    def fetch_all_movies_1():
        cur.execute('select * from pais order by id_pais asc')
        rows = cur.fetchall()
        print(rows)

        return jsonify(rows)

    @app.route("/consulta2", methods=['GET'])
    def fetch_all_movies_2():
        cur.execute('select * from ciudad order by id_ciudad asc')
        rows = cur.fetchall()
        print(rows)

        return jsonify(rows)
    
    @app.route("/consulta3", methods=['GET'])
    def fetch_all_movie_3():
        cur.execute('select * from DIRECCIONES order by id_direccion asc')
        rows = cur.fetchall()
        print(rows)

        return jsonify(rows)
    
    @app.route("/consulta4", methods=['GET'])
    def fetch_all_movies_4():
        cur.execute('select * from empleados order by id_empleado asc')
        rows = cur.fetchall()
        print(rows)

        return jsonify(rows)

    @app.route("/consulta5", methods=['GET'])
    def fetch_all_movies_5():
        cur.execute('select * from clientes order by id_cliente asc')
        rows = cur.fetchall()
        print(rows)

        return jsonify(rows)

    @app.route('/insertar')
    def fetch_movies():

        cursor = con.cursor()

        pg_insert = """ INSERT INTO municipio(municipio) VALUES (%s)"""

        inserted_values = [
            'AMATITLAN',
        ]

        cursor.execute(pg_insert, inserted_values)

        con.commit()

        count = cur.rowcount

        return jsonify(count)

    if __name__ =="__main__":
     app.run(host='0.0.0.0')


except:
    print('error')
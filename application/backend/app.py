
from flask import Flask, render_template, request, redirect, jsonify
import sys
import os
import psycopg2
app = Flask('backend')


def get_db_connection():
    conn = psycopg2.connect(
        dbname=os.environ.get('DATABASE_NAME'),
        user=os.environ.get('DATABASE_USER'),
        password=os.environ.get('DATABASE_PASSWORD'),
        host=os.environ.get('DATABASE_HOST'),
        port=os.environ.get('DATABASE_PORT')
    )
    return conn


@app.route('/')
def home():
    # inventory = inventory_service.get_inventory()
    return redirect('/api/list')

@app.route('/api/update', methods=['POST'])
def insert_data():
    name = request.form.get('name')
    address = request.form.get('address')
    city = request.form.get('city')
    pincode = request.form.get('pincode')
    if not all([name, address, city, pincode]):
        return 'Error: All fields are required'
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute('INSERT INTO students (name, address, city, pincode) VALUES (%s, %s, %s, %s)', (name, address, city, pincode))
        conn.commit()
        return 'Data inserted successfully'
    except Exception as e:
        return f'Error: {str(e)}'
    finally:
        cursor.close()
        conn.close()

@app.route('/api/list')
def list_data(): 
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM students")
        data = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(data)
    except Exception as e:
        return jsonify({'error': str(e)}), 500 

if __name__ == '__main__':
    app.run(debug=False)
#'''
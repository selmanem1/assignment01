
from flask import Flask, render_template, request
import sys
import os

app = Flask('frontend')

BACKEND_URL = os.environ.get('BACKEND_URL', 'http://backend:5001')

@app.route('/addstudent')
def new_student():
   return render_template('add_student.html')

@app.route('/')
def home():
    return render_template("home.html")

@app.route('/update', methods=['POST','GET'])
def update():
    if request.method == 'POST':
        name = request.form['name']
        addr = request.form['address']
        city = request.form['city']
        pin = request.form['pin']

        data = {
            'name': name,
            'address': addr,
            'city': city,
            'pin': pin
        }
        response =  request.post(f"{BACKEND_URL}/api/update",data=data)
        msg = "Record successfully added!"
        return render_template("list.html",msg = msg)

@app.route('/list')
def list(): 
   inventory = request.get(f"{BACKEND_URL}/api/list")
   return render_template("list.html", students = inventory)

if __name__ == '__main__':
    app.run(debug=False)

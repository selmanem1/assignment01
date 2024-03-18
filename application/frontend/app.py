
from flask import Flask, render_template, request
import sys
import os

sys.path.append("services")

from logic import InventoryService
#'''
app = Flask(__name__)
inventory_service = InventoryService()

@app.route('/addstudent')
def new_student():
   return render_template('add_student.html')

@app.route('/')
def home():
    # inventory = inventory_service.get_inventory()
    return render_template("home.html")

@app.route('/update', methods=['POST'])
def update_inventory():
    product_id = request.form['product_id']
    quantity = request.form['quantity']
    inventory_service.update_inventory(product_id, quantity)
    return redirect('/')

@app.route('/list')
def list():   
   inventory = inventory_service.get_inventory()
   return render_template("list.html", students = inventory)
   con = sql.connect("student_database.db")
   con.row_factory = sql.Row
   
   cur = con.cursor()
   cur.execute("select * from students")
   
   students = cur.fetchall();
   return render_template("list.html", students = students)

if __name__ == '__main__':
    app.run(debug=False)
#'''
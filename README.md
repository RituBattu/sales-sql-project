# Sakes SQL Project

> Simple SQL project that demonstrate schema design, sample data, analytical views and queries for a small retail dataset.


----

## Project Summary
This repository contains SQL scripts  to create a small retail-style database( customers,products, orders, order_items) , generate random sample data, build analytical views (customer performance , monthly revenue) and run example analysis queries. 
It is ideal for showcasing SQL, data modeling and basic analytics on GitHub and a resume.

---

#sales-sql-project/
  |-- folder.txt
  |--  inserts.sql   # insert statement sample data
  |-- sales_project.sql.sql  # original full SQL
  |--  split_sql.py  # Script used to split sales_project.sql.sql
  |-- table.sql # CREATE TABLE statements
  |--  theory.sql # comments /misc/other statements
      |--sample_outputs/
                      |--top_customers.csv
                      |-- monthly_revenue.png
  |-- assets/
      |--demo.png
      
  |--  views.sql # CREATE VIEW statements
  |-- README.md



  ## Files and Purpose
  -**'table.sql'** -- Creates the database tables (customers, products, orders, order_items.)
  -**'inserts.sql'** -- Sample 'INSERT' statements to populate the tables for testing.
  -**'views.sql'** -- 'CREATE VIEW' statements, including 'customer_sales_summary' and 'monthly_revenue'.
  -**'theory.sql'** -- Any comments, helper statements or misc SQL that does not fit other categories'
  -**'split_sql.py**' -- Python script (used locally) to split a large SQL file into files above.
  -**'sample_output**' -- Example CSV or Screenshots of query outputs 




customers(customer_id PK,name,email,city)
orders(order_id PK, customer_id FK ->customer.customer_id,order_date)
order_items(order_item_id PK, order_id FK -> orders.order_id,product_id FK -> products.product_id,quantity)
products(product_id PK,name,category,price)















  

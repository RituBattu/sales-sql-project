-- data engineer 
-- sale data analysis using SQL

-- goal : to analyze * customer purchase, *product performance, * sales trend 

-- skill demonstrated 
  -- * Table design and normalization
  -- * joins and subquery
  -- * Aggregration grouping and filtering 
  -- * window function (ranking , cumulatives totals)
  -- * views for repoorting 
  
  
create database sales_analysis_db;
use sales_analysis_db;
-- Table design
create table customers(
  customer_id int Primary Key,
  name varchar(50),
  city varchar(50),
  age int
);  

create table product(
   product_id int Primary key,
   name varchar(50),
   category varchar(50),
   price Decimal (10,2)
);   

create table orders(
  order_id int Primary key,
  customer_id int,
  order_date Date,
  foreign Key (customer_id) REFERENCES customers(customer_id)
);  

create table order_items (
  order_item_id int Primary key,
  order_id int ,
  product_id int,
  quantity INT,
  FOREIGN KEY(order_id) REFERENCES orders(order_id),
  FOREIGN KEY(product_id) references product(product_id)
 ); 
 
 -- generate random sample data
 truncate table customers;
 -- Error Code: 1701. Cannot truncate a table referenced in a foreign key constraint (`sales_analysis_db`.`orders`, CONSTRAINT `orders_ibfk_1`)	
 
 
 SET FOREIGN_KEY_CHECKS = 0;
 TRUNCATE TABLE order_items;
 TRUNCATE TABLE orders;
 TRUNCATE TABLE customers;
 TRUNCATE TABLE product;
 SET FOREIGN_KEY_CHECKS = 1;
 
 
 insert into customers(customer_id, name, city, age)
 select
     seq as customer_id,
     concat('customer_', seq),
     ELT(FLOOR(1 + (RAND() * 5)),'Delhi', 'Mumbai', 'Banglore', 'Chennai', 'Kolkata'),
     Floor(18 + (RAND() * 40))
 from (
	 select @row := @row + 1 as seq
	 from information_schema.columns, (select @row := 0) r
	 limit 10
) as t;


--
-- 2 warning(s):
 -- 1287 Setting user variables within expressions is deprecated and will be removed in a future release.
 -- 1287 Setting user variables within expressions is deprecated and will be removed in a future release.
-- Records: 10  Duplicates: 0  Warnings: 2

select * from customers;



WITH RECURSIVE nums AS (
    SELECT 1 AS seq
    UNION ALL
    SELECT seq + 1 FROM nums WHERE seq < 10
)
INSERT INTO customers(customer_id, name, city, age)
SELECT
    seq,
    CONCAT('customer_', seq),
    ELT(FLOOR(1 + (RAND() * 5)), 'Delhi', 'Mumbai', 'Banglore', 'Chennai', 'Kolkata'),
    FLOOR(18 + (RAND() * 40))
FROM nums;
-- Error Code: 1064. You have an error in your SQL syntax;(NOT VALID IN THIS SQL)

INSERT INTO customers(customer_id, name, city, age)
SELECT 
    seq,
    CONCAT('customer_', seq),
    ELT(FLOOR(1 + (RAND() * 5)), 'Delhi', 'Mumbai', 'Banglore', 'Chennai', 'Kolkata'),
    FLOOR(18 + (RAND() * 40))
FROM (
    SELECT 1 AS seq
    UNION SELECT 2
    UNION SELECT 3
    UNION SELECT 4
    UNION SELECT 5
    UNION SELECT 6
    UNION SELECT 7
    UNION SELECT 8
    UNION SELECT 9
    UNION SELECT 10
) AS nums;


SELECT * FROM customers;
select version();

DESCRIBE customers;
DESCRIBE product;
DESCRIBE order_items;
DESCRIBE orders;

insert into product( product_id, name ,category, price)
select
     seq,
     concat('product_' , seq),
	 ELT(FLOOR(1 + rand() * 4), 'Electronics','Fashion','Home', 'Accessories'),
     round(200 + rand() * 1800 ,2)
from(
  select 1 as seq union all
  select 2 union all
  select 3 union all
  select 4 union all
  select 5 union all
  select 6 union all
  select 7 union all
  select 8 union all
  select 9 union all
  select 10 
) as t;

insert into orders(order_id ,customer_id , order_date)
select
    seq,
    floor(1 + (rand() * 10)),
    date_add('2024-01-01', interval floor(rand() * 300) day)
from(
  select 1 as seq union all
  select 2 union all
  select 3 union all
  select 4 union all
  select 5 union all
  select 6 union all
  select 7 union all
  select 8 union all
  select 9 union all
  select 10 union all
  select 11 union all
  select 12 union all
  select 13 union all
  select 14 union all
  select 15 union all
  select 16 union all
  select 17 union all
  select 18 union all
  select 19 union all
  select 20 
  ) as t;

insert into order_items(order_item_id ,order_id ,product_id, quantity)
select
    seq,
    floor(1 + rand() * 20),
    floor(1 + rand() * 10),
    floor(1 + rand() * 5)
from(
  select 1 as seq union all
  select 2 union all
  select 3 union all
  select 4 union all
  select 5 union all
  select 6 union all
  select 7 union all
  select 8 union all
  select 9 union all
  select 10 union all
  select 11 union all
  select 12 union all
  select 13 union all
  select 14 union all
  select 15 union all
  select 16 union all
  select 17 union all
  select 18 union all
  select 19 union all
  select 20 union all
  select 21 union all
  select 22 union all
  select 23 union all
  select 24 union all
  select 25 union all
  select 26 union all
  select 27 union all
  select 28 union all
  select 29 union all
  select 30 union all
  select 31 union all
  select 32 union all
  select 33 union all
  select 34 union all
  select 35 union all
  select 36 union all
  select 37 union all
  select 38 union all
  select 39 union all
  select 40
  ) as t;
    
    
select * from customers;
select * from orders;
select * from order_items;
select * from product;


describe table  customers;
describe table orders;
describe table order_items;
describe table product;


show columns from  customers;
show columns from orders;
show columns from order_items;
show columns from product;

-- total sales revenue
 
 select sum(oi.quantity * p.price) as total_revenue
 from order_items oi 
 join product p
 on oi.product_id = p.product_id;
 
 -- revenue by city
 select c.city, sum(oi.quantity * p.price) as revenue
 from customers c
 join orders o on c.customer_id = o.customer_id
 join order_items oi on oi.order_id = o.order_id
 join product p on oi.product_id = p.product_id
 group by c.city
 order by revenue desc;
 
 -- top 5 customer by spending
 
 show columns from  customers;
show columns from orders;
show columns from order_items;
show columns from product;


select c.customer_id, c.name, sum(oi.quantity * p.price) as spending
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join product p on oi.product_id = p.product_id
group by c.customer_id, c.name
order by spending desc
limit 5;

-- 5 best selling product

show columns from  customers;
show columns from orders;
show columns from order_items;
show columns from product;
 
 select  p.product_id, p.name, sum(oi.quantity) as unit_sold,sum(oi.quantity * p.price) as revenue
 from order_items oi
 join product p on oi.product_id = p.product_id
 group by product_id
 order by revenue desc
 limit 5;
 
 -- monthly revenue generated
 show columns from  customers;
show columns from orders;
show columns from order_items;
show columns from product
 
 
 select extract(month from order_date) as month,sum(oi.quantity * p.price) as monthly_revenue
 from orders o
 join order_items oi on o.order_id = oi.order_id
 join product p on oi.product_id = p.product_id
 group by month
 order by  month
 
 
 select date_format(o.order_date, '%y-%m') as month,sum(oi.quantity * p.price) as monthly_revenue
 from orders o
 join order_items oi on o.order_id = oi.order_id
 join product p on oi.product_id = p.product_id
 group by month
 order by  month
 
 -- average order value
  show columns from  customers;
show columns from orders;
show columns from order_items;
show columns from product
select avg(total) as avg from(
 select o.order_id,sum(p.price * oi.quantity) as total
 from orders o
 join order_items oi on o.order_id = oi.order_id
 join product p on p.product_id = oi.product_id
 group by o.order_id)
 as order_summary
 
 -- summarise monthly or customer performance
   show columns from  customers;
show columns from orders;
show columns from order_items;
show columns from product

CREATE VIEW customer_summary AS
SELECT c.customer_id,c.name,sum(p.price * oi.quantity) as total_spent, count(distinct o.order_id) as total_orders 
FROM customers c join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join product p on oi.product_id = p.product_id
group by c.customer_id, c.name;

 select * from customer_summary;
 
-- top 5 customer by spending 

select customer_id,total_spent from customer_summary 
order by total_spent desc
limit 5;
 
 
-- monthly summary sales

select date_format(o.order_date, '%y-%m') as month , sum(oi.quantity * p.price) as sales
from orders o
join order_items oi on o.order_id = oi.order_id
join product p on oi.product_id = p.product_id
group by month
order by month;











 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 


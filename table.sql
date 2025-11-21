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
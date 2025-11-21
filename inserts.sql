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
CREATE VIEW customer_summary AS
SELECT c.customer_id,c.name,sum(p.price * oi.quantity) as total_spent, count(distinct o.order_id) as total_orders 
FROM customers c join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join product p on oi.product_id = p.product_id
group by c.customer_id, c.name;
                                               -- SQL-75 question practice

-- Q1
select * from orders;

select customer_id, count(order_id) as total_order,
	 sum(amount) as total_spent, avg(amount) as avg_order_value,
sum(
	case(
			when amount > 10000 then count(amount)
			end as high_value_orders
	)
),
sum(
	case(
			when amount <= 10000 then count(amount)
			end as low_value_o
	)
)

-- Q2
select * from customers;
select * from orders;


select * from customers c
inner join
orders o
on c.customer_id = o.customer_id
order by c.customer_id,
o.order_date;

-- Q3
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL
ORDER BY c.customer_id ASC;

-- Q4
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;


-- Q5
select c.customer_id, c.customer_name,
		sum(o.amount) as total_spent
from customers c
join
orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.amount) > 50000
order by total_spent
desc;

-- Q6
select * from products;
select * from order_items;

select p.product_id, p.product_name,
	   coalesce(count(oi.quantity),0) as units_sold,
	   coalesce(sum(oi.quantity *oi.price),0) as total_revenue
from products p
left join
order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name
order by total_revenue
desc;

-- Q7
select * from customers;
select * from transactions;

select c.customer_id, c.customer_name,
coalesce(count(t.transaction_id),0) as total_transactions,
coalesce(sum(t.amount),0) as total_transaction_amount,
coalesce(round(avg(t.amount),2),0) as avg_transaction_amount
from customers c
left join
transactions t
on c.customer_id =t.customer_id
group by c.customer_id, c.customer_name
order by total_transaction_amount
desc;

-- Q8


SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT oi.product_id) AS distinct_products,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

-- Q9
select * from products;
select * from orders;
select * from order_items;

SELECT
    p.product_id,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    COUNT(DISTINCT oi.order_id) AS unique_orders,
    COALESCE(SUM(oi.quantity), 0) AS units_sold,
    COALESCE(SUM(oi.quantity * oi.price), 0) AS total_revenue
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN orders o
    ON oi.order_id = o.order_id
GROUP BY p.product_id
ORDER BY total_revenue DESC;

-- Q10
select * from customers;
select * from orders;

select c.customer_id, c.customer_name,
count(distinct o.product_id) as distinct_products,
count(o.order_id) as total_orders,
sum(o.quantity) as total_quantity,
sum(o.amount) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(distinct o.product_id) >= 2
order by total_spent
desc;

-- Q11

select * from customers;
select * from orders;
select * from products;


SELECT
    c.customer_id,
    c.customer_name,
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity,
    SUM(o.amount) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY
    c.customer_id,
    c.customer_name,
    p.category
HAVING SUM(o.amount) > 10
ORDER BY
    c.customer_id ASC,
    total_spent DESC;

-- Q12

select c.customer_id, c.customer_name,
count(distinct p.category) as distinct_categories,
count(distinct p.product_id) as distinct_products,
count(o.order_id) as total_orders,
sum(o.quantity) as total_quantity,
sum(o.amount * o.quantity) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
join products p
on p.product_id = o.product_id
group by c.customer_id, c.customer_name
having count(distinct p.category) >= 2
order by total_spent
desc;

-- Q13
select * from customers;


select o.region, c.customer_id, c.customer_name,
count(o.order_id) as total_orders,
count(distinct p.product_id) as distinct_products,
sum(o.quantity) as total_quantity,
sum(o.amount * o.quantity) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
join products p
on o.product_id = p.product_id
group by o.region, c.customer_id, c.customer_name
having count(o.order_id) >= 2
order by o.region asc,
total_spent desc;

-- Q14
select * from orders;
select * from products;

select p.product_id, p.product_name, p.category,
coalesce(count(o.order_id),0) as total_orders,
coalesce(sum(o.quantity),0) as units_sold,
coalesce(sum(o.amount * o.quantity),0) as total_revenue,
coalesce(sum(p.inventory),0) as inventory
from products p
left join orders o
on p.product_id = o.product_id
group by p.product_id, p.product_name, p.category
order by total_revenue
desc;

-- Q15
select * from orders;
select * from products;

SELECT
    o.region,
    p.product_id,
    p.product_name,
    p.category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS units_sold,
    SUM(o.amount * o.quantity) AS total_revenue,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    o.region,
    p.product_id,
    p.product_name,
    p.category
HAVING COUNT(o.order_id) >= 2
ORDER BY
    o.region ASC,
    total_revenue DESC;












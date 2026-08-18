-- ============================================================
-- Day 1 — SQL-75 Practice
-- Database: PostgreSQL
-- Dataset: sql_practice_dataset.sql
-- ============================================================

-- Q1: Total orders, spend, and high/low value order count per customer
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_spent,
    AVG(amount) AS avg_order_value,
    SUM(CASE WHEN amount > 10000 THEN 1 ELSE 0 END) AS high_value_orders,
    SUM(CASE WHEN amount <= 10000 THEN 1 ELSE 0 END) AS low_value_orders
FROM orders
GROUP BY customer_id;


-- Q2: Inner join customers with their orders
SELECT * FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;


-- Q3: Customers who have never placed an order
SELECT
    c.customer_id,
    c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL
ORDER BY c.customer_id ASC;


-- Q4: Total orders and spend per customer (including customers with 0 orders)
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;


-- Q5: Customers who have spent more than 50,000
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 50000
ORDER BY total_spent DESC;


-- Q6: Units sold and revenue per product
SELECT
    p.product_id,
    p.product_name,
    COALESCE(COUNT(oi.quantity), 0) AS units_sold,
    COALESCE(SUM(oi.quantity * oi.price), 0) AS total_revenue
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;


-- Q7: Transaction summary per customer
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(COUNT(t.transaction_id), 0) AS total_transactions,
    COALESCE(SUM(t.amount), 0) AS total_transaction_amount,
    COALESCE(ROUND(AVG(t.amount), 2), 0) AS avg_transaction_amount
FROM customers c
LEFT JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_transaction_amount DESC;


-- Q8: Customer order + product breadth summary (via order_items)
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
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;


-- Q9: Product-level demand summary (unique customers/orders, revenue)
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


-- Q10: Customers who bought 2+ distinct products
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.product_id) AS distinct_products,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.product_id) >= 2
ORDER BY total_spent DESC;


-- Q11: Spend per customer, broken down by product category
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
GROUP BY c.customer_id, c.customer_name, p.category
HAVING SUM(o.amount) > 10
ORDER BY c.customer_id ASC, total_spent DESC;


-- Q12: Customers who bought from 2+ distinct categories
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT p.category) AS distinct_categories,
    COUNT(DISTINCT p.product_id) AS distinct_products,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity,
    SUM(o.amount * o.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON p.product_id = o.product_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT p.category) >= 2
ORDER BY total_spent DESC;


-- Q13: Regional customer spend summary (2+ orders)
SELECT
    o.region,
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT p.product_id) AS distinct_products,
    SUM(o.quantity) AS total_quantity,
    SUM(o.amount * o.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN products p
    ON o.product_id = p.product_id
GROUP BY o.region, c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2
ORDER BY o.region ASC, total_spent DESC;


-- Q14: Product performance including current inventory
SELECT
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(COUNT(o.order_id), 0) AS total_orders,
    COALESCE(SUM(o.quantity), 0) AS units_sold,
    COALESCE(SUM(o.amount * o.quantity), 0) AS total_revenue,
    COALESCE(SUM(p.inventory), 0) AS inventory
FROM products p
LEFT JOIN orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;


-- Q15: Regional product performance (2+ orders)
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
GROUP BY o.region, p.product_id, p.product_name, p.category
HAVING COUNT(o.order_id) >= 2
ORDER BY o.region ASC, total_revenue DESC;
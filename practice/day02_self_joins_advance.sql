-- ============================================================
-- Day 2 — SQL-75 Practice (Self Join Advance)
-- Database: PostgreSQL
-- Dataset: sql_practice_dataset.sql
-- ============================================================

-- Q16
-- The company wants to create an employee-manager report.
-- For every employee who has a manager, return the employee's:

SELECT
    e.employee_id,
    e.name AS employee_name,
    e.manager_id,
    m.name AS manager_name
FROM employees e
JOIN employees m
    ON e.manager_id = m.employee_id;

-- Q17
-- The HR department wants an employee-manager report containing every employee.

select e.employee_id, e.name as employee_name,
e.manager_id , m.name as manager_name
from employees e
left join employees m
on e.manager_id = m.employee_id; 

-- Q18
-- The HR department wants to identify employees whose salary is greater than their direct manager's salary.

select e.employee_id, e.name as employee_name,
e.salary as employee_salary,
m.name as manager_name,
m.salary as manager_salary
from employees e
join employees m
on e.manager_id = m.employee_id
where e.salary > m.salary
order by e.employee_id;

-- Q19
-- The HR team wants to identify employees whose department is different from their manager's department.

select e.employee_id, e.name as employee_name,
e.department as employee_department,
m.name as manager_name,
m.department as manager_department
from employees e
join employees m
on e.manager_id = m.employee_id
where e.department <> m.department
order by e.employee_id;

-- Q20
-- The product team wants to identify products that are more expensive than another product in the same category.

select p1.product_name as expensive_product,
p1.price as expensive_price,
p2.product_name as cheaper_product,
p2.price as cheaper_price,
round(p1.price - p2.price,2) as price_difference
from products p1
join products p2
on p1.category = p2.category
where p1.price > p2.price
order by price_difference desc;

-- Q21
-- The marketing team wants to identify pairs of different customers who live in the same city so they can analyze potential customer clusters.

select c1.customer_id as customer_1_id,
c1.customer_name as customer_1_name,
c2.customer_id as customer_2_id,
c2.customer_name as customer_2_name,
c1.city as city
from customers c1
join customers c2
on c1.city = c2.city
where c1.customer_name > c2.customer_name;

-- Q22
-- The product team wants to compare products within the same category.
-- Find pairs of different products that belong to the same category and have different prices.

select 
p1.category,
p1.product_name as product_1,
p1.price as price_1,
p2.product_name as product_2,
p2.price as price_2,
round(p1.price - p2.price,2) as price_difference
from products p1
join products p2
on p1.category = p2.category
where p1.price > p2.price
order by price_difference
desc;

-- Q23
-- The sales team wants to identify whether a sale was followed by a higher-value sale later in the sales sequence.

select s1.sale_id as sale_1_id,
s1.sale_amount as sale_1_amount,
s2.sale_id as sale_2_id,
s2.sale_amount as sale_2_amount,
round(s2.sale_amount - s1.sale_amount, 2) as amount_difference
from sales s1
join sales s2
on s1.sale_id < s2.sale_id
where s2.sale_id > s1.sale_id and
s2.sale_amount > s1.sale_amount
order by s1.sale_id;

-- Q24
-- The sales team wants to identify sales where the immediately next sale in the sequence was higher than the current sale.

select s1.sale_id,
s1.sale_amount,
s2.sale_id as next_sale_id,
s2.sale_amount as next_amount,
round(s2.sale_amount - s1.sale_amount,2) as amount_change
from sales s1
join sales s2
on s2.sale_id = s1.sale_id + 1
where s1.sale_id % 2 = 1
order by s1.sale_id;

-- Q25
-- The sales team wants to identify sales where the current sale amount is greater than the immediately previous sale amount in the sales sequence.

select s1.sale_id,
s1.sale_amount,
s2.sale_id as previous_sale_id,
s2.sale_amount as previous_amount,
round(s1.sale_amount - s2.sale_amount) as amount_increase
from sales s1
join sales s2
on s1.sale_id = s2.sale_id + 1
where s1.sale_amount > s2.sale_amount
order by s2.sale_id;














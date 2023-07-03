###############################################################
###############################################################
-- Guided Project: Mastering SQL Subqueries
###############################################################
###############################################################


#############################
-- Task One: Getting Started
-- In this task, we will retrieve data from the tables in the
-- employees database
#############################

-- 1.1: Retrieve all the data from tables in the employees database
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM customers;
SELECT * FROM sales;

#############################
-- Task Four: Subquery in the SELECT clause
-- In this task, we will learn how to use a 
-- subquery in the SELECT clause
#############################

-- 4.1: Retrieve the first name, last name and average salary of all employees
SELECT first_name, 
	last_name,
	(SELECT ROUND(AVG(salary),2) FROM salaries) AS avg_salary
FROM employees;	

-- Exercise 4.1: Retrieve a list of customer_id, product_id, order_line and the name of the customer

-- Returns data from the sales and customers tables
SELECT * FROM sales
ORDER BY customer_id;

SELECT * FROM customers;

-- Solution
SELECT customer_id, product_id, order_line,
	(SELECT customer_name FROM customers AS c
	WHERE s.customer_id = c.customer_id ) as cust_name
FROM sales AS s
ORDER BY customer_id;


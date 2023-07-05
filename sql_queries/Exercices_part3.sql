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
-- Task Seven: Subquery Exercises - Part Three
-- In this task, we will try our hands on more 
-- exercises on subqueries
#############################

-- Exercise 7.1: Retrieve the salary that occurred the most

-- Returns a list of the count of salaries
SELECT salary, COUNT(*)
FROM salaries
GROUP BY salary;


-- Solution
SELECT a.salary
FROM
(SELECT salary, COUNT(*)
FROM salaries
GROUP BY salary
ORDER BY COUNT(*) DESC, salary DESC
LIMIT 1) a;

-- Exercise 7.2: Find the average salary excluding the highest and
-- the lowest salaries

-- Returns the average salary of all employees
SELECT ROUND(AVG(salary), 2) avg_salary
FROM salaries


-- Solution
SELECT ROUND(AVG(salary), 2) avg_salary
FROM salaries
WHERE salary NOT IN (
	(SELECT MIN(salary) FROM salaries),
	(SELECT MAX(salary) FROM salaries)
)

-- Exercise 7.3: Retrieve a list of customers id, name that has
-- bought the most from the store

-- Returns a list of customer counts
SELECT customer_id, COUNT(*) AS cust_count
FROM sales
GROUP BY customer_id
ORDER BY cust_count DESC;
	 
-- Solution
SELECT c.customer_id, c.customer_name, a.cust_count
FROM customers c,
	(SELECT customer_id, COUNT(*) AS cust_count
	FROM sales
	GROUP BY customer_id
	ORDER BY cust_count DESC) a
WHERE c.customer_id = a.customer_id 
ORDER BY a.cust_count DESC;

-- Exercise 7.4: Retrieve a list of the customer name and segment
-- of those customers that bought the most from the store and
-- had the highest total sales

-- Returns a list of customer counts and total sales
SELECT customer_id, COUNT(*) AS cust_count, SUM(sales) total_sales
FROM sales
GROUP BY customer_id
ORDER BY total_sales DESC, cust_count DESC;

-- Solution
SELECT c.customer_id, c.customer_name, c.segment, a.cust_count, a.total_sales
FROM customers c,
	(SELECT customer_id, COUNT(*) AS cust_count, SUM(sales) AS total_sales
	FROM sales
	GROUP BY customer_id
	ORDER BY total_sales DESC, cust_count DESC
	) AS a
WHERE c.customer_id = a.customer_id 
ORDER BY a.total_sales DESC, a.cust_count DESC;






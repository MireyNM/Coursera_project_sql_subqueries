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
-- Task Three: Subquery in the FROM clause
-- In this task, we will learn how to use a 
-- subquery in the FROM clause
#############################

-- 3.1: Retrieve a list of all customers living in the southern region
SELECT * 
FROM customers
WHERE region = 'South';

-- Retrieve a list of all customers names and age living in the southern region
SELECT a.customer_name, a.age
FROM (SELECT * 
		FROM customers
		WHERE region = 'South') a ; 
		
-- 3.2: Retrieve a list of managers and their department names

-- Returns all the data from the dept_manager table
SELECT * FROM dept_manager;

-- Solution
SELECT a.emp_no, b.dept_name
FROM (SELECT * FROM dept_manager) a,
	 (SELECT * FROM departments) b   
WHERE a.dept_no = b.dept_no;

-- Exercise 3.1: Retrieve a list of managers, their first, last, and their department names

-- Returns data from the employees table
SELECT * FROM employees;

-- Solution
SELECT a.emp_no, e.first_name, e.last_name, d.dept_name
FROM (SELECT * FROM dept_manager) a,
	 (SELECT * FROM employees) e,
	 (SELECT * FROM departments) d
WHERE a.dept_no = d.dept_no AND a.emp_no = e.emp_no;


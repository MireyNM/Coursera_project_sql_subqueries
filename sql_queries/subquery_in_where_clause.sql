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
-- Task Two: Subquery in the WHERE clause
-- In this task, we will learn how to use a 
-- subquery in the WHERE clause
#############################

-- 2.1: Retrieve a list of all employees that are not managers
SELECT * 
FROM employees  
WHERE emp_no NOT IN (SELECT emp_no 
					FROM dept_manager)

-- 2.2: Retrieve all columns in the sales table for customers above 60 years old
-- Returns the count of customers
SELECT customer_id, COUNT(*)
FROM sales
GROUP BY customer_id
ORDER BY COUNT(*) DESC;

-- Solution
SELECT * 
FROM sales 
WHERE customer_id IN (SELECT customer_id
					 FROM customers 
					 WHERE age >60);
					  
-- 2.3: Retrieve a list of all manager's employees number, first and last names

-- Returns all the data from the dept_manager table
SELECT * FROM dept_manager;

-- Solution
SELECT emp_no, first_name, last_name
FROM employees 
WHERE emp_no IN (SELECT emp_no 
				 FROM dept_manager
				);

-- Exercise 2.1: Write a JOIN statement to get the result of 2.3
SELECT e.emp_no, e.first_name, e.last_name
FROM employees AS e
JOIN dept_manager AS d
ON e.emp_no = d.emp_no;

-- Exercise 2.2: Retrieve a list of all managers that were 
-- employed between 1st January, 1990 and 1st January, 1995
SELECT * 
FROM dept_manager
WHERE emp_no IN (SELECT emp_no 
				 FROM employees
				WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');


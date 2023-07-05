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
-- Task Six: Subquery Exercises - Part Two
-- In this task, we will try our hands on more 
-- exercises on subqueries
#############################

-- Exercise 6.1: Return a list of all employees number, first and last name.
-- Also, return the average salary of all the employees and average salary
-- of each employee

-- Retrieve all the records in the salaries table
SELECT * FROM salaries;

-- Return the employee number, first and last names and average
-- salary of all employees
SELECT e.emp_no, e.first_name, e.last_name, 
(SELECT ROUND(AVG(salary), 2) FROM salaries) avg_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
ORDER BY e.emp_no;

-- Returns the employee number and average salary of each employee
SELECT emp_no, ROUND(AVG(salary), 2) AS emp_avg_salary
FROM salaries
GROUP BY emp_no
ORDER BY emp_no;

-- Solution
SELECT e.emp_no, e.first_name, e.last_name, s.emp_avg_salary,
(SELECT ROUND(AVG(salary), 2) FROM salaries) avg_salary
FROM employees e
JOIN (SELECT emp_no, ROUND(AVG(salary), 2) AS emp_avg_salary
	FROM salaries
	GROUP BY emp_no
	ORDER BY emp_no) s
ON e.emp_no = s.emp_no
ORDER BY e.emp_no;

-- Exercise 6.2: Find the difference between an employee's average salary
-- and the average salary of all employees
-- TCE Method 
WITH TCE AS
(
SELECT e.emp_no, e.first_name, e.last_name, s.emp_avg_salary,
(SELECT ROUND(AVG(salary), 2) FROM salaries) avg_salary
FROM employees e
JOIN (SELECT emp_no, ROUND(AVG(salary), 2) AS emp_avg_salary
	FROM salaries
	GROUP BY emp_no
	ORDER BY emp_no) s
ON e.emp_no = s.emp_no
ORDER BY e.emp_no
)
SELECT *, 
(emp_avg_salary - avg_salary) AS diff_salary
FROM TCE;

-- Subquery method 
SELECT e.emp_no, e.first_name, e.last_name, s.emp_avg_salary,
(SELECT ROUND(AVG(salary), 2) FROM salaries) avg_salary,
(s.emp_avg_salary - (SELECT ROUND(AVG(salary), 2) FROM salaries)) AS diff_salary
FROM employees e
JOIN (SELECT emp_no, ROUND(AVG(salary), 2) AS emp_avg_salary
	FROM salaries
	GROUP BY emp_no
	ORDER BY emp_no) s
ON e.emp_no = s.emp_no
ORDER BY e.emp_no;

-- Exercise 6.3: Find the difference between the maximum salary of employees
-- in the Finance or HR department and the maximum salary of all employees

SELECT e.emp_no, e.first_name, e.last_name, a.emp_max_salary,
(SELECT MAX(salary) max_salary FROM salaries), 
(SELECT MAX(salary) max_salary FROM salaries) - a.emp_max_salary salary_diff
FROM employees e
JOIN (SELECT s.emp_no, MAX(salary) AS emp_max_salary
				   FROM salaries s
				   GROUP BY s.emp_no
				   ORDER BY s.emp_no) a
ON e.emp_no = a.emp_no
WHERE e.emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no IN ('d002', 'd003'))
ORDER BY emp_no;



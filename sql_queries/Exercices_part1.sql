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
-- Task Five: Subquery Exercises - Part 1
-- In this task, we will try our hands on more 
-- exercises on subqueries
#############################

-- Exercise 5.1: Return a list of all employees who are in Customer Service department

-- Returns data from the dept_emp and departments tables
SELECT * FROM dept_emp;
SELECT * FROM departments;

-- Solution
SELECT *
FROM dept_emp
WHERE dept_no IN (SELECT dept_no FROM departments 
				 WHERE dept_name = 'Customer Service');


-- Exercise 5.2: Include the employee number, first and last names
SELECT a.dept_no, e.emp_no, e.first_name, e.last_name
FROM employees AS e
JOIN 
(SELECT *
FROM dept_emp
WHERE dept_no IN (SELECT dept_no FROM departments 
				 WHERE dept_name = 'Customer Service')) a
ON a.emp_no = e.emp_no 
ORDER BY emp_no;

-- Exercise 5.3: Retrieve a list of all managers who became managers after 
-- the 1st of January, 1985 and are in the Finance or HR department

-- Returns data from the departments and dept_manager tables
SELECT * FROM departments;
SELECT * FROM dept_manager
WHERE from_date > '1985-01-01';

-- Solution
SELECT * FROM dept_manager
WHERE from_date > '1985-01-01'
AND dept_no IN (SELECT dept_no FROM departments 
				 WHERE dept_name = 'Finance' OR dept_name ='Human Resources' )

-- Exercise 5.4: Retrieve a list of all employees that earn above 120,000
-- and are in the Finance or HR departments

-- Retrieve a list of all employees that earn above 120,000
SELECT emp_no, salary FROM salaries
WHERE salary > 120000;

-- Solution
SELECT e.emp_no, s.salary 
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no
WHERE s.salary > 120000 
AND e.emp_no IN (SELECT emp_no FROM dept_emp 
				 WHERE dept_no = 'd002' OR dept_no ='d002' );
				 
-- Alternative Solution
SELECT emp_no, salary FROM salaries
WHERE salary > 120000
AND emp_no IN (SELECT emp_no FROM dept_emp
				WHERE dept_no IN ('d002','d003'));

-- Exercise 5.5: Retrieve the average salary of these employees
WITH tce AS 
(SELECT emp_no, salary FROM salaries
WHERE salary > 120000
AND emp_no IN (SELECT emp_no FROM dept_emp
				WHERE dept_no IN ('d002','d003'))
) 
SELECT emp_no, ROUND(AVG(salary),2) AS avg_salary
FROM tce
GROUP BY emp_no
ORDER BY avg_salary DESC;






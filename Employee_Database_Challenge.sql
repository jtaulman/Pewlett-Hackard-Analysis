CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT emp_no, first_name, last_name
INTO employee_info
FROM employees;

SELECT title, from_date, to_date
INTO employee_title
FROM titles;

SELECT e.emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN CAST('1952-01-01' AS date) AND CAST('1955-12-31' AS date));

SELECT * FROM retirement_titles;

SELECT emp_no, first_name, last_name, title
FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO Unique_titles
FROM retirement_titles
WHERE (to_date = CAST('9999-01-01' AS date))
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT emp_no, first_name, last_name, birth_date
FROM employees

SELECT from_date, to_date
FROM dept_emp

SELECT title
FROM titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_np,
first_name,
last_name,
birth_date,
from_date,
to_date
title
--INTO mentorship_eligibility  
FROM employees AS e
INNER JOIN dep_no AS dn
INNER JOIN titles AS t
WHERE (to_date = CAST('9999-01-01' AS date)) 
	AND (birth_date BETWEEN CAST('1965-01-01' AS date) AND CAST('1965-12-31' AS date))
ORDER BY emp_no;
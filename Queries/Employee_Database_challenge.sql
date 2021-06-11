SELECT e.emp_no, 
	e.first_name, 
	e.last_name,  
	t.title, 
	t.from_date, 
	t.to_date 
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

SELECT COUNT(*) FROM retirement_titles;
--133776
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, 
	first_name, 
	last_name, 
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

SELECT COUNT(*) FROM unique_titles
--90398
SELECT * FROM unique_titles;

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT COUNT(*) FROM retiring_titles
--7
SELECT * FROM retiring_titles

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_employees AS de
	ON e.emp_no = de.emp_no
INNER JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
	 AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC, to_date DESC;

SELECT COUNT(*) FROM mentorship_eligibilty
--1549
SELECT * FROM mentorship_eligibilty

SELECT COUNT(me.emp_no), me.title
FROM mentorship_eligibilty AS me
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility_inc
FROM employees AS e
INNER JOIN dept_employees AS de
	ON e.emp_no = de.emp_no
INNER JOIN titles AS t
	ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01')
	 AND (e.birth_date BETWEEN '1964-06-01' AND '1965-12-31')
ORDER BY emp_no ASC, to_date DESC;


SELECT COUNT(*) FROM mentorship_eligibility_inc
--12317
SELECT * FROM mentorship_eligibility_inc

SELECT COUNT(mei.emp_no), mei.title
FROM mentorship_eligibility_inc AS mei
GROUP BY title
ORDER BY COUNT(title) DESC;

CREATE TABLE 
	

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	de.to_date,
	e.hire_date,
	de.from_date,
	t.title
INTO years_of_service_eligibility
FROM employees AS e
INNER JOIN dept_employees AS de
	ON e.emp_no = de.emp_no
INNER JOIN titles AS t
	ON e.emp_no = t.emp_no
  WHERE (de.to_date = '9999-01-01')
	 	AND (e.hire_date BETWEEN '1996-01-01' AND '2006-12-31')
  ORDER BY emp_no ASC;

SELECT COUNT(*) FROM years_of_service_eligibility
--17488
SELECT * FROM years_of_service_eligibility

ALTER TABLE years_of_service_eligibility
ADD COLUMN present_date DATE DEFAULT CURRENT_DATE

ALTER TABLE years_of_service_eligibility
DROP COLUMN years_of_service;

-- crete the column in the table
ALTER TABLE years_of_service_eligibility
ADD COLUMN days_of_service INT 

-- populate the column with the difference between hire_date and present_date
UPDATE years_of_service_eligibility
SET days_of_service = ("present_date"::date - "hire_date"::date)



SELECT COUNT(yose.emp_no), yose.title
FROM years_of_service_eligibility AS yose
GROUP BY title
ORDER BY COUNT(title) DESC;


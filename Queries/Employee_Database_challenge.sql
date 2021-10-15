--DELIVERABLE 1

--- select desired columns from tables and add to new table filtered by birthdate between 1952-55 and ordered by emp no.
SELECT em.emp_no, em.first_name, em.last_name, ti.title, ti.from_date, ti.to_date
INTO emp_titles_table
FROM employees as em
INNER JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO Unique_Titles_Table
FROM emp_titles_table
ORDER BY emp_no, to_date DESC;

-- count column with titles column ordered by number of retiring per title in descending order
SELECT COUNT(title), title
INTO Retiring_Titles_Table
FROM unique_titles_table
GROUP BY title
ORDER BY COUNT(title) DESC;


--DELIVERABLE 2

-- the tables joined for given data and filtered for birthdays in 1965 and currently working, only one employee number should appear
SELECT DISTINCT ON(em.emp_no) em.emp_no, em.first_name, em.last_name, em.birth_date, de.from_date, de.to_date, ti.title
INTO mentor_eligibility_table
FROM employees as em
INNER JOIN dept_employees as de
ON em.emp_no = de.emp_no
INNER JOIN titles as ti
ON em.emp_no = ti.emp_no
WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
ORDER BY em.emp_no;

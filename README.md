# Pewlett Hackard Analysis
Analysis of retiring employee information using sql queries in PgAdmin.
## Overview of the analysis
In this challenge we were tasked to find the number of retiring employees per title and find how many out of those retiring employees are eligible to act as mentors for the next generation of Pewlett Hackard employees. The purpose of this analysis was to try and prepare for the upcoming "Silver Tsunami" in which, in a short period, a high number of older employees are retiring leaving open positions and lesser workforce. This could have adverse effects if not dealt with properly or promptly as the company would be tasked to find a huge number of replacements in a very short time. 

For Deliverable 1, we created a table by joining Employees and Titles table to find all retiring employees with the titles they have had at Pewlett Hackard.
    
        SELECT em.emp_no, em.first_name, em.last_name, ti.title, ti.from_date, ti.to_date
        INTO emp_titles_table
        FROM employees as em
        INNER JOIN titles as ti
        ON em.emp_no = ti.emp_no
        WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
        ORDER BY em.emp_no;


Additionally we filtered the table to show the unique number of employees retiring with their most recent/present titles.

        SELECT DISTINCT ON (emp_no) emp_no,
        first_name,
        last_name,
        title
        INTO Unique_Titles_Table
        FROM emp_titles_table
        ORDER BY emp_no, to_date DESC;

Lastly we calculated the number of retiring employees per title.

        SELECT COUNT(title), title
        INTO Retiring_Titles_Table
        FROM unique_titles_table
        GROUP BY title
        ORDER BY COUNT(title) DESC;    

For Deliverable 2, we created a mentorship eligibility table by joining Employees, Titles and Department Employees table to filter it according to those who were working there presently and those who were born in 1965. 

        SELECT DISTINCT ON(em.emp_no) em.emp_no, em.first_name, em.last_name, em.birth_date, de.from_date, de.to_date, ti.title
        INTO mentor_eligibility_table
        FROM employees as em
        INNER JOIN dept_employees as de
        ON em.emp_no = de.emp_no
        INNER JOIN titles as ti
        ON em.emp_no = ti.emp_no
        WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
        ORDER BY em.emp_no;

## Results
Our analysis queries resulted in four important tables made which were then exported to csv files uploaded in the data folder. 
### Deliverable 1
#### Retiring Employees with Titles

<img width="490" alt="Screenshot 2021-10-15 at 19 08 12" src="https://user-images.githubusercontent.com/87828174/137563226-7e1fe437-15a1-4330-94ed-0f12bf7cd6ec.png">

The above table shows presently employed individuals who are eligible for retirement. As you may notice some names are being repeated. This is because these employees have held more than one title in their employment to Pewlett Hackard (They have been promoted one or more times). To see the correct number of retiring individuals with their titles we made a unique table as follows.


#### Unique Retiring Employee with Titles

<img width="336" alt="Screenshot 2021-10-15 at 19 20 59" src="https://user-images.githubusercontent.com/87828174/137563771-bd3449e9-0bdb-464c-98b7-7550890265c2.png">

The above table shows the unique employees that are retiring with their most recent title held at the company. This is done by SELECT DISTINCT ON(emp_no). This way the employee number is not repeated and as shown in the respective code above; ORDER BY allows us to see the most recent instance of the employee number therefore showing the most recent title. There are 90,398 total retiring employees holding titles presently at Pewlett Hackard. 

#### No. of Retiring Employees by Title

<img width="164" alt="Screenshot 2021-10-15 at 19 33 23" src="https://user-images.githubusercontent.com/87828174/137564420-97c9a2da-b77b-457b-bb72-a5bd2eb678bc.png">

Using GROUP BY on the count of employee numbers retiring we can see retiring individuals per title and it matches up to our previous number of 90,398 employees. We also see the title with the most upcoming vacancies is Senior Engineer versus the position least threatened by the upcoming retirements is Manager.

### Deliverable 2
#### Mentorship Eligibility

<img width="568" alt="Screenshot 2021-10-15 at 19 42 53" src="https://user-images.githubusercontent.com/87828174/137564867-1f270fb5-a3cf-420e-8d93-0d48b02e0451.png">

This table shows the employees who are eligible to mentor the upcoming generation of employees in Pewlett Hackard. We combined three tables, Employees, Department Employees and Titles to filter to employees born in 1965 and who are presently employed by the company. This can be seen in the code above for Deliverable 2.

## Summary
### How many roles will need to be filled as the "silver tsunami" begins to make an impact?

      select count(emp_no) from unique_titles_table
      --or
      select sum(count) from retiring_titles_table
      
Using the above query we can calculate the unique number of employees retiring thus the number of roles which will need to be filled. The result is that 90,398 roles will have to be filled in the upcoming Silver Tsunami. 

### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

      select count(emp_no) from mentor_eligibility_table
      
Using the above query we calculate only 1,549 employees from the retiring group are eligible for mentorship. This is a problem as only 1.71% of the retiring employees will be able to mentor the next generation. This leaves a huge gap for preparing the next generation of employees for the upcoming vacant positions. 

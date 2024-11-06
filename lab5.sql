--Select all data from the employee table:
SELECT * FROM employee;

--Add a new column phone with specific restrictions:
ALTER TABLE employee
ADD COLUMN phone VARCHAR(11) DEFAULT '87000000000' NOT NULL CHECK (phone ~ '^87\d{9}$');

--Add a password column with restrictions:
ALTER TABLE employee
ADD COLUMN password VARCHAR DEFAULT 'Default1@' NOT NULL CHECK (LENGTH(password) > 8 AND password ~ '[a-z]' AND password ~ '[A-Z]' AND password ~ '\d' AND password ~ '[^a-zA-Z0-9]');


--Set bonus percentage of specific employees to NULL:
UPDATE employee
SET bonus_percentage = NULL
WHERE eid IN ('E03344', 'E04152');


--Select data of employees with a bonus percentage greater than 0.2:

-- Case where bonus is unknown
SELECT * FROM employee
WHERE bonus_percentage > 0.2 OR bonus_percentage IS NULL;

-- Case where bonus is not unknown
SELECT * FROM employee
WHERE bonus_percentage > 0.2 AND bonus_percentage IS NOT NULL;

--Find the average annual salary of all employees:
SELECT AVG(annual_salary) FROM employee;

--Find distinct job titles of female employees over 40 but not under 32:
SELECT DISTINCT job_title
FROM employee
WHERE gender = 'Female' AND age > 40
AND NOT EXISTS (SELECT 1 FROM employee e2 WHERE e2.gender = 'Female' AND e2.age < 32);

--Find the number of employees who are not Caucasian or Latino:
SELECT COUNT(*)
FROM employee
WHERE ethnicity NOT IN ('Caucasian', 'Latino');

--Find employees with an annual salary greater than that of IT department employees:
SELECT name
FROM employee
WHERE annual_salary > (SELECT MAX(annual_salary) FROM employee WHERE department = 'IT');

--Select all employees who have listed their names:
SELECT *
FROM employee
WHERE name IS NOT NULL;

--Select employees whose name ends with the letter 'b':
SELECT *
FROM employee
WHERE name LIKE '%b';

--Select employees whose name contains the letter 'S':
SELECT *
FROM employee
WHERE name ILIKE '%S%';
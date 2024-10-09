SELECT * FROM employee;
--Select names of all employees.
SELECT name FROM employee;
--Select the employee names without duplicates and their job titles.
SELECT DISTINCT name, job_title FROM employee;
--Select all the data of the employees where department ID is 2 or 3.
SELECT * FROM employee WHERE department_id IN (2, 3);
--Select the number of employees in each department and department names.
SELECT department, COUNT(*) AS employee_count
FROM employee
GROUP BY department;
--Select the number of employees in each department which has more than 100 employees and their department names.
SELECT department, COUNT(*) AS employee_count
FROM employee
GROUP BY department
HAVING COUNT(*) > 100;
--Select all the data of the employees who are females.
SELECT * FROM employee WHERE gender = 'Female';
--Select the sum of the annual salary of all employees in each department.
SELECT department, SUM(annual_salary) AS total_sallary
FROM employee
GROUP BY department;
--Select the name and annual salary of the employee with the second-highest annual salary.
SELECT name, annual_salary FROM employee
ORDER BY annual_salary DESC
OFFSET 1
LIMIT 1;
--Select all the data of male employees who are above 30.
SELECT * FROM employee
WHERE gender = 'Male' AND age > 30;
--Select the name, job title, department, and annual salary of the employees with the lowest salary in each department.
SELECT name, job_title,department,annual_salary
FROM employee ef
WHERE annual_salary = (
    SELECT MIN(annual_salary)
    FROM employee es
    WHERE es.department = ef.department
    );
--Select the name and bonus percentage of the employees with more than 0.3 bonus rate sorted by increasing bonus.
SELECT name, bonus_percentage
FROM employee
WHERE bonus_percentage > 0.3
ORDER BY bonus_percentage;
--Reduce the annual salary of employees with the highest annual salary by 10%.
UPDATE employee
SET annual_salary = annual_salary * 0.9
WHERE annual_salary = (SELECT MAX(annual_salary) FROM employee);
--Reassign all employees from the IT department to the Accounting department who have a bonus rate of 0.2.
UPDATE employee
SET department = 'Accounting'
WHERE department = 'IT' AND bonus_percentage = 0.2;
--Reassign the department ID of the changed departments to 1 which is the department ID of the IT.
UPDATE employee
SET department_id = 1
WHERE department_id = (SELECT department_id FROM employee WHERE department = 'Accounting');
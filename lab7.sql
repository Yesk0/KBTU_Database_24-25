CREATE INDEX idx_staff_first_name ON staff(first_name);

CREATE INDEX idx_staff_first_last_name ON staff(first_name, last_name);

CREATE INDEX idx_employee_annual_salary_range
ON employee(annual_salary)
WHERE annual_salary BETWEEN 5000 and 10000;

CREATE INDEX idx_employee_name_substr ON employee(substring(name FROM 1 FOR 4));

CREATE INDEX idx_employee_job_title_desc
ON employee(job_title DESC NULLS LAST);

CREATE INDEX idx_employee_department_name
ON employee(department, name DESC NULLS FIRST);

CREATE INDEX idx_customer_address_id ON customer(address_id);
CREATE INDEX idx_address_address_id ON address(address_id);

CREATE INDEX idx_address_postal_code ON address(postal_code);
CREATE INDEX idx_customer_last_name ON customer(last_name);
CREATE INDEX idx_address_address_id ON address(address_id);



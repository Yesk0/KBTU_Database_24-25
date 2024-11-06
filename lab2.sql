-- 1. Create the database called "Faculty"
CREATE DATABASE Faculty;

-- 2. Connect to the "Faculty" database
-- In PostgreSQL, the `USE` command is not supported. You need to connect to the database at the session level
-- For example, in psql, you can connect using: \c Faculty

-- 3. Create the "students" table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    lastname VARCHAR(50),
    gender INT,
    age INT
);

-- 4. Insert one row into the students table for the columns name and lastname
INSERT INTO students (name, lastname)
VALUES ('John', 'Doe');

-- 5. Insert a NULL value into the age column for a row in the students table
INSERT INTO students (name, lastname, age)
VALUES ('Alice', 'Smith', NULL);

-- 6. Insert 3 rows in a single insert statement
INSERT INTO students (name, lastname, gender, age)
VALUES
    ('David', 'Johnson', 1, 22),
    ('Emma', 'Williams', 2, 19),
    ('Sophia', 'Brown', 2, 25);

-- 7. Set the default value of the age column to 20
ALTER TABLE students
ALTER COLUMN age SET DEFAULT 20;

-- 8. Insert a default value into the age column for a row of the students table
INSERT INTO students (name, lastname, gender)
VALUES ('Lucas', 'Garcia', 1);

-- 9. Create a duplicate of the "students" table named "teachers" (without data)
CREATE TABLE teachers (LIKE students INCLUDING ALL);

-- 10. Insert all rows from the students table into the teachers table
INSERT INTO teachers
SELECT * FROM students;

-- 11. Change the gender of students to 0 if it equals NULL (Use WHERE clause and IS NULL operator)
UPDATE students
SET gender = 0
WHERE gender IS NULL;

-- 12. Change the age of students to 20 if it equals NULL
UPDATE students
SET age = 20
WHERE age IS NULL;

-- 13. Write an SQL statement to increase the age of each student by 2. The statement should return name and updated age as update_age.
UPDATE students
SET age = age + 2
RETURNING name, age AS update_age;

-- 14. Remove all rows from the students table where age is under 20
DELETE FROM students
WHERE age < 20;

-- 15. Remove all rows from the teachers table if id exists in the students table. The statement should return all deleted data.
-- First, select the rows to be deleted
SELECT *
FROM teachers
WHERE id IN (SELECT id FROM students);

-- Now perform the actual deletion
DELETE FROM teachers
WHERE id IN (SELECT id FROM students);

-- 16. Remove all rows from the students table. The statement should return all deleted data.
-- First, select all the data to be deleted
SELECT * FROM students;

-- Now perform the deletion
TRUNCATE TABLE students;


-- 1. Select all first and last names of the actor and staff tables
SELECT first_name, last_name FROM actor
UNION ALL
SELECT first_name, last_name FROM staff;

-- 2. Select the first and last names from the actor table that do not exist in the staff table
SELECT first_name, last_name FROM actor
WHERE (first_name, last_name) NOT IN (SELECT first_name, last_name FROM staff);

-- 3. Select the films with a film length greater than 100 and replacement cost less than 25
SELECT * FROM film
WHERE length > 100 AND replacement_cost < 25;

-- 4. Select distinct rating system records from the film table
SELECT DISTINCT rating FROM film;

-- 5. Select the number of films in each rating system
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 6. Select the number of films released each year with an amount greater than 5
SELECT release_year, COUNT(*) AS number_of_films
FROM film
GROUP BY release_year
HAVING COUNT(*) > 5;

-- 7. Reduce the value of the third-largest replacement cost by 15%
WITH third_largest AS (
    SELECT replacement_cost
    FROM film
    ORDER BY replacement_cost DESC
    LIMIT 1 OFFSET 2
)
UPDATE film
SET replacement_cost = replacement_cost * 0.85
WHERE replacement_cost = (SELECT replacement_cost FROM third_largest);

-- 8. Remove films with a length greater than 180
DELETE FROM film
WHERE length > 180;

-- 9. Remove all the films that are in Mandarin language, returning all affected rows
DELETE FROM film
WHERE language_id = (
    SELECT language_id
    FROM language
    WHERE name = 'Mandarin'
)
RETURNING *;

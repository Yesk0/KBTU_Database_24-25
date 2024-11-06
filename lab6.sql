SELECT customer.first_name, customer.last_name, address.address
FROM customer
JOIN address ON customer.address_id = address.address_id;

SELECT customer.first_name, customer.last_name, store.store_id, store.manager_staff_id as manager_id
FROM customer
INNER JOIN store ON customer.address_id == store.address_id;

SELECT customer.first_name, customer.last_name
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
WHERE address.postal_code IN ('17886', '83579');

SELECT customer.first_name, customer.last_name, address.city_id
FROM customer
JOIN address ON customer.address_id = address.address_id
WHERE customer.active= 0;
 -- assuming "active" is a boolean

SELECT DISTINCT address.postal_code, customer.first_name, customer.last_name
FROM customer
JOIN address ON customer.address_id = address.address_id;

SELECT address.address, COUNT(customer.customer_id) AS customer_count
FROM customer
JOIN address ON customer.address_id = address.address_id
GROUP BY address.address
HAVING COUNT(customer.customer_id) > 1;

SELECT c.first_name, c.last_name, a.address
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
ORDER BY a.address;

SELECT store.manager_staff_id, COUNT(customer.customer_id) AS customer_count
FROM customer
JOIN store ON customer.store_id = store.store_id
GROUP BY store.manager_staff_id;

use sakila;
-- 1. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;


-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

INSERT INTO `sakila`.`staff` 
(`staff_id`, `first_name`, `last_name`, `address_id`, `email`, `store_id`, `active`, `username`, `last_update`) 
VALUES ('3', 'Tammy', 'Sanders', '5', 'Tammy.Sanders@sakilastaff.com', '2', '1', 'Tammy', '2022-04-30 15:57:16');

INSERT INTO `sakila`.`staff` 
(`staff_id`, `first_name`, `last_name`, `address_id`, `email`, `store_id`, `active`, `username`, `last_update`) 
VALUES ('4', 'Xabi', 'Laibarra', '6', 'Xabi.Laibarra@sakilastaff.com', '1', '1', 'Xabi', now());

INSERT INTO `sakila`.`staff`
(`staff_id`, `first_name`, `last_name`, `address_id`, `email`, `store_id`, `active`, `username`, `last_update`) 
VALUES ('5', 'JONE', 'Bocos', '7', 'Jone.Bocos@sakilastaff.com', '1', '1', 'JONE', now());

INSERT INTO `sakila`.`staff`
(`staff_id`, `first_name`, `last_name`, `address_id`, `email`, `store_id`, `active`, `username`, `last_update`) 
VALUES ('6', 'JON', 'Laibarra', '8', 'Jon.Laibarra@sakilastaff.com', '1', '1', 'JON', now());

SELECT *
FROM staff;

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the 
-- rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
-- To get that you can use the following query:

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- customer_id is 130

SELECT *
FROM rental
WHERE customer_id=130 and staff_id=1;

SELECT *
FROM film
WHERE title='Academy Dinosaur'; -- film_id is 1 and the store id is also 1 

SELECT *
FROM inventory
WHERE film_id=1 and store_id=1; -- inventory_id can be from 1 to 4. We will choose 1.
SELECT *
FROM rental
ORDER BY rental_id desc; -- rental_id is one more than the last one, hence 16049+1=16050

SELECT *
FROM staff
WHERE first_name='Mike' and last_name='Hillyer'; -- staff_id and store_id are 1


INSERT INTO `sakila`.`rental` (`rental_id`, `rental_date`,`inventory_id`, `customer_id`, `return_date`, `staff_id`, `last_update`)
VALUES ('16050', now(), '1', '130', now() + INTERVAL 3 DAY, '1', now()); 


-- Use similar method to get inventory_id, film_id, and staff_id.


-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the 
-- users that would be deleted. Follow these steps:

-- 4.1. Check if there are any non-active users
SELECT DISTINCT active
FROM customer;

-- 4.2. Create a table backup table as suggested
CREATE TABLE deleted_users AS 
SELECT *
FROM customer
WHERE active=1;

SELECT *
FROM deleted_users;
-- 4.3. Insert the non active users in the table backup table
INSERT INTO deleted_users 
SELECT *
FROM customer
WHERE active=1;

-- 4.4. Delete the non active users from the table customer

DELETE FROM customer
WHERE active=0;
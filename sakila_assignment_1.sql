-- 1a

USE sakila;

SELECT first_name, last_name
FROM actor;

-- 1b

SELECT CONCAT(first_name, ' ' , last_name) AS "Actor Name"
FROM actor;

-- 2a

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name IN ('Joe');

-- 2b

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'GEN';

-- 2c

SELECT last_name, first_name
FROM actor
WHERE last_name LIKE 'LI';

-- 2d

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a

ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b

ALTER TABLE actor
DROP COLUMN description;

-- 4a

SELECT last_name, COUNT(*) AS "Last Name Count"
FROM actor
GROUP BY last_name;

-- 4b

SELECT last_name, COUNT(last_name) Shared_Names from actor
GROUP BY last_name HAVING Shared_Names>1;

-- 4c

SET SQL_SAFE_UPDATES = 0;

SELECT first_name, last_name
FROM actor
WHERE first_name IN ('Groucho');

-- UPDATE actor 
-- SET first_name = 'Harpo'
-- WHERE first_name =  'Groucho'

UPDATE actor 
SET first_name = 'Groucho'
WHERE first_name =  'Harpo';

-- 5a

-- SHOW CREATE TABLE address;
-- CREATE TABLE address (
 --  id INT(11) default NULL auto_increment,
  -- s char(60) default NULL,
--  PRIMARY KEY (address_id)
-- )


-- 6a

SELECT
staff.first_name,
staff.last_name,
address.address
FROM staff
INNER JOIN address ON staff.staff_id=address.address_id;

-- 6b

SELECT
staff.first_name,
staff.last_name,
payment.amount,
payment.payment_date
FROM staff
INNER JOIN payment ON staff.staff_id=payment.staff_id
WHERE payment_date LIKE '2005-08%';

-- 6c

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT
film_actor.film_id,
film.title,
COUNT(film_actor.actor_id) total_actors
FROM film_actor
INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY film_id;

-- 6d

SELECT title, COUNT(title) AS "Copies of Hunchback Impossible"
FROM film
WHERE title IN ('Hunchback Impossible');

-- 6e

SELECT
customer.first_name,
customer.last_name,
SUM(payment.amount) AS 'Total Amount Paid'
FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id;

-- 7a

-- display the titles of movies starting with the letters K and Q whose language is English.
        
-- SELECT title
-- FROM film
-- WHERE film_id IN
	-- (
	-- 	SELECT title
     --   FROM film
      --  WHERE title LIKE 'K%' IN
	-- (
		-- SELECT title
    --    FROM film
   --     WHERE title LIKE 'Q%' IN
	-- (
		-- SELECT original_language_id
      --   FROM film
     --   WHERE original_language_id = 'English')
        -- );
        
-- 7b

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(
		SELECT actor_id
		FROM film_actor
        WHERE film_id IN
	(
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip")
	);
    
-- 7c

SELECT
customer.first_name,
customer.last_name,
customer.email,
country.country
FROM customer
INNER JOIN country ON customer.customer_id=country.country_id
WHERE country.country = 'Canada'
GROUP BY customer.customer_id;

-- 7d Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN
(
 SELECT category_id
 FROM category
 WHERE name IN ('Family')
);

-- 7e most frequently rented movies

SELECT
film.title,
SUM(rental.inventory_id) total_rentals,
rental.rental_id
FROM film
INNER JOIN rental on film.film_id=rental.rental_id
GROUP BY rental.rental_id;

-- 7f how much business, in dollars, each store brought in

SELECT
store.store_id,
-- SUM(payment.amount) total revenue,
payment.amount
FROM store
INNER JOIN payment on store.store_id=payment.payment_id
GROUP BY payment.payment_id;

-- 7g Write a query to display for each store its store ID, city, and country.

SELECT store_id
FROM store
WHERE store_id IN
(
 SELECT city_id
 FROM city
 WHERE city_id IN
 (
  SELECT country_id
  FROM country)
  );
  
  -- 7h List the top five genres in gross revenue in descending order. 
  -- (Hint: you may need to use the following tables: 
  -- category, film_category, inventory, payment, and rental.)
  
  -- 8a Create view
  
  CREATE VIEW `movies` 
  AS SELECT `title`,`release_year`,`length` FROM `film`;
  
  
  -- 8b
  
-- SHOW CREATE VIEW movies;
  
  -- 8c
  
 --  DROP VIEW ` top_five_genres `;
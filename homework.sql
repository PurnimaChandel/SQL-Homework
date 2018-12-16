#1a. Display the first and last names of all actors from the table actor.
SELECT FIRST_NAME, LAST_NAME
FROM SAKILA.ACTOR;

#1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT UPPER(CONCAT(FIRST_NAME, " ", LAST_NAME)) AS ACTOR_NAME
FROM SAKILA.ACTOR;

#2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT ACTOR_ID, FIRST_NAME, LAST_NAME
FROM SAKILA.ACTOR
WHERE FIRST_NAME = "JOE";

#2b. Find all actors whose last name contain the letters GEN:
SELECT ACTOR_ID, FIRST_NAME, LAST_NAME
FROM SAKILA.ACTOR
WHERE LAST_NAME LIKE "%GEN%";

#2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT  LAST_NAME, FIRST_NAME
FROM SAKILA.ACTOR
WHERE LAST_NAME LIKE "%LI%";

#2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China
SELECT * FROM SAKILA.COUNTRY
WHERE COUNTRY IN ('Afghanistan', 'Bangladesh', 'China');

#3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table actor named description and use the data type BLOB (Make sure to research the type BLOB, as the difference between it and VARCHAR are significant).
ALTER TABLE SAKILA.ACTOR
ADD DESCRIPTION BLOB;

#3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE SAKILA.ACTOR
DROP COLUMN DESCRIPTION;

#4a. List the last names of actors, as well as how many actors have that last name.
SELECT LAST_NAME, COUNT(LAST_NAME) AS COUNT
FROM SAKILA.ACTOR
GROUP BY LAST_NAME;

#4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors.
SELECT LAST_NAME, COUNT(LAST_NAME) AS COUNT
FROM SAKILA.ACTOR
GROUP BY LAST_NAME
HAVING COUNT >1;

#4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE SAKILA.ACTOR
SET FIRST_NAME = "HARPO"
WHERE FIRST_NAME = "GROUCHO"
AND LAST_NAME = "WILLIAMS";

#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
UPDATE SAKILA.ACTOR
SET FIRST_NAME = "GROUCHO"
WHERE FIRST_NAME = "HARPO";

#5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE SAKILA.ADDRESS;

#6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT STAFF_ID, FIRST_NAME, LAST_NAME, ADDRESS
FROM SAKILA.STAFF
LEFT JOIN SAKILA.ADDRESS ON STAFF.ADDRESS_ID = ADDRESS.ADDRESS_ID
GROUP BY STAFF.STAFF_ID;

#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT FIRST_NAME, LAST_NAME, SUM(AMOUNT) AS TOTAL_AMOUNT
FROM SAKILA.STAFF
LEFT JOIN SAKILA.PAYMENT 
ON STAFF.STAFF_ID = PAYMENT.STAFF_ID
WHERE PAYMENT_DATE LIKE "2005-08-%"
GROUP BY STAFF.STAFF_ID;

#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT TITLE, COUNT(ACTOR_ID) AS TOTAL_ACTORS
FROM SAKILA.FILM
INNER JOIN SAKILA.FILM_ACTOR
ON FILM.FILM_ID = FILM_ACTOR.FILM_ID
GROUP BY FILM.TITLE;

#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT TITLE, COUNT(INVENTORY_ID) AS TOTAL_COUNT
FROM SAKILA.FILM
LEFT JOIN SAKILA.INVENTORY
ON FILM.FILM_ID = INVENTORY.FILM_ID
WHERE FILM.TITLE = "Hunchback Impossible";

#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT FIRST_NAME, LAST_NAME, SUM(AMOUNT) AS TOTAL_AMOUNT
FROM SAKILA.CUSTOMER
LEFT JOIN SAKILA.PAYMENT
ON CUSTOMER.CUSTOMER_ID = PAYMENT.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID
ORDER BY CUSTOMER.LAST_NAME;

#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT TITLE
FROM SAKILA.FILM
WHERE TITLE LIKE "K%" OR "Q%" AND LANGUAGE_ID IN
(
SELECT LANGUAGE_ID FROM SAKILA.LANGUAGE
WHERE NAME ="ENGLISH"
);

#7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT FIRST_NAME, LAST_NAME
FROM SAKILA.ACTOR
WHERE ACTOR_ID in
(
SELECT ACTOR_ID 
FROM SAKILA.FILM_ACTOR
WHERE FILM_ID IN
(
SELECT FILM_ID 
FROM SAKILA.FILM
WHERE TITLE ="ALONE TRIP"
)
);

#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT FIRST_NAME, LAST_NAME, EMAIL
FROM SAKILA.CUSTOMER
JOIN SAKILA.ADDRESS
ON CUSTOMER.CUSTOMER_ID = ADDRESS.ADDRESS_ID
JOIN SAKILA.CITY
ON ADDRESS.CITY_ID = CITY.CITY_ID
JOIN SAKILA.COUNTRY
ON CITY.COUNTRY_ID = COUNTRY.COUNTRY_ID
WHERE COUNTRY = "CANADA"
GROUP BY CUSTOMER_ID;

#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT TITLE
FROM SAKILA.FILM
WHERE FILM_ID in
(
SELECT FILM_ID
FROM SAKILA.FILM_CATEGORY
WHERE CATEGORY_ID IN
(
SELECT CATEGORY_ID
FROM SAKILA.CATEGORY
WHERE NAME ="FAMILY"
)
);
#7e. Display the most frequently rented movies in descending order.
#7f. Write a query to display how much business, in dollars, each store brought in.
#7g. Write a query to display for each store its store ID, city, and country.
#7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
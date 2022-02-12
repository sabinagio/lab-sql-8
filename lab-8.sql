USE sakila;

# 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, and the rank.
SELECT 
	title, 
    length, 
    rating, 
    RANK() OVER (ORDER BY length DESC) AS `rank` 
FROM 
	film 
WHERE 
	title IS NOT NULL;

# 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, rating and the rank.

SELECT 
	title, 
    length, 
    rating, 
    RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS `rank` 
FROM 
	film 
WHERE 
	title IS NOT NULL;


# 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
SELECT 
	category.name, COUNT(*) AS film_count
FROM 
	film_category
INNER JOIN 
	category 
ON 
	category.category_id = film_category.category_id
GROUP BY 
	category.category_id;

# 4. Which actor has appeared in the most films?
SELECT 
	first_name, last_name, COUNT(*) AS film_count
FROM 
	actor
INNER JOIN 
	film_actor ON film_actor.actor_id = actor.actor_id
GROUP BY 
	first_name, last_name
ORDER BY 
	film_count DESC
LIMIT 1;

# 5. Most active customer (the customer that has rented the most number of films)
SELECT 
	first_name, 
    last_name, 
    COUNT(*) AS number_of_rental
FROM 
	customer
INNER JOIN 
	rental ON rental.customer_id = customer.customer_id
GROUP BY 
	first_name, last_name
ORDER BY 
	number_of_rental DESC
LIMIT 1;

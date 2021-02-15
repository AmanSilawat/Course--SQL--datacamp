-- Functions for Manipulating Data in PostgreSQL

-- 1 Overview of Common Data Types
-- 1.1 Welcome!
-- video


-- 1.2 Text data types
-- choose: string


-- 1.3 Getting information about your database
-- Instructions 1
-- Select all columns from the TABLES system database
SELECT * 
FROM INFORMATION_SCHEMA.TABLES
-- Filter by schema
WHERE table_schema = 'public';


-- Instructions 2
-- Select all columns from the COLUMNS system database
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'actor';


-- 1.4 Determining data types
-- Get the column name and data type
SELECT
 	column_name, 
    data_type
-- From the system database information schema
FROM INFORMATION_SCHEMA.COLUMNS
-- For the customer table
WHERE table_name = 'customer';


-- 1.5 Date and time data types
-- video


-- 1.6 Properties of date and time data types
-- choose: TIME data types are stored with a timezone by default.


-- 1.7 Interval data types
SELECT
 	-- Select the rental and return dates
	rental_date,
	return_date,
 	-- Calculate the expected_return_date
	rental_date + INTERVAL '3 Days' AS expected_return_date
FROM rental;


-- 1.8 Working with ARRAYs
-- video


-- 1.9 Accessing data in an ARRAY
-- Instructions 1
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film;


-- Instructions 2
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[1] = 'Trailers';


-- Instructions 3
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[2] = 'Deleted Scenes';


-- 1.10 Searching an ARRAY with ANY
SELECT
  title, 
  special_features 
FROM film 
-- Modify the query to use the ANY function 
WHERE 'Trailers' = ANY (special_features);


-- 1.11 Searching an ARRAY with @>
SELECT 
  title, 
  special_features 
FROM film 
-- Filter where special_features contains 'Deleted Scenes'
WHERE special_features @> ARRAY['Deleted Scenes'];



-- 2 Working with DATE/TIME Functions and Operators
-- 2.1 Overview of basic arithmetic operators
-- video


-- 2.2 Adding and subtracting date and time values
-- Instructions 1
SELECT f.title, f.rental_duration,
       -- Calculate the number of days rented
       r.return_date - r.rental_date AS days_rented
FROM film AS f
     INNER JOIN inventory AS i ON f.film_id = i.film_id
     INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
ORDER BY f.title;


-- Instructions 2
SELECT f.title, f.rental_duration,
    -- Calculate the number of days rented
	AGE(r.return_date, r.rental_date) AS days_rented
FROM film AS f
	INNER JOIN inventory AS i ON f.film_id = i.film_id
	INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
ORDER BY f.title;


-- 2.3 INTERVAL arithmetic
SELECT
	f.title,
 	-- Convert the rental_duration to an interval
    INTERVAL '1' day * f.rental_duration,
 	-- Calculate the days rented as we did previously
    r.return_date - r.rental_date AS days_rented
FROM film AS f
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
-- Filter the query to exclude outstanding rentals
WHERE r.return_date is not null
ORDER BY f.title;


-- 2.4 Calculating the expected return date
SELECT
    f.title,
	r.rental_date,
    f.rental_duration,
    -- Add the rental duration to the rental date
    INTERVAL '1' day * f.rental_duration + r.rental_date AS expected_return_date,
    r.return_date
FROM film AS f
    INNER JOIN inventory AS i ON f.film_id = i.film_id
    INNER JOIN rental AS r ON i.inventory_id = r.inventory_id
ORDER BY f.title;


-- 2.5 Functions for retrieving current date/time
-- video


-- 2.6 Current timestamp functions
-- choose: CURRENT_TIMESTAMP returns the current timestamp without timezone.


-- 2.7 Working with the current date and time
-- Instructions 1
-- Select the current timestamp
SELECT now();


-- Instructions 2
-- Select the current date
SELECT current_date;


-- Instructions 3
--Select the current timestamp without a timezone
SELECT CAST( NOW() AS timestamp )


-- Instructions 4
SELECT 
	-- Select the current date
	current_date,
    -- CAST the result of the NOW() function to a date
    CAST( NOW() AS date )


-- 2.8 Manipulating the current date and time
-- Instructions 1
--Select the current timestamp without timezone
SELECT current_timestamp::timestamp AS right_now;


-- Instructions 2
SELECT
	CURRENT_TIMESTAMP::timestamp AS right_now,
    interval '5 days' + CURRENT_TIMESTAMP AS five_days_from_now;


-- Instructions 3
SELECT
	CURRENT_TIMESTAMP(0)::timestamp AS right_now,
    interval '5 days' + CURRENT_TIMESTAMP(0) AS five_days_from_now;


-- 2.9 Extracting and transforming date/ time data
-- video


-- 2.10 Using EXTRACT
-- Instructions 1
SELECT 
  -- Extract day of week from rental_date
  extract(dow from rental_date) AS dayofweek 
FROM rental 
LIMIT 100;


-- Instructions 2
-- Extract day of week from rental_date
SELECT 
  EXTRACT(dow FROM rental_date) AS dayofweek, 
  -- Count the number of rentals
  count(rental_date) as rentals 
FROM rental 
GROUP BY 1;


-- 2.11 Using DATE_TRUNC
-- Instructions 1
-- Truncate rental_date by year
SELECT DATE_TRUNC('year', rental_date) AS rental_year
FROM rental;


-- Instructions 2
-- Truncate rental_date by month
SELECT date_trunc('month', rental_date) AS rental_month
FROM rental;


-- Instructions 3
-- Truncate rental_date by day of the month 
SELECT DATE_TRUNC('day', rental_date) AS rental_day 
FROM rental;


-- Instructions 4
SELECT 
  DATE_TRUNC('day', rental_date) AS rental_day,
  -- Count total number of rentals 
  count(*) AS rentals 
FROM rental
GROUP BY 1;


-- 2.12 Putting it all together
-- Instructions 1
SELECT 
  -- Extract the day of week date part from the rental_date
  Extract(dow from rental_date) AS dayofweek,
  AGE(return_date, rental_date) AS rental_days
FROM rental AS r 
WHERE 
  -- Use an INTERVAL for the upper bound of the rental_date 
  rental_date BETWEEN CAST('2005-05-01' AS DATE)
   AND CAST('2005-05-01' AS DATE) + interval '90 day';


-- Instructions 2
SELECT 
  c.first_name || ' ' || c.last_name AS customer_name,
  f.title,
  r.rental_date,
  -- Extract the day of week date part from the rental_date
  EXTRACT(dow FROM r.rental_date) AS dayofweek,
  AGE(r.return_date, r.rental_date) AS rental_days,
  -- Use DATE_TRUNC to get days from the AGE function
  CASE WHEN DATE_TRUNC('day', AGE(r.return_date, r.rental_date)) > 
  -- Calculate number of d
    f.rental_duration * INTERVAL '1' day 
  THEN TRUE 
  ELSE FALSE END AS past_due 
FROM 
  film AS f 
  INNER JOIN inventory AS i 
  	ON f.film_id = i.film_id 
  INNER JOIN rental AS r 
  	ON i.inventory_id = r.inventory_id 
  INNER JOIN customer AS c 
  	ON c.customer_id = r.customer_id 
WHERE 
  -- Use an INTERVAL for the upper bound of the rental_date 
  r.rental_date BETWEEN CAST('2005-05-01' AS DATE) 
  AND CAST('2005-05-01' AS DATE) + INTERVAL '90 day';



-- 3 Parsing and Manipulating Text
-- 3.1 Reformatting string and character data
-- video


-- 3.2 Concatenating strings
-- Instructions 1
-- Concatenate the first_name and last_name and email 
SELECT first_name || ' ' || last_name || ' <' || email || '>' AS full_email FROM customer


-- Instructions 2
-- Concatenate the first_name and last_name and email
SELECT CONCAT(first_name, ' ', last_name,  ' <', email, '>') AS full_email FROM customer


-- 3.3 Changing the case of string data
SELECT 
  -- Concatenate the category name to coverted to uppercase
  -- to the film title converted to title case
  upper(c.name)  || ': ' || INITCAP(f.title) AS film_category, 
  -- Convert the description column to lowercase
  lower(f.description) AS description
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;


-- 3.4 Replacing string data
SELECT 
  -- Replace whitespace in the film title with an underscore
  replace(title, ' ', '_') AS title
FROM film; 


-- 3.5 Parsing string and character data
-- video


-- 3.6 Determining the length of strings
SELECT 
  -- Select the title and description columns
  title,
  description,
  -- Determine the length of the description column
  char_length(description) AS desc_len
FROM film;


-- 3.7 Truncating strings
SELECT 
  -- Select the first 50 characters of description
  left(description, 50) AS short_desc
FROM 
  film AS f; 


-- 3.8 Extracting substrings from text data
SELECT 
  -- Select only the street name from the address table
  substring(address from position(' ' in address)+1 FOR char_length(address))
FROM 
  address;


-- 3.9 Combining functions for string manipulation
SELECT
  -- Extract the characters to the left of the '@'
  left(email, position('@' IN email)-1) AS username,
  -- Extract the characters to the right of the '@'
  substring(email FROM position('@' IN email)+1 for char_length(email)) AS domain
FROM customer;


-- 3.10 Truncating and padding string data
-- video


-- 3.11 Padding
-- Instructions 1
-- Concatenate the padded first_name and last_name 
SELECT 
	rpad(first_name, LENGTH(first_name)+1) || last_name AS full_name
FROM customer;


-- Instructions 2
-- Concatenate the first_name and last_name 
SELECT 
	first_name || lpad(last_name, LENGTH(last_name)+1) AS full_name
FROM customer; 


-- Instructions 3
-- Concatenate the first_name and last_name 
SELECT 
	rpad(first_name, LENGTH(first_name)+1) 
    || rpad(last_name, LENGTH(last_name)+2, ' <') 
    || rpad(email, LENGTH(email)+1, '>') AS full_email
FROM customer; 


-- 3.12 The TRIM function
-- Concatenate the uppercase category name and film title
SELECT 
  concat(upper(c.name), ': ', f.title) AS film_category, 
  -- Truncate the description remove trailing whitespace
  trim(left(f.description, 50)) AS film_desc
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;


-- 3.13 Putting it all together
SELECT 
  UPPER(c.name) || ': ' || f.title AS film_category, 
  -- Truncate the description without cutting off a word
  left(description, 50 - 
    -- Subtract the position of the first whitespace character
    position(
      ' ' IN REVERSE(LEFT(description, 50))
    )
  ) 
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;



-- 4 Full-text Search and PostgresSQL Extensions
-- 4.1 Introduction to full-text search
-- video


-- 4.2 A review of the LIKE operator
-- Instructions 1
-- Select all columns
SELECT *
FROM film
-- Select only records that begin with the word 'GOLD'
WHERE title like 'GOLD%';


-- Instructions 2
SELECT *
FROM film
-- Select only records that end with the word 'GOLD'
WHERE title like '%GOLD';


-- Instructions 3
SELECT *
FROM film
-- Select only records that contain the word 'GOLD'
WHERE title LIKE '%GOLD%';


-- 4.3 What is a tsvector?
-- Select the film description as a tsvector
SELECT to_tsvector(description)
FROM film;


-- 4.4 Basic full-text search
-- Select the title and description
SELECT title, description
FROM film
-- Convert the title to a tsvector and match it against the tsquery 
WHERE to_tsvector(title) @@ to_tsquery('elf');


-- 4.5 Extending PostgreSQL
-- video


-- 4.6 User-defined data types
-- Instructions 1
-- Create an enumerated data type, compass_position
CREATE TYPE compass_position AS ENUM (
  	-- Use the four cardinal directions
  	'left', 
  	'right',
  	'top', 
  	'bottom'
);


-- Instructions 2
-- Create an enumerated data type, compass_position
CREATE TYPE compass_position AS ENUM (
  	-- Use the four cardinal directions
  	'North', 
  	'South',
  	'East', 
  	'West'
);
-- Confirm the new data type is in the pg_type system table
SELECT *
FROM pg_type
WHERE typname='compass_position';


-- 4.7 Getting info about user-defined data types
-- Instructions 1
-- Select the column name, data type and udt name columns
SELECT column_name, data_type, udt_name
FROM INFORMATION_SCHEMA.COLUMNS 
-- Filter by the rating column in the film table
WHERE table_name ='film' AND column_name='rating';


-- Instructions 2
SELECT *
FROM pg_type
WHERE typname='mpaa_rating';


-- 4.8 User-defined functions in Sakila
-- Instructions 1
-- Select the film title and inventory ids
SELECT 
	f.title, 
    i.inventory_id
FROM film AS f 
	-- Join the film table to the inventory table
	INNER JOIN inventory AS i ON f.film_id=i.film_id 


-- Instructions 2
-- Select the film title, rental and inventory ids
SELECT 
	f.title, 
    i.inventory_id,
    -- Determine whether the inventory is held by a customer
    inventory_held_by_customer(i.inventory_id) AS held_by_cust 
FROM film as f 
	-- Join the film table to the inventory table
	INNER JOIN inventory AS i ON f.film_id=i.film_id 


-- Instructions 3
-- Select the film title and inventory ids
SELECT 
	f.title, 
    i.inventory_id,
    -- Determine whether the inventory is held by a customer
    inventory_held_by_customer(i.inventory_id) as held_by_cust
FROM film as f 
	INNER JOIN inventory AS i ON f.film_id=i.film_id 
WHERE
	-- Only include results where the held_by_cust is not null
    inventory_held_by_customer(i.inventory_id) is not null


-- 4.9 Intro to PostgreSQL extensions
-- video


-- 4.10 Enabling extensions
-- Instructions 1
-- Enable the pg_trgm extension
CREATE EXTENSION IF NOT EXISTS pg_trgm;


-- Instructions 2
-- Select all rows extensions
SELECT *
FROM pg_extension;


-- 4.11 Measuring similarity between two strings
-- Select the title and description columns
SELECT 
  title, 
  description, 
  -- Calculate the similarity
  similarity(title, description)
FROM 
  film


-- 4.12 Levenshtein distance examples
-- Select the title and description columns
SELECT  
  title, 
  description, 
  -- Calculate the levenshtein distance
  levenshtein(title, 'JET NEIGHBOR') AS distance
FROM 
  film
ORDER BY 3


-- 4.13 Putting it all together
-- Instructions 1
-- Select the title and description columns
SELECT  
  title, 
  description 
FROM 
  film
WHERE 
  -- Match "Astounding Drama" in the description
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama');


-- Instructions 2
SELECT 
  title, 
  description, 
  -- Calculate the similarity
  similarity(description, 'Astounding Drama')
FROM 
  film 
WHERE 
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama') 
ORDER BY 
	similarity(description, 'Astounding Drama') DESC;


-- 4.14 Wrap Up
-- video
/*
 SQL-Project-DVD-Rental/Question-set-1.sql

 PROGRAMMER: Anand Siva P V
 DATE CREATED: 23-03-2023
 REVISED DATE: 23-03-2023
 PURPOSE: Investigate a Relational Database 
*/
WITH table1 AS (
SELECT fc.film_id, COUNT(r.rental_id) rental_count
FROM rental r
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film_category fc 
ON fc.film_id = i.film_id
JOIN category cat
ON  fc.category_id = cat.category_id
GROUP BY 1
			)
			
SELECT f.title,cat.name,t1.rental_count
FROM table1 t1
JOIN film_category fc 
ON fc.film_id = t1.film_id
JOIN category cat
ON  fc.category_id = cat.category_id
JOIN film f
ON f.film_id = fc.film_id
WHERE LOWER(cat.name) IN 
('animation','children', 'classics', 'comedy', 'family','music')
ORDER BY 2,1
/*
Q2. Provide a table with the movie titles and divide them into 4 
levels (first_quarter, second_quarter, third_quarter, and final_quarter) 
based on the quartiles (25%, 50%, 75%) of the average rental duration
(in the number of days) for movies across all categories?
*/

SELECT f.title, cat.name,f.rental_duration,
	   NTILE(4) OVER (ORDER BY rental_duration)
FROM film f
JOIN film_category fc 
ON fc.film_id = f.film_id
JOIN category cat
ON  fc.category_id = cat.category_id


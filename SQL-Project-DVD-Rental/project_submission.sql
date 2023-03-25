/*
 SQL-Project-DVD-Rental/Question-set-1.sql

 PROGRAMMER: Anand Siva P V
 DATE CREATED: 25-03-2023
 REVISED DATE: 25-03-2023
 PURPOSE: Investigate a Relational Database containg rental information of films
*/

/* 
Q1.Create a query that lists each movie, the film category it is 
   classified in and the number of times it has been rented out.
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

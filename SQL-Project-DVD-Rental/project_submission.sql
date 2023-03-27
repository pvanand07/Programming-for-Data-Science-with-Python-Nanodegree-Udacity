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
			
/*
Revenue and Rental Duration by Category
*/

SELECT cat.name Movie_category, 
	   SUM(p.amount) Total_revenue,
	   ROUND(AVG(f.rental_duration),2) average_rental_duration
FROM rental r
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film_category fc 
ON fc.film_id = i.film_id
JOIN category cat
ON  fc.category_id = cat.category_id
JOIN payment p
ON p.rental_id = r.rental_id
JOIN film f
ON f.film_id = fc.film_id
GROUP BY 1
ORDER BY 2 DESC

/*
Monthly Revenue by stores
*/

SELECT DISTINCT(DATE_TRUNC('month',p.payment_date)) Payment_month,c.store_id,SUM(p.amount) Revenue  
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY 1,2
ORDER BY 1,2

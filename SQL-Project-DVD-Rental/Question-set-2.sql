/*
 SQL-Project-DVD-Rental/Question-set-2.sql

 PROGRAMMER: Anand Siva P V
 DATE CREATED: 23-03-2023
 REVISED DATE: 23-03-2023
 PURPOSE: Investigate a Relational Database containg rental information of films
*/

/*
Q1. Write a query that returns the store ID for the store, the year and month and 
the number of rental orders each store has fulfilled for that month. Your table 
should include a column for each of the following: year, month, store ID and 
count of rental orders fulfilled during that month.
*/
SELECT  DATE_PART('year',r.rental_date), 
		DATE_PART('month',r.rental_date),
		i.store_id, COUNT(*)
FROM rental r
JOIN inventory i 
ON r.inventory_id = i.inventory_id
GROUP BY 1,2,3
ORDER BY 1,2

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
GROUP BY 2,1,3
ORDER BY 4 DESC;

/*
Q2. Can you write a query to capture the customer name, month and year 
of payment, and total payment amount for each month by these top 10 
paying customers?
*/
-- Get Top 10 customers and return as table1 
WITH table1 AS (
	SELECT c.customer_id, SUM(p.amount)	  
	FROM customer c
	JOIN rental r
	ON c.customer_id = r.customer_id
	JOIN payment p
	ON r.rental_id = p.rental_id 
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10
	)
-- Get sum of monthly spendings of top 10 customers as table2
 	,table2 AS(
	SELECT  t1.customer_id,
		DATE_TRUNC('month',p.payment_date) pay_month,
		COUNT(p.amount) pay_count_per_month,
		SUM(p.amount) pay_amount
	FROM table1 t1
	JOIN rental r
	ON t1.customer_id = r.customer_id
	JOIN payment p
	ON r.rental_id = p.rental_id 
	GROUP BY 1,2
	)
-- Add customer name to the table
SELECT t2.pay_month, c.first_name || c.last_name cust_name,
		t2.pay_count_per_month, t2.pay_amount
FROM table2 t2
JOIN customer c
ON t2.customer_id = c.customer_id
ORDER BY 2

/*
Q3. Finally, for each of these top 10 paying customers, I would like
to find out the difference across their monthly payments during 2007.
Please go ahead and write a query to compare the payment amounts in 
each successive month. Repeat this for each of these 10 paying customers.
Also, it will be tremendously helpful if you can identify the customer
name who paid the most difference in terms of payments.
*/
-- Get Top 10 customers and return as table1 
WITH table1 AS (
	SELECT c.customer_id, SUM(p.amount)	  
	FROM customer c
	JOIN rental r
	ON c.customer_id = r.customer_id
	JOIN payment p
	ON r.rental_id = p.rental_id 
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10
	)
-- Get monthly differences in spending of each top 10 customer in 2007
 	,table2 AS(
	SELECT  t1.customer_id,
		DATE_TRUNC('month',p.payment_date) pay_month,SUM(p.amount),
		LAG(SUM(p.amount),1,0) OVER (PARTITION BY t1.customer_id ORDER BY DATE_TRUNC('month',p.payment_date)),
		SUM(p.amount)-
		LAG(SUM(p.amount),1,0) OVER (PARTITION BY t1.customer_id ORDER BY DATE_TRUNC('month',p.payment_date))
	FROM table1 t1
	JOIN rental r
	ON t1.customer_id = r.customer_id
	JOIN payment p
	ON r.rental_id = p.rental_id 
	WHERE DATE_PART('year',p.payment_date) = '2007'
	GROUP BY 1,2
	)
SELECT *
FROM table2

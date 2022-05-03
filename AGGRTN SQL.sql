#Select the first name, last name, and email address of all the customers who have rented a movie
Use sakila;
select concat(first_name,' ',last_name,'',email) as customer_name from customer
inner join rental 
using(customer_id)
inner join inventory 
using(inventory_id)
inner join film 
using(film_id)
inner join film_category
using(film_id)
inner join category
using(category_id)
group by customer_name
having count(rental_id) 
order by customer_name;


#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT c.customer_id, c.last_name, c.first_name,
    AVG(CASE WHEN (r.rental_id) = 1 THEN p.amount END) as avg_rental_id,
    AVG(CASE WHEN (r.rental_id) = 2 THEN p.amount END) as avg_rental_id,
    
    AVG(CASE WHEN (r.rental_id) = 12 THEN p.amount END) as avg_rental_id,
    AVG(p.amount) avg_rental
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id 
INNER JOIN payment p ON p.rental_id = r.rental_id AND p.customer_id = c.customer_id
GROUP BY c.customer_id, c.last_name, c.first_name;

#Use the case statement to create a new column classifying existing columns as either or high value transactions 
#based on the amount of payment. If the amount is between 0 and 2, 
#label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
SELECT
	r.customer_id, CONCAT(c.first_name, " ",  c.last_name) AS name, p.amount,
    CASE
		WHEN p.amount <2 THEN 'Low' 
        WHEN p.amount >=2 AND p.amount <4 THEN 'Medium'
        ELSE 'High'
        END AS payment_rating
FROM
	rental r
LEFT JOIN
	customer c ON c.customer_id = r.customer_id
LEFT JOIN
	payment p ON p.customer_id = r.customer_id
ORDER BY
	name ASC, p.amount ASC;

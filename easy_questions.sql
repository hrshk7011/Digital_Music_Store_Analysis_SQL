-- 1. Who is the senior most employee based on job title? 

select first_name, last_name from employee
order by levels desc
limit 1



-- 2. Which countries have the most invoices?

select billing_country, count(invoice_id) from invoice
group by billing_country
order by billing_country desc
limit 1

-- 3. What are top 3 values of total invoice?

select invoice_id, total from invoice
order by total desc
limit 3

/* 4. Which city has the best customers? We would like to throw a promotional 
We made the most money at the music festival in the city. Write a query that 
returns one city that has the highest sum of invoice totals. Return both the 
city name & sum of all invoice totals.*/

select billing_city, sum(total) as total_sum from invoice
group by billing_city
order by total_sum desc
limit 1

/* 5. Who is the best customer? The customer who has spent the most money 
will be declared the best customer. Write a query that returns the person 
who has spent the most money.*/

select customer.first_name|| ' ' ||customer.last_name as Customer_name, sum(invoice.total) as Total_spend from customer
join invoice on customer.customer_id = invoice.customer_id
group by Customer_name 
order by total_spend desc
limit 1


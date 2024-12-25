/* 1. Find how much amount spent by each customer on artist. Write a query 
to return customer name, artist name and total spent*/

select customer.first_name|| ' ' ||customer.last_name as Customer_name, artist.name as artist_name, sum(invoice_line.unit_price * invoice_line.quantity) as total_spent from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join album on track.album_id = album.album_id
join artist on album.artist_id = artist.artist_id
group by Customer_name, artist_name
order by Customer_name


/* 2. We want to find our the most popular music Genre for each country. We determine 
the most popular genre as the genre with the highest amount of purchases. Write a 
query that returns country along with the top genre. For countries where the 
maximum number of purchases is shared return all Genres */

WITH GenreSalesPerCountry AS (
select customer.country, genre.name as genre_name, count(invoice.invoice_id) as total_purchase from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
group by customer.country, genre_name 
order by customer.country asc ),

MaxGenreSalesPerCountry AS (
select country, MAX(total_purchase) AS max_purchase from GenreSalesPerCountry
group by country)
SELECT 
    GenreSalesPerCountry.country,
    GenreSalesPerCountry.genre_name,
    GenreSalesPerCountry.total_purchase
FROM GenreSalesPerCountry
JOIN MaxGenreSalesPerCountry
    ON GenreSalesPerCountry.country = MaxGenreSalesPerCountry.country
    AND GenreSalesPerCountry.total_purchase = MaxGenreSalesPerCountry.max_purchase
ORDER BY GenreSalesPerCountry.country ASC


/* 3. Write a query that determines the customer that has spent the most on 
music for each country. Write a query that returns the country along with the 
top customer and how much they spent. For countries where the top amount spent 
is shared, provide all customers who spent this amount.*/

WITH CustomerSpending AS (
    SELECT 
        customer.customer_id,
        customer.country,
        customer.first_name || ' ' || customer.last_name AS customer_name,
        SUM(invoice.total) AS total_spent
    FROM customer
    JOIN invoice ON customer.customer_id = invoice.customer_id
    GROUP BY customer.customer_id, customer.country, customer.first_name, customer.last_name
),
MaxSpendingPerCountry AS (
    SELECT 
        country,
        MAX(total_spent) AS max_spent
    FROM CustomerSpending
    GROUP BY country
)
SELECT 
    CustomerSpending.country,
    CustomerSpending.customer_name,
    CustomerSpending.total_spent
FROM CustomerSpending
JOIN MaxSpendingPerCountry
    ON CustomerSpending.country = MaxSpendingPerCountry.country
    AND CustomerSpending.total_spent = MaxSpendingPerCountry.max_spent
ORDER BY CustomerSpending.country ASC, CustomerSpending.customer_name ASC;

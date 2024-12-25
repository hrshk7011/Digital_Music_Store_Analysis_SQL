/* 1. Write query to return email, first name, last name, & Genre of all
Rock Music listeners. Return your list ordered alphabetically by email 
starting with A*/

select customer.email, customer.first_name, last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name = 'Rock'
group by customer.email, customer.first_name, customer.last_name
order by customer.email asc

/*Let's invite the artists who have written the most rock music in our 
dataset. Write a query that returns the Artist name and total track count 
of the top 10 rock bands*/
artist album track genre

select artist.name, count(track.track_id) as track_count from artist
join album on artist.artist_id = album.artist_id
join track on album.album_id = track.album_id
join genre on track.genre_id = genre.genre_id
where genre.name = 'Rock'
group by artist.name
order by track_count desc
limit 10


/*Return all the track names that have a song length longer than the 
average song length. Return the Name and Milliseconds for each track. 
Order by the song length with the longest songs listed first.*/

select track.name, milliseconds from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc





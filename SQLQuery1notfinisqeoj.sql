--a) Query the relevant tables to retrieve the year of invoice issuance and the genre of the track(s) sold on the invoice.
--b) Summarize the calculated net value of invoice items and quantity in separate columns based on the year and genre.
--c) Consider only those tracks that appear on at least one playlist.
--d) Exclude tracks that do not have a composer.
--e) Include in the list only tracks that are longer than the average length of tracks in the same genre.
--f.) Create a yearly recurring ranking in a new column for the list. Base the ranking on the total quantity sold 
--(higher quantity results in a better ranking). The ranking should follow the Olympic-style format.
--67 rows Last row: 2013	Electronica/Dance	0.99	1	10
select year(i.InvoiceDate) [Year], isnull(g.Name, '<Unknown>') [Genre],
sum(il.UnitPrice) [Net value], sum(il.Quantity) [Quantity],
rank() over (partition by year(i.invoicedate) order by sum(il.quantity) desc) [Rank] from track t
join Invoiceline il on t.TrackId = il.TrackId
join invoice i on il.InvoiceId = i.InvoiceId
join genre g on t.GenreId = g.GenreId
join PlaylistTrack pt on t.TrackId = pt.TrackId
where t.composer is not null
and t.trackid in (select trackid from PlaylistTrack pt where pt.TrackId = t.TrackId)
and t.Milliseconds >= all(select avg(Milliseconds) from track t2 where t.GenreId = t2.GenreId)
group by year(i.InvoiceDate), g.Name, il.Quantity
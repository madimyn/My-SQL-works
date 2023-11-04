--a) Create a list that includes the artist's name and the style's name.
--b) Display in two separate columns the count of tracks created by the 
--artist in each style and their total duration in minutes (aggregation). Round the minutes two .
--c) For tracks that do not have an associated style, use the text "Unknown."
--d) Include only those tracks that have been sold at least once.
--e) Place hierarchical subtotals and grand totals in the list, and label them accordingly.
--373 rows, last  two rows:
--Zeca Pagodinho	All from Zeca Pagodinho 	9	32.35
--All artists	All from all artists	1984	12657.70
select 
case when grouping(art.name) = 1 and grouping(g.Name) = 1 then 'All artists'
else isnull(art.name, 'CCCCCCC')
end [Artist],
case when grouping(g.name) = 1  and grouping(art.Name) = 0 then 'All from ' + art.name
when grouping(g.name) = 1 and grouping(art.Name) = 1 then 'All from all artists'
else isnull(g.Name, '<Unknown>')
end [Genre],
count(t.TrackId) [Tracks], 
round(sum(t.Milliseconds/1000.00/60), 2) [Duration] from track t
join album a on a.AlbumId = t.AlbumId
left join artist art on a.ArtistId = art.ArtistId
left join genre g on t.GenreId = g.GenreId
where t.TrackId in (select trackid from InvoiceLine)
group by rollup(art.name, g.Name)
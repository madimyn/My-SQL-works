--a) The list should include the track name, duration in minutes, net and gross 
--unit prices (the gross price is to be calculated with a 27% VAT rate, 
--and the track's duration is given in milliseconds � a whole number � which needs to be converted to minutes). 
--Name the columns accordingly. 
--b) Also, include the media type and artist's name, along with the album title. 
--c) Add a new column that shows the price per minute for each music track. 
--Ensure that the price per minute is a fractional number. Round the result to two decimal places. 
--d) In a separate column, indicate the category classification based on the cost per minute. 
--Less than half a dollar should be "Cheap," between half a dollar and five dollars should be "Average," 
--and above five dollars should be labeled as "Expensive."
--e) Include in the list only those tracks whose gross unit price (from part a) exceeds two. 
--f) Sort the list based on the artist and album title. 
--(213 rows)
select t.name as [Title], t.Milliseconds/1000.00/60 [Duration (m)], art.Name [Artist], 
a.Title [Album], mt.Name [Type], t.UnitPrice [Net price], t.UnitPrice * 1.27 [Gross price],
round(unitprice/(Milliseconds/1000.00/60), 2) [$/m],
case
when unitprice/(Milliseconds/1000.00/60) < 0.5 then 'Cheap'
when unitprice/(Milliseconds/1000.00/60) > 5.0 then 'Expensive'
else 'Average'
end [Class]
from Track t
join album a on t.AlbumId = a.AlbumId
join MediaType mt on t.MediaTypeId = mt.MediaTypeId
join Artist art on a.ArtistId = art.ArtistId
where UnitPrice * 1.27 > 2.00
order by art.Name, a.title
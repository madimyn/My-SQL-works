--Create a list of albums distributed by the company according to the following criteria:
--The list should include the name of the artist and the title of the album.
--In a new column, calculate the total length of the album's tracks in minutes.
--length is given in milliseconds and can be easily converted. Round the result to one decimal place.
--Ensure that the milliseconds column is an integer; division by an integer can result in data loss).
--Filter out the rows where the unit price is greater than one dollar.
--In a separate column, indicate how many music tracks are on the album.
--Remove albums from the result that have fewer than 5 music tracks.
select art.Name [Artist], a.Title [Album], round(sum(t.Milliseconds/1000.00/60), 1) [Duration], count(t.trackid) [Amount]
from artist art
join album a on a.ArtistId = art.ArtistId
join track t on t.AlbumId = a.AlbumId
where t.UnitPrice > 1.00
group by art.name, a.Title
having count(t.TrackId) >= 5
--a) Query the relevant tables by connecting the track's title, the corresponding album title,
--the artist's name, and the track's length in minutes!
--b) Attach the "playlisttrack" table, and in a separate column, indicate how many different playlists
--the track appears on. If a track doesn't appear on any playlist, display 0.
--c) Only consider music tracks where either the track title, artist's name,
--or album title contains the word "rock."
--d) Only consider tracks where the quantity is less than 3!
--e) Sort the list by album title in ascending order and by quantity in descending order!
select t.name [Title], t.Milliseconds/1000.00/60 [Duration], art.Name [Artist], a.Title [Album],
count(distinct pt.PlaylistId) [Appearances]
from track t
join album a on t.AlbumId = a.AlbumId
join artist art on art.ArtistId = a.ArtistId
left join PlaylistTrack pt on pt.TrackId = t.TrackId
where art.Name like '%rock%' or a.Title like '%rock%' or t.Name like '%rock%'
group by t.name, t.Milliseconds, art.Name, a.Title
having count(distinct pt.playlistid) < 3
order by a.title asc, count(distinct pt.playlistid) desc
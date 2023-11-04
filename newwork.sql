select distinct art.Name [Artist], a.Title as [Album], count(t.TrackId) [Num of tracks], sum(Milliseconds/1000.00/60) [Whole Duration] from track t
join album a on t.AlbumId = a.AlbumId
join artist art on a.ArtistId = art.ArtistId
group by art.name, a.Title
having sum(Milliseconds/1000.00/60) > 50
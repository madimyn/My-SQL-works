-- select p.name as playlistname,
-- (select t.trackid [track/@id], t.name as track from track t join PlaylistTrack pt on t.trackid = pt.trackid
-- where pt.PlaylistId = p.PlaylistId
-- for xml path(''), Type) as Tracks
-- from Playlist p
-- for xml path('Playlist'), root('Playlists')

select * from Employee
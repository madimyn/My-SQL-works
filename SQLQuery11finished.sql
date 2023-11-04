--a) Create a query that includes the track's ID, title, composer's name, the track's length in minutes,
--and the track's size in megabytes (1 megabyte = 1024 kilobytes, 1 kilobyte = 1024 bytes).
--b) Where there is no composer, display the text "No composer."
--Only include tracks in the list where the unit price falls between 1 and 2 dollars.
--c) Assume that tracks with multiple composers have commas or slashes in the composer column,
--but never both at the same time or in any specific order. Filter the list for these tracks.
--d) The replace function is suitable for replacing occurrences of one character with another.
--Its format is: replace(string, 'old occurrence', 'replace with this').
--Use it to calculate, how many slashes and commas are in the composer column.
--Add 1 to the result, and you will have an estimate of how many composers the track has.
--Display this in a new column.
--e) Create ranking based on the d.) subtask value, the tracks with the most composers should go first.
--The ranking should be Olympic ranking, with gaps when there is a tie.
select t.TrackId [ID], t.name [Title], isnull(t.Composer, 'No composer') [Composer],
t.Milliseconds/1000.00/60 [(m)], t.Bytes/1024.00/1024 [(mb)],
len(isnull(composer, '')) - len(replace(replace(composer, ',', ''), '/', '')) + 1 [Composer amount],
rank() over(order by len(isnull(composer, '')) - len(replace(replace(composer, ',', ''), '/', '')) + 1 desc)
from track t
where (t.UnitPrice between 1 and 2) 
and ((isnull(t.composer, '') like '%,%' and isnull(t.Composer, '') not like '%/%')
or (isnull(t.composer, '') like '%/%' and isnull(t.Composer, '') not like '%,%'))
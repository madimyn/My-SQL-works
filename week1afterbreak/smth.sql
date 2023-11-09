-- select 
-- EmployeeId [@id],
-- FirstName + ' ' + LastName as [Fullname],
-- isnull(City, 'No city') [Address/@City],
-- PostalCode [Address/PostalCode],
--  Address [Address/Address], Country [Address/Country]
-- from Employee E
-- order by BirthDate
-- for xml path('Employee'), root('Employees')

-- select
-- EmployeeId,
-- LastName,
-- Firstname,
-- PostalCode [Address.PostalCode],
-- city [Address.City],
-- Address [Address.Address] 
-- from Employee
-- where Employeeid  in (2, 11)
-- for json PATH

--select album.*, count(*) [num] 
--from album join track on album.AlbumId = track.AlbumId
--group by album.AlbumId, title, artistid

--select *, (select count(*) from track where track.AlbumId = album.AlbumId) [num] from album

--select g.name, count(*) [Count]  from genre g join track t on g.GenreId = t.GenreId  group by g.Name

--select genre.Name, (select count(*) from track where track.GenreId = genre.GenreId) [Num],
--isnull((select sum(milliseconds) from track where track.GenreId = genre.GenreId), 0) [Duration] from genre

--select *, (select top 1 name from track where track.AlbumId = album.AlbumId order by UnitPrice desc) from album

--select *  from (select * from Employee) as T

--select * from (select InvoiceId, invoicedate, Customerid, total, row_number() over (partition by year(invoicedate) order by invoicedate) [Months] from Invoice) as t where months = 1

-- select * from 
-- (select year(invoicedate) [Year], month(invoicedate) [Month], sum(total) [Total],
-- lag(sum(total)) over (order by year(invoicedate), month(invoicedate)) [Prevtotal] from invoice
-- group by year(invoicedate), MONTH(invoicedate)) as MonthlyIncome
-- where total < Prevtotal

-- select name [Album] from album join (select albumid, name from Track) as T ON album.AlbumId = T.AlbumId;
-- with MonthlyIncome as
-- (select year(invoicedate) [Year], month(invoicedate) [Month], sum(total) [Total],
-- lag(sum(total)) over (order by year(invoicedate), month(invoicedate)) [Prevtotal] from invoice
-- group by year(invoicedate), MONTH(invoicedate))
-- select * from MonthlyIncome

-- select * from (select track.Name, ROW_NUMBER() over (partition by milliseconds order by milliseconds desc) [Duration] from track) as t where Duration = 1

-- select p.name, 
-- (select track.name from track
-- join PlaylistTrack on PlaylistTrack.TrackId = track.TrackId
-- where PlaylistTrack.PlaylistId = p.PlaylistId
-- order by Milliseconds desc)
-- from Playlist p

-- select *, (select genre.name from genre join track t on t.GenreId = genre.GenreId
-- join InvoiceLine il on t.TrackId = il.TrackId
-- where il.InvoiceId = i.invoiceid) as Genrename 
-- from invoice i
-- where invoiceid in (select invoiceid from invoiceline group by invoiceid having count(*) = 1)

-- select g.name,
--  (select count(*) from track t
--   where t.GenreId = g.GenreId) [Count],
--    (select sum(Milliseconds)/1000.00/60 from track t
--     where t.GenreId = g.GenreId) [Duration] 
-- from genre g 

-- Query invoices, in a separate column indicate the total of the given customer's previous 
-- invoice. Filter to those invoices where the value is ten times the previous value (or greater)
-- select g.name, details.[Count],
--  details.[Sum] from genre g
--   join (select genreid, count(*) [Count],
--    sum(milliseconds) [Sum] from track 
--    group by genreid) as details
-- on g.GenreId = details.GenreId;
-- with details as
-- (select genreid, count(*) [Count],
-- sum(milliseconds) [Sum] from track
-- group by genreid)
-- select g.name, details.count, details.sum from genre g join details on g.GenreId = details.genreid

-- with ci AS
-- (select *, lag(total) over (partition by Customerid order by invoicedate) [prevtotal] from Invoice)
-- select * from ci where total >= prevtotal * 10

-- Count employees and customers by cities. The resultset should contain two columns.
-- select city, count(*) from 
-- (select Employeeid, city from Employee
-- union select customerid, city from customer) as T
-- group by city

-- Summarize total value by customerids and cities. Create a ranking based on the income 
-- partitioned by the city. Only indicate those customerids where the ranking is lower than 4.
-- select * from (select customerid, billingcity, sum(total) [Total],
-- rank() over (partition by billingcity order by sum(total) desc) [Rank] from Invoice
-- group by CustomerId, BillingCity) as T where t.Rank < 4

-- select i.invoiceid [@id], i.Invoicedate , c.LastName from invoice  i 
-- join customer c on i.CustomerId = c.CustomerId
-- for xml path('Invoice'), root('Invoices')

-- select i.invoiceid [@ID],
-- i.invoicedate [InvoiceDate],
-- c.LastName [Lastname],
-- (select t.name [Track], il.UnitPrice, il.Quantity from invoiceline il 
-- join track t on il.TrackId = t.TrackId 
-- where il.InvoiceId = i.InvoiceId
-- for xml path(''), TYPE) as Lines
-- from invoice i join Customer c on i.CustomerId = c.CustomerId
-- for xml path('Invoice'), root('Invoices')

select p.name as playlistname,
(select t.trackid [track/@id], t.name as track from track t join PlaylistTrack pt on t.trackid = pt.trackid
where pt.PlaylistId = p.PlaylistId
for xml path(''), Type) as Tracks
from Playlist p
for xml path('Playlist'), root('Playlists')
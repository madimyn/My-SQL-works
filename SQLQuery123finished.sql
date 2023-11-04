select
case when
  grouping(year(i.invoicedate))=1 then 'All years'
  else cast(year(i.invoicedate) as varchar(100))
end as YearOfTheSale,
case 
  when grouping(year(i.invoicedate))=1 and grouping(art.name)=1 then 'All years All artists'
  when grouping(art.name)=1 then 'All artists ' +cast(year(i.InvoiceDate) as varchar(100))
  else cast(art.name as varchar(100))
end as Artist,
year(i.InvoiceDate) as YearOfTheSale,art.name as Artist,
round(sum(il.Quantity*il.UnitPrice),0) as SumOfNetValue
from invoice i join invoiceline il on i.InvoiceId=il.InvoiceId join track t on il.TrackId=t.TrackId join Album a on a.AlbumId=t.AlbumId join Artist art on a.ArtistId=art.ArtistId join Genre g on g.GenreId=t.GenreId
where g.name like'%Metal%' and t.Composer is not null and BillingCountry<>'USA' and BillingCountry<>'Canada'
group by rollup(year(i.invoicedate),art.Name)
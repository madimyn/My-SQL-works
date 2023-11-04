--a) Query the invoice number and date.
--b) Join the tables containing invoice items and tracks and in two new columns,
--display the rounded sum of minutes and megabytes (1 megabyte = 1024 kilobytes, 1 kilobyte = 1024 bytes)
--for each invoice. Also, include the number of items in that invoice in one column. Name the columns appropriately.
--c) Only consider invoices issued in the last quarter of any year.
--d) Include in the list only invoices with more than one item.
--e) Sort the list by date and then by total minutes!
select i.InvoiceId [ID], i.InvoiceDate [Date], round(sum(t.Milliseconds/1000.00/60), 2) [(m)], 
round(sum(t.Bytes/1024.00/1024), 2) [Size], count(il.InvoiceLineId) [Amount]
from Invoice i
join InvoiceLine il on i.InvoiceId = il.invoiceid
join track t on t.TrackId = il.TrackId
where DATEPART(quarter, i.InvoiceDate) = 4
group by i.Invoiceid, i.InvoiceDate
having count(il.InvoiceLineId) > 1
order by i.InvoiceDate, sum(t.Milliseconds)
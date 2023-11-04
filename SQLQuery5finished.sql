--a) Query the postal code and city of the customers! If the postal code is not filled out, display "no data."
--b) Join invoices and invoice items, and calculate the total net value of the invoice items in a new column.
--(Net unit price* quantity). Name the column appropriately.
--c) In a separate column, also query how many different track IDs were involved in the purchases.
--Name the column appropriately.
--d) Exclude customers where the company name is filled out, and only include transactions from 2012 in the list!
--e) Remove from the list the cities where only one type of track was purchased.
select isnull(c.PostalCode, 'no data') [Code], c.City [City], sum(il.UnitPrice * il.Quantity) [Total NV], 
count(distinct t.trackid) [Track amount]
from customer c
join Invoice i on c.CustomerId = i.CustomerId
join invoiceline il on i.InvoiceId = il.InvoiceId
join track t on t.TrackId = il.TrackId
where c.Company is null and year(InvoiceDate) = 2012
group by c.PostalCode, c.City
having count(distinct il.trackid) > 1

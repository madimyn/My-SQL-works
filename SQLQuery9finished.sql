--a) Query the invoices table to retrieve the invoice number, issue date, and rounded total value.
--In a separate column, concatenate the city, state, and country in the following format: Toronto (ON) / Canada.
--If Billingsate is not specified, display it as Vienna/ Austria without parentheses!
--b) Create categories in a separate column based on the total value of the invoices.
--Invoices below $1 should be labeled as "Low-Value," those above $10 as "High-Value,"
--and the rest should be labeled as "Normal."
--c) Calculate the average total value of the invoices for the given country and year
--in a separate column for each row, and then display the difference between the current invoice
--and this average value. For example, if the average value is $4, and the current invoice is $2,
--the column should display -2.
--d) Include only those invoices in the list that were issued in the third or fourth quarter.
--e) Additionally, exclude invoices from the list that were issued as the sole invoice
--in their own country for the given year.
--f) Sort the list in descending order based on the difference (from task c).
select i.InvoiceId [ID], i.InvoiceDate [Issue Date], round(i.total, 0) [Total],
i.BillingCity + isnull(' ' + '(' + i.billingstate + ')', '') + ' / ' + i.BillingCountry,
case
when i.total < 1.00 then 'Low-Value'
when i.total > 10.00 then 'High-Value'
else 'Normal'
end [Category],
i.total - avg(i.total) over (partition by i.billingcountry, year(i.invoicedate)) [Total - Average]
from invoice i
where DATEPART(QUARTER, i.InvoiceDate) in (3, 4)
and exists(select * from invoice i2 where i2.BillingCountry = i.BillingCountry and i.InvoiceId <> i2.InvoiceId
and year(i.invoicedate) = year(i2.invoicedate))
order by i.total - avg(i.total) over (partition by i.billingcountry, year(i.invoicedate)) desc
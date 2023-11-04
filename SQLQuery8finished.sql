--a) Query the city of employees, along with their last name and first name concatenated.
--b) Join the customer table and, in a new column, indicate how many partners are managed by the representatives,
--grouped by the previously queried data (city, name).
--c) Include customers in the list who do not have a representative.
--In such rows, display "No representative" instead of the representative's name and "No city"
--instead of the city name.
--d) Display hierarchical subtotals and grand totals for the partner count.
--Include "Total" labels in rows where aggregation occurs.
select iif(grouping(e.city) = 1, 'Total', isnull(e.city, 'No city')) [City],
iif(grouping(isnull(e.firstname + ' ', '') + isnull(e.LastName, '')) = 1, 'Total',
iif(isnull(e.firstname + ' ', '') + isnull(e.LastName, '') = '', 'No representative',
isnull(e.firstname + ' ', '') + isnull(e.LastName, ''))) [Fullname], 
count(c.CustomerId) [Partners]
from Employee e
right join Customer c on c.SupportRepId = e.EmployeeId
group by rollup(e.city, isnull(e.firstname + ' ', '') + isnull(e.LastName, ''))
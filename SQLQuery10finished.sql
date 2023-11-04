--a) Create a query that concatenates employees' first and last names with their postal address information.
--Exclude all other columns. Display an additional column indicating how old each employee is or will be this year.
--b) In another column, specify how many people in the list were born in the same month as the current employee
--(excluding the current employee).
--c) In a separate column, categorize employees. Those whose email addresses do not contain the "@chinook"
--string should be categorized as "external," those who were hired within the last six months as "probationary,"
--and the rest should be categorized as "employee".
--d) In a separate column, display a ranking based on the number of years (from task a) for each category from
--task c), in descending order. The ranking should not contain gaps.
select isnull(e.FirstName + ' ', '') + isnull(e.lastname, '') + ' ' + e.PostalCode [Information],
DATEDIFF(year, e.BirthDate, getdate()) [Age], count(*) over (partition by month(e.birthdate)) - 1 [Same Month],
case
when e.Email not like '%@chinook%' then 'External'
when DATEDIFF(month, e.HireDate, GETDATE()) <= 6 then 'Probationary' 
else 'Employee'
end [Category],
dense_rank() over (partition by
case
when e.Email not like '%@chinook%' then 'External'
when DATEDIFF(month, e.HireDate, GETDATE()) <= 6 then 'Probationary' 
else 'Employee'
end 
order by DATEDIFF(year, e.BirthDate, getdate()) desc)
from Employee e
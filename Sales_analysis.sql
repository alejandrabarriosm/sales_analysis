/*SQL Review Exercise Template*/

Use BA710;

/*1. Which shippers do we have?
We have a table called Shippers. Return all the fields from all the shippers*/
select * from BA710.shippers;


/*2. Sales Representatives
We’d like to see just the FirstName, LastName, and HireDate of all the employees
with the Title of Sales Representative. Write a SQL statement that returns only 
those employees.*/
select FirstName, LastName, HireDate from BA710.employees
	where Title like 'Sales Representative';


/*3. Products with “queso” in ProductName
In the products table, we’d like to see the ProductID and ProductName 
for those products where the ProductName includes the string “queso”.*/
select ProductID, ProductName from BA710.products
	where ProductName like '%Queso%';

    
/*4. Orders shipping to France or Belgium
Looking at the Orders table, there’s a field called ShipCountry. 
Write a query that shows the OrderID, CustomerID, and ShipCountry 
for the orders where the ShipCountry is either France or Belgium.*/
select OrderID, CustomerID, ShipCountry from BA710.orders
	where ShipCountry in ('France', 'Belgium');


/*5. Employees, in order of age
For all the employees in the Employees table, show the FirstName, 
LastName, Title, and BirthDate. Order the results by BirthDate, 
so we have the oldest employees first.*/
select FirstName, LastName, Title, BirthDate from BA710.employees
	order by BirthDate;


/*6. Showing only the Date with a DateTime field
In the output of the query above, showing the Employees in order of BirthDate,
 we see the time of the BirthDate field, which we don’t want. Show only the 
 date portion of the BirthDate field.*/
select FirstName, LastName, Title, date(BirthDate) from BA710.employees
	order by date(BirthDate);


/*7. OrderDetails amount per line item
In the OrderDetails table, we have the fields UnitPrice and Quantity. 
Create a new field, TotalPrice, that multiplies these two together. 
We’ll ignore the Discount field for now.
In addition, show the OrderID, ProductID, UnitPrice, and Quantity. 
Order by OrderID and ProductID.*/
select OrderID, ProductID, UnitPrice, Quantity, UnitPrice*Quantity as TotalPrice from BA710.orderdetails;


/*8. How many customers?
How many customers do we have in the Customers table? Show one value only, 
and don’t rely on getting the record count at the end of a resultset.*/
select count(*) from BA710.customers;


/*9. When was the first order?
Show the date of the first order ever made in the Orders table.*/
select min(OrderDate) from BA710.orders;


/*10. Contact titles for customers
Show a list of all the different values in the Customers table for ContactTitles. 
Also include a count for each ContactTitle.*/
select ContactTitle, count(ContactTitle) as TotalContactTitle from BA710.customers
	group by ContactTitle;


/*11. Products with associated supplier names
We’d like to show, for each product, the associated Supplier. Show the ProductID,
 ProductName, and the CompanyName of the Supplier.
Sort the result by ProductID.
This question will require the Join clause in SQL. */
select a.ProductID, a.ProductName, b.CompanyName
	from BA710.products a
		inner join BA710.suppliers b
        on a.SupplierID = b.SupplierID;


/*12. Products that need reordering
What products do we have in our inventory that should be reordered? 
For now, just use the fields UnitsInStock and ReorderLevel, 
where UnitsInStock is less than or equal to the ReorderLevel, 
Ignore the fields UnitsOnOrder and Discontinued.
Sort the results by ProductID.*/
select ProductID, ProductName, UnitsInStock, ReorderLevel
	from BA710.products
    where UnitsInStock <= ReorderLevel
    order by ProductID;


/*13. High freight charges
Some of the countries we ship to have very high freight charges. 
We'd like to investigate some more shipping options for our customers, 
to be able to offer them lower freight charges. Return the three ship countries 
with the highest average freight overall, in descending order by average freight.*/
select ShipCountry, avg(Freight) as AverageFreight
	from BA710.orders
    group by ShipCountry
    order by AverageFreight desc
    limit 3;

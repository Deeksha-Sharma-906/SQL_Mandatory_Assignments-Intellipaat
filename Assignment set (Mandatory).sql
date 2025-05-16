====================================================================================================================================================================
--Assignment 1 & 2
====================================================================================================================================================================

-- create database Sales_Order_Processing_System;
create database Assignments

use Assignments;

/*Add Primary key constraint for SalesmanId column in Salesman table. Add default
constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
column in Customer table. Add not null constraint in Customer_name column for the
Customer table*/

create table Salesman (
"Salesmanld" int not null Primary Key,
"SalesmanName" varchar(50),
"Commission" int,
"City" varchar(50) default 'USA',
"Age" int
);

select *from Salesman

insert into Salesman Values
(101,'John',50,'California',17),
(102,'Simon',75,'Texas',25),
(103,'Jessie',105,'Florida',35),
(104,'Danny',100,'Texas',22),
(105,'Lia',65,'New Jersy',30);


insert into Salesman values 
(107, 'Temp Salesman 1', 0, 'Unknown', 0),
(110, 'Temp Salesman 2', 0, 'Unknown', 0);

-- drop table Customer

create table Customer (
"Salesmanld" int foreign key References Salesman(Salesmanld),
"Customerld" int,
"CustomerName" varchar(50) not null,
"PurchaseAmount" int
);

select *from Customer

insert into Customer Values
(101,2345,'Andrew',550),
(103,1575,'Lucky',4500),
(104,2345,'Andrew',4000),
(107,3747,'Remona',2700),
(110,4004,'Julia',4545);

insert into Customer Values
(102,2345,'Eden',550),
(105,1575,'Lucy',4500);

create table orders(
"Orderld" int not null,
"Customerld" int,
"Salesmanld" int,
"OrderDate" date,
"Amount" int);

select * from orders

-- Insert a new record in your Orders table

insert into orders values
(5001,2345,101,'2021-07-04', 550),
(5003,1234,105,'2022-02-15',1500);


insert into orders values
(5002,3747,107,'2023-01-30',1500);

select * from orders
select *from Customer
select *from Salesman


-- Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase amount value greater than 500
select * from Customer
where CustomerName like '%w'
AND PurchaseAmount >500
order by Customerld

/*Using SET operators, retrieve the first result with unique SalesmanId values from two
tables, and the other result containing SalesmanId with duplicates from two tables.*/

select Salesmanld from Salesman
unioun
select Salesmanld from orders

select Salesmanld from Salesman
intersect
select Salesmanld from orders

/*Display the below columns which has the matching data. 
Orderdate, Salesman Name, Customer Name, Commission, and City which has the range of Purchase Amount between 500 to 1500.*/

select OrderDate from orders

SELECT 
    o.OrderDate,
    s.SalesmanName,
    c.CustomerName,
    s.Commission,
    s.City
FROM 
    orders o
JOIN 
    Salesman s ON o.Salesmanld = s.Salesmanld
JOIN 
    Customer c ON o.Customerld = c.Customerld AND o.Salesmanld = c.Salesmanld
WHERE 
    c.PurchaseAmount BETWEEN 500 AND 1500;


-- Using right join fetch all the results from Salesman and Orders table.
select * from Salesman
right join orders
on Salesman.Salesmanld = orders.Salesmanld



========================================================================================================================================================================
--Assignment 3 & 4
========================================================================================================================================================================
select * from Jomato

SELECT COUNT(*) FROM Jomato

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Jomato';


--  Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’.

CREATE FUNCTION dbo.fn_StuffChicken (@RestaurantType VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Result VARCHAR(100)

    -- Check if 'Quick Bites' is in the string, and replace it
    IF @RestaurantType = 'Quick Bites'
        SET @Result = 'Quick Chicken Bites'
    ELSE
        SET @Result = @RestaurantType  -- leave as is if it doesn't match

    RETURN @Result
END


SELECT 
    OrderId,
    RestaurantName,
    dbo.fn_StuffChicken(RestaurantType) AS ModifiedRestaurantType,
    Rating,
    [No of Rating],
    AverageCost,
    OnlineOrder,
    TableBooking,
    CuisinesType,
    Area,
    LocalAddress,
    [Delivery time]
FROM 
    Jomato;


-- Use the function to display the restaurant name and cuisine type which has the maximum number of rating
	
SELECT 
    RestaurantName,
    CuisinesType,
    dbo.fn_StuffChicken(RestaurantType) AS ModifiedRestaurantType,
    [No of Rating]
FROM 
    Jomato
WHERE 
    CAST([No of Rating] AS INT) = (
        SELECT MAX(CAST([No of Rating] AS INT)) FROM Jomato
    )

--
/*
Create a Rating Status column to display the rating as:
‘Excellent’ if it has more the 4 start rating, 
‘Good’ if it has above 3.5 and below 4 star rating, 
‘Average’ if it is above 3 and below 3.5 and 
‘Bad’ if it is below 3 star rating 
*/

select * from Jomato

alter table Jomato add Rating_Status float;

update Jomato
set Rating_Status =
(case
when Rating > 4 then 'Excellent'
when Rating > 3.5 then 'Good'
when Rating >3 then 'Average'
else 'Bad'
end)


-- For example:
CREATE TABLE employee_info
( Employee_id INT,
First_Name VARCHAR(25),
Last_Name VARCHAR(25),
Salary INT,
City VARCHAR(20)); 

INSERT INTO employee_info
VALUES (1,'Monika','Singh',800000,'Nashik'),
(2,'Rahul','Kumar',450000,'Mumbai'),
(3,'Sushant','Kumar',500000,'Pune'),
(4,'Ajay','Mehta',600000,'Mumbai');

select * from employee_info

select First_Name, Last_Name, concat(First_Name,' ',Last_Name) as Customer_Name from employee_info;

alter table employee_info add CustomerName varchar(50);

UPDATE employee_info
SET CustomerName = First_Name + ' ' + Last_Name;

-- Find the Ceil, floor and absolute values of the rating column and display the current date and separately display the year, month_name and day.
select * from Jomato

select 
Rating, 
CEILING(Rating) AS 'Ceil_Value', 
Floor(Rating) AS 'Floor_Value', 
ABS(Rating) As 'Absolute_value'
from Jomato;


select getdate() as 'Today'

SELECT DATEPART(mm, GETDATE()) as theMonth  
SELECT DATEPART(dd, GETDATE()) as theDay   
SELECT DATEPART(yy, GETDATE()) as theYear  


-- Display the restaurant type and total average cost using rollup.

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Jomato' ;

ALTER TABLE Jomato
Alter COLUMN AverageCost float;

select RestaurantType, sum(AverageCost) As 'RolledUp_Value' from Jomato
Group by RestaurantType


========================================================================================================================================================================
--Assignment 5 & 6
========================================================================================================================================================================

--Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero.

select * from Jomato

create Procedure NoZeroBooking
AS
Begin
select RestaurantName, RestaurantType, CuisinesType, TableBooking from Jomato
where TableBooking = 'Yes' 
End;

Exec NoZeroBooking

--Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.
begin Transaction
	update Jomato set CuisinesType = 'Cafeteria'
	where CuisinesType = 'Cafe'
	commit transaction
	print 'Transaction Committed'

rollback;

-- Generate a row number column and find the top 5 areas with the highest rating of restaurants.

WITH RankedRestaurants AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Area ORDER BY Rating DESC) AS RowNum
    FROM Jomato
)
SELECT *
FROM RankedRestaurants
WHERE RowNum <= 5;

--Use the while loop to display the 1 to 50.

DECLARE @num int
set @num =1
while(@num <=50)
begin
	print @num
	set @num = @num + 1
end


-- Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants
select * from Jomato

create view TopRatings
As
WITH RankedRestaurants AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Area ORDER BY Rating DESC) AS RowNum
    FROM Jomato
)
SELECT *
FROM RankedRestaurants
WHERE RowNum <= 5;

--  Create a trigger that give an message whenever a new record is inserted.

CREATE TRIGGER RestaurantInsertedTrigger
ON Jomato
AFTER INSERT
AS
BEGIN
    PRINT 'A new record has been inserted into the Jomato1 table.';
END;
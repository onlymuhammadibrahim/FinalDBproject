Use [EOT]


/*
--Query 1. Name of Most Sold Product Offline

Create Table Temp
(IteId int,IteName varchar(50))
Insert Into Temp
SELECT Sale_Product.IteId, Item.IteName
FROM Sale_Product
INNER JOIN Item ON Sale_Product.IteId=Item.IteId
SELECT       top 1 IteId,IteName,COUNT(IteId) AS Number_of_Sales
    FROM     Temp
    GROUP BY IteId,IteName
    ORDER BY Number_of_Sales  DESC
Drop Table Temp

--Query 2. Most bought product by any particular customer online

Create Table Temp
(CarId int,IteId Int,cp int)
Insert Into Temp
Select *
From Cart_Product 
Where CarId = Any(Select CarId From Cart where CusId=68)
SELECT       top 1 IteId,COUNT(IteId) AS Number_of_Times
    FROM     Temp
    GROUP BY IteId
    ORDER BY Number_of_Times  DESC
Drop Table Temp

--Query 3. Which Employee has most bad reviews

Create Table Temp(s int, z int)
insert into Temp
SELECT       top 1 ShiId,COUNT(ShiId) AS Number_of_Shifts
    FROM     Review
    GROUP BY ShiId
    ORDER BY Number_of_Shifts  DESC
select EmpId,EmpName
From Employee
Where EmpId= Any(select EmpId From Shift where ShiId = Any(select s from Temp))
Drop table Temp

--Query 4. Which Customer odered highest amount of all the Items till data.

Select CusId
From Cart
Where CarId = Any(Select CarId From Cart_Product 
Where CarPQuantity = Any(Select max(CarPQuantity) 
as Highest_amount From Cart_Product))

--Query 5. Which branch has most sales. 


Create Table Temp(s int, z int)
insert into Temp
SELECT top 1 ShiId,COUNT(ShiId) AS Number_of_Times FROM Sale GROUP BY ShiId ORDER BY Number_of_Times  DESC
Select BraId From Branch Where BraId = Any(Select BraId From Employee Where EmpId = Any
(Select EmpId From Shift Where ShiId = Any(select s from Temp)))
Drop Table Temp 

--Query 6. Name of Customer with most Purchases.

Create Table Temp
(c int,z int)
Insert Into Temp
SELECT       top 1 CusId,COUNT(CusId) AS Number_of_Times
    FROM     Customer_Branch
    GROUP BY CusId
    ORDER BY Number_of_Times  DESC
Select CusName From Customer Where CusId = Any(Select c From Temp)
Drop Table Temp

--Query 7. Most Shopped Product Online.


SELECT       top 1 IteId,COUNT(IteId) AS Number_of_Times
    FROM     Cart_Product
    GROUP BY IteId
    ORDER BY Number_of_Times  DESC

--Query 8. Which customer shopped online most

SELECT       top 1 CusId,COUNT(CusId) AS Number_of_Times
    FROM     Cart
    GROUP BY CusId
    ORDER BY Number_of_Times  DESC


--Query 9. Sale between certain time period

Select Count(SalId) as Total_Sales
From Sale
Where SalDateTime >='2018-05-08 12:35:29'
And SalDateTime <= '2019-01-01 12:35:29'

--Query 10. Quantity of items in particular Branch

Select IteAmount,IteName
From Item 
Where IteId = Any(Select IteId from Item_Branch where BraId = 5)

--Query 11. Total Bill of offline Purchace of specific Sale ID

Create Table Temp(x int ,y int, z int, a int)
Insert Into Temp
SELECT Sale_Product.SalId,Sale_Product.IteId, Sale_Product.SalPQuantity, Item.ItePrice
FROM Sale_Product
INNER JOIN Item ON Sale_Product.IteId=Item.IteId;
Select sum(z*a) as Total_Bill From Temp Where x = 85
Drop Table Temp

--Query 12. Shift history of particular employ name

Select * From Shift_History Where ShiId = 
Any(Select ShiId From Shift Where EmpId = 
Any(Select EmpId From Employee Where EmpName = 'Skyler York'))

--Query 13. Name of employ who recieved most stock
Create Table Temp(x int,y int)
Insert Into Temp
SELECT       top 1 ShiId,COUNT(ShiId) AS Number_of_Shifts
    FROM     Stock
    GROUP BY ShiId
    ORDER BY Number_of_Shifts  DESC
Select EmpName From Employee Where EmpId = Any(Select EmpId From Shift Where ShiId = Any(Select y From Temp))
Drop Table Temp



--Query 15. Most online orders by any customer

SELECT       top 1 CusId,COUNT(CusId) AS Number_of_Online_Orders
    FROM     Cart
    GROUP BY CusId
    ORDER BY Number_of_Online_Orders  DESC

--Query 16. Most Bad Reviews For a Branch
*/



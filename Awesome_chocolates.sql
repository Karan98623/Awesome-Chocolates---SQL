SHOW TABLES;
/* see all tables */
desc sales;
-- describe sales table--

SELECT * FROM sales;
SELECT * FROM geo;
SELECT * FROM people;
SELECT * FROM products;
#see all tables

SELECT saledate, amount, boxes, amount/boxes as Box_Price FROM sales ORDER BY Box_Price DESC;
#Highest priced Box

SELECT count(*) FROM sales;
#Number of sales made

SELECT * FROM products ORDER BY Cost_per_box DESC;
#Shows the box with Highest cost

SELECT * FROM sales WHERE amount > 10000;
#High ticket sales

SELECT * FROM sales WHERE amount > 10000 ORDER BY amount DESC;
#Highest sale

SELECT COUNT(*) FROM sales WHERE amount > 10000;
#count of high ticket transactions

SELECT spid,Amount,Boxes,weekday(SaleDate) as 'Day of Week' FROM sales
WHERE weekday(SaleDate) = 0;
# Sales made on Monday

SELECT * FROM people;

SELECT Salesperson,Team FROM people
WHERE Team IN ('Yummies');
# People in Yummies team

SELECT COUNT(*)Salesperson FROM people
WHERE Salesperson LIKE 'k%';
#count of sales persons with names staring with k

SELECT SaleDate, Boxes, Amount,
CASE WHEN Amount < 1000 THEN 'Small Ticket'
     WHEN Amount < 10000 THEN 'Medium Ticket'
     ELSE 'High Ticket'
END as 'Order Value'
FROM sales;
#categorise amount into High, Low and Medium Tickets

SELECT p.Salesperson, s.SaleDate, s.Amount  FROM
sales s INNER JOIN people p 
ON s.spid = p.spid
ORDER BY s.Amount DESC;
#Inner Join applied on sales and people tables

#Showing sales made by every team and Individual contributors 
SELECT p.Team, p.Salesperson, pr.Product, s.Amount, s.SaleDate 
FROM sales s JOIN people p ON s.spid = p.spid
JOIN products pr ON pr.pid = s.pid
WHERE p.Team = '';

SELECT p.Team, p.Salesperson, pr.Product, s.Amount, s.SaleDate 
FROM sales s JOIN people p ON s.spid = p.spid
JOIN products pr ON pr.pid = s.pid
WHERE p.Team = 'Yummies';

SELECT p.Team, p.Salesperson, pr.Product, s.Amount, s.SaleDate 
FROM sales s JOIN people p ON s.spid = p.spid
JOIN products pr ON pr.pid = s.pid
WHERE p.Team = 'Jucies';

SELECT p.Team, p.Salesperson, pr.Product, s.Amount, s.SaleDate 
FROM sales s JOIN people p ON s.spid = p.spid
JOIN products pr ON pr.pid = s.pid
WHERE p.Team = 'Delish';


#Top 3 Performers across all teams
SELECT p.Salesperson,sum(s.Amount) as 'Total Amount'
FROM sales s JOIN people p
WHERE s.SPID = p.SPID AND s.SaleDate BETWEEN '2022-03-01' AND '2022-03-31'
GROUP BY s.SPID
ORDER BY sum(s.Amount) DESC
LIMIT 3;

#TOP 5 products sold
SELECT pr.Product, sum(s.Amount) as 'Total_Amount', sum(s.Boxes) as 'Total_Boxes' FROM
sales s JOIN products pr ON s.pid = pr.pid
GROUP BY pr.Product
ORDER BY sum(s.Amount) DESC
LIMIT 5;

SELECT g.geo, sum(s.Amount) as 'Total_Amount', sum(s.Boxes) as 'Total_Boxes', 
COUNT(s.Customers) as 'Count_Customers' FROM
sales s JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.geo
ORDER BY 'Total_Amount';
#Country-wise sale
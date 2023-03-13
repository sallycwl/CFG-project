Create database HMV;

Use HMV;

-- EMPLOYEES TABLE
CREATE TABLE Employees(
EmployeesID Varchar(50), 
First_Name VARCHAR(50), 
Last_Name VARCHAR(50), 
Department VARCHAR(50), 
Date_of_Birth date,
KPI Varchar(50),
PRIMARY KEY (EmployeesID)
);

INSERT INTO Employees
(EmployeesID, First_Name, Last_Name, Department, Date_of_Birth, KPI)
VALUES
('E01', 'Ross', 'Geller', 'Sales', '1992-05-14', 'exceed'),
('E02', 'Chandler', 'Bing', 'Marketing', '1994-02-15', 'Pass'),
('E03', 'Joey', 'Tribbiani', 'Marketing', '1995-12-21', 'Pass'),
('E04', 'Rachel', 'Green', 'Marketing', '1995-01-26','Pass'),
('E05', 'Phoebe','Buffay','Sales','1993-03-03', 'Exceed'),
('E06', 'Monica','Geller','Sales','1996-12-06', 'Substandard'),
('E07', 'Otis','Milburd','Marketing','1995-06-05', 'Exceed');

-- PRODUCTS TABLE
CREATE TABLE Products
(PID VARCHAR (30) NOT NULL,
Product_type VARCHAR(50),
Product_name VARCHAR(50),
Product_prices DEC,
Product_desc VARCHAR(50) NULL,
PRIMARY KEY(PID)
);

INSERT INTO Products
(PID, product_type, product_name, product_prices, product_desc)
VALUES
('F01', 'Film', 'Spider_Man_No_Way_Home', '20.00', NULL),
('F02', 'Film', 'Breaking_Bad_Box_set', '65.00', NULL),
('M01', 'Musical', 'Queen_Classic_Collection', '175.00', NULL),
('MO2', 'Musical', 'Harry_Styles__Harrys_House_Vinyl','33.00', NULL),
('V01', 'Videogame', 'Switch_Animal_Crossing_Bundle', '55.00', 'Bundle_package'),
('V02', 'Videogame', 'Logitech_G_Astro_Gaming_Headset','250.00', 'Videogame_accessories')
;

-- CUSTOMERS TABLE
CREATE TABLE Customers
(CID VARCHAR(30) NOT NULL,
first_name VARCHAR(50),
last_name VARCHAR(50),
customer_address VARCHAR(100),
customer_phone_number BIGINT,
customer_email_address VARCHAR(100),
date_of_birth DATE,
country VARCHAR(50),
PRIMARY KEY(CID)
);


INSERT INTO Customers
(CID, first_name, last_name, customer_address, customer_phone_number, customer_email_address, date_of_birth, country)
VALUES
('C01', 'Toni', 'Desouza', '71_Lime_Way', '07135678101', 'toni_desouza@gmail.com', '1996-04-21', 'United Kingdom'),
('C02', 'Emily', 'Johnson', '1_Brown_Avenue', '07456894613', 'emilyj@live.com', '2005-12-31', 'Ireland'),
('C03', 'Nardia', 'Thompson', '45_Banks_Road', '07396583624', 'nthompson@outlook.com', '1978-01-06', 'Scotland'),
('C04', 'Jane', 'Miller', '100_Downing_Street', '07568563829', 'janemiller@gmail.com', '1990-10-16', 'United Kingdom'),
('C05', 'Chris', 'smith', '56_Rodeo_Blvd', '4559845', 'c.smith@outlook.com', '2000-04-07', 'United States');

-- LATER ADDED COLUMN
ALTER TABLE Customers
ADD column delivery_fee decimal(10,3);

UPDATE Customers
SET delivery_fee = 0.00
WHERE country = "United Kingdom";

UPDATE Customers
SET delivery_fee = 4.99
WHERE country LIKE "%land";

UPDATE Customers
SET delivery_fee = 9.99
WHERE Country = "United States";

-- PRODUCTS TABLE
CREATE TABLE Products
(PID VARCHAR (30) NOT NULL,
Product_type VARCHAR(50),
Product_name VARCHAR(50),
Product_prices DEC,
Product_desc VARCHAR(50) NULL,
PRIMARY KEY(PID)
);

INSERT INTO Products
(PID, product_type, product_name, product_prices, product_desc)
VALUES
('F01', 'Film', 'Spider_Man_No_Way_Home', '20.00', NULL),
('F02', 'Film', 'Breaking_Bad_Box_set', '65.00', NULL),
('M01', 'Musical', 'Queen_Classic_Collection', '175.00', NULL),
('MO2', 'Musical', 'Harry_Styles__Harrys_House_Vinyl','33.00', NULL),
('V01', 'Videogame', 'Switch_Animal_Crossing_Bundle', '55.00', 'Bundle_package'),
('V02', 'Videogame', 'Logitech_G_Astro_Gaming_Headset','250.00', 'Videogame_accessories')
;

-- Error occured when copy and pasting the tables from Google Doc
-- Had to update the products table as the 0 and O were swapped
UPDATE Products
SET PID = "M02"
WHERE Product_Prices= 33 and Product_Name = "Harry_Styles__Harrys_House_Vinyl";


-- ORDERS TABLE
CREATE TABLE Orders(
    ID VARCHAR(30) NOT NULL,
    PID VARCHAR(30) NOT NULL,
    CID VARCHAR(30) NOT NULL,
    OrderDate DATE,
    Amount DECIMAL,
    EID VARCHAR(30) NOT NULL,
    Country VARCHAR(3),
    PRIMARY KEY (ID),
    FOREIGN KEY (EID) REFERENCES Employees(employeesID),
    FOREIGN KEY (CID) REFERENCES Customers(CID),
    FOREIGN KEY (PID) REFERENCES Products(PID));

Insert into Orders
(ID, PID, CID, OrderDate, Amount, EID, Country)
Values 
("HMV001", "V01", "C01", '2022-12-22', 55, "E01", "UK"),
("HMV002", "F01", "C02", '2022-12-15', 20, "E06", "UK"),
("HMV003", "M02", "C03", '2022-12-16', 33, "E01", "US"),
("HMV004", "F02", "C04", '2022-12-05', 65, "E05", "AUS"),
("HMV005", "M01", "C05", '2022-12-18', 175, "E05", "CA"),
("HMV006", "V02", "C01", '2023-01-20', 45, "E01", "UK"),
("HMV007", "V01", "C03", '2023-01-20', 55, "E06", "US"),
("HMV008", "M02", "C02", '2023-01-24', 33, "E05", "UK"),
("HMV009", "F02", "C01", '2023-01-05', 65, "E07", "UK");

-- Temporaily disabled the Foreign Key checks as there was an error:
-- "Cannot add or update a child row: a foreign key constraint fails"
SET FOREIGN_KEY_CHECKS=0;

-- Restarted the FK check
SET FOREIGN_KEY_CHECKS=1;


-- INVENTORY TABLE
Create table Inventory(
PID Varchar(30) NOT NULL,
Product_name varchar(100),
Stock_amount int(30),
FOREIGN KEY(PID) References Products(PID)
);

Insert into Inventory
(PID, Product_Name, Stock_amount) 
Values
('F01', 'Spider_Man_Toy', 20), 
('F02', 'Breaking_Bad_Box_Set', 8),
('M01', 'Queen_Classic_Collection', 30),
('M02', 'Harry_Styles_Harrys_House_Vinyl', 40),
('V01', 'Switch_Animal_Crossing_Bundle', 70),
('V02', 'Logitech_G_Astro_Gaming_Headset', 65);

-- PAYMENT TABLE
CREATE TABLE Payment(
OrderID Varchar(50), 
Payment_Date date, 
Total_Amount decimal,
Via varchar(50),
Country varchar(50),
FOREIGN Key(OrderID) References Orders(ID)
);

INSERT INTO Payment
(OrderID, Payment_Date, Total_Amount, Via, Country)
VALUES
('HMV001', '2022-05-14', 55,'PayPal','UK'),
('HMV002', '2022-12-15', 20,'PayPal','UK'),
('HMV003', '2022-12-16', 33,'Debit_and_CC','US'),
('HMV004', '2022-12-05', 65,'PayPal','AUS'),
('HMV005', '2022-12-18', 175,'PayPal','CA'),
('HMV006', '2023-01-20', 250,'PayPal','UK'),
('HMV007', '2023-01-20', 55,'PayPal','US'),
('HMV008', '2023-01-24', 33,'PayPal','UK'),
('HMV009', '2023-01-25', 65,'PayPal','UK');


SELECT * FROM Inventory;
SELECT * FROM Orders;
SELECT * FROM Employees;
SELECT * FROM Payment;
SELECT * FROM Customers;
SELECT * FROM Products;


-- --------------------------------------------------------------------------------------

-- Query example:
-- Find the CID of customers who spent more than £80 Each month
-- Group by CID, Month and Year
-- Having sum(amount) > SUBQUERY - AVERAGE/ £80

SELECT CID, month(OrderDate) as "Month", Year(OrderDate) as "Year" , 
sum(amount) AS "Total Spent"
FROM ORDERS 
GROUP BY CID,  Month, Year 
HAVING Sum(amount) > 80
ORDER BY CID ASC, Year DESC, Month ASC; 


-- Joined View - Payment & Orders & Employee & Products & Customer
-- Show the Order ID, customer ID, name
-- showing the type of products, price of that product, payment method
-- along with the employee's name who is in charge of that sale

SELECT o.ID, o.CID, Concat(c.first_name," ",c.last_name) AS "Customer_Name",
p.product_name, p.Product_type, CONCAT('£', FORMAT(o.Amount, 1)) as "price",
pa.via AS "Payment Method",
concat(e.first_name," ",e.last_name) AS "Sales In Charge"
FROM Orders o
INNER JOIN Customers c
on o.CID = c.CID
INNER JOIN Products p
on o.PID = p.PID
INNER JOIN Payment pa
on o.ID = pa.OrderID
INNER Join Employees e
on o.EID = e.employeesID
ORDER BY o.ID ASC;



-- Subquery to find the avg salary between marketing employees,
-- And those who earn less and more than the average salary in marketing department. 

select avg(salary) from employees
where department = 'marketing';

select first_name,last_name from employees
where department = 'marketing' and salary < (
select avg(salary) from employees
where department = 'marketing');

select first_name,last_name from employees
where department = 'marketing' and salary > (
select avg(salary) from employees
where department = 'marketing');




-- Stored Procedure To insert values into product table Bonus to employee who exceeds the KPI 
select first_name, last_name
from employees
where KPI = 'Exceed';


DELIMITER // 
CREATE PROCEDURE KPI_result(congratulations_you_are_getting_bonuses VARCHAR(50), first_name VARCHAR(50),last_name VARCHAR(50))
BEGIN	
	DECLARE fullgreeting VARCHAR(100);
	set fullgreeting = (CONCAT(congratulations_you_are_getting_bonuses));
	select fullgreeting;

END//
DELIMITER ;

call KPI_result('congratulations_you_are_getting_bonuses', 'phoebe',' buffay');
DELIMITER //;


-- TRIGGER EXAMPLE - Customers who lives in the UK gets free delivery
DELIMITER //
CREATE TRIGGER update_delivery_fee
AFTER INSERT ON customers
FOR EACH ROW

BEGIN
IF NEW.country = 'United Kingdom'
THEN SET NEW.delivery_fee = 0;
RETURN(customer_status);
END IF;
RETURN(DELIVER_FEE);
END //
DELIMITER ;




-- can Join Employees, orders,
-- Employee name with the highest sales amount, and the type of products they are usually in charge of
SELECT EmployeesID, First_Name, Last_Name, Department, CONCAT('£', FORMAT(sum(amount), 1)) as "Total_Sales"
FROM Employees e
INNER JOIN Orders O
ON e.EmployeesID = o.EID 
GROUP BY EmployeesID
ORDER BY sum(amount) DESC;










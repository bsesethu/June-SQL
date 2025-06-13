create database Data_Class
use data_class

-- Sample dataset creation
CREATE TABLE Products (
    ProductID INT,
    Description VARCHAR(255)
);

INSERT INTO Products (ProductID, Description)
VALUES 
(1, 'Wireless USB Mouse'),
(2, 'Bluetooth Speaker'),
(3, 'USB-C to HDMI Adapter'),
(4, 'Gaming Keyboard with USB Port'),
(5, 'HDMI Cable');

-- 1. Locate position of 'USB' in each description
SELECT 
    ProductID,
    Description,
    CHARINDEX('USB', Description) AS USB_Position
FROM Products;

--print only 'wireless'
SELECT * FROM Products;

SELECT SUBSTRING('Wireless USB Mouse', 10, 3) FROM Products;

SELECT SUBSTRING(Description, 10, 3) FROM Products;

SELECT LEFT(Description, 8)
FROM Products
WHERE ProductID = 1;

SELECT RIGHT(Description, 22)
FROM Products
WHERE ProductID = 1;

SELECT LEFT(RIGHT(Description, 22), 18)
FROM Products
WHERE ProductID = 1;


-- 2. Extract substring from 'USB' to the end of the description
SELECT 
    ProductID,
    Description,
    SUBSTRING(Description, CHARINDEX('USB', Description), LEN(Description)) AS USB_Section
FROM Products
WHERE CHARINDEX('USB', Description) > 0;

-- 3. Combine CHARINDEX and SUBSTRING with CONCAT for formatted result
SELECT 
    ProductID,
    Description,
    CONCAT('Found USB at position ', CHARINDEX('USB', Description), 
           '. Extracted text: ', 
           SUBSTRING(Description, CHARINDEX('USB', Description), LEN(Description))
    ) AS OutputSummary
FROM Products
WHERE CHARINDEX('USB', Description) > 0;

create table Pandamart(
sku_id Serial PRIMARY KEY,
category VARCHAR(100),
name VARCHAR(100) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INT,
discountedSellingPrice NUMERIC(8,2),
weightInGms INT,
outOfStock BOOLEAN,
quantity INT
);
--count of rows
SELECT COUNT (*) FROM Pandamart;
--Looking data
SELECT * FROM Pandamart
limit 10;
--null values
SELECT *
FROM Pandamart
WHERE category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;
--different Product Categories 
SELECT  distinct category
from Pandamart 
order by category;
--Product in stock vs product out of stock
SELECT outOfStock, COUNT(sku_id) AS total_products
FROM Pandamart
GROUP BY outOfStock;
--Product name present multiple times
SELECT name, COUNT(sku_id) AS "NUMBER OF SKUS"
from Pandamart
GROUP BY name
HAVING count(sku_id)>1
ORDER BY count(sku_id) DESC;
--Data cleaning 
SELECT * from Pandamart
where mrp=0 or discountedSellingPrice=0;
DELETE from Pandamart 
where mrp=0;
--converting paise to rupees
UPDATE Pandamart
SET mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0;
SELECT mrp,discountedSellingPrice from Pandamart;
--Top 10 best discount percent values?
SELECT DISTINCT name ,mrp, discountPercent
FROM Pandamart
ORDER BY discountPercent DESC
--high product mrp but out of stock?
SELECT name, mrp, discountPercent
FROM Pandamart
WHERE outOfStock = TRUE and mrp>300
ORDER BY mrp DESC;
LIMIT 10;
--total revenue for each category
SELECT 
    category,
    SUM(discountedSellingPrice * quantity) AS total_revenue
FROM Pandamart
GROUP BY category
ORDER BY total_revenue DESC;
--products with mrp greater than 500 but discount 10 percent 
SELECT *
FROM Pandamart
WHERE mrp > 500
  AND discountPercent = 10;
  -- find the price per gram for product above 100g and sort best values
 SELECT 
    name,
    mrp,
    weightInGms,
    (mrp / weightInGms) AS price_per_gram
FROM Pandamart
WHERE weightInGms > 100
ORDER BY price_per_gram ASC;


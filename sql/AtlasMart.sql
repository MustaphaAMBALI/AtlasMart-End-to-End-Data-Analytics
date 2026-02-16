--		AtlasMart Retail Group - Exploratory Data Analysis

-- Enforce star-schema integrity (Fact ? Dimensions)
ALTER TABLE orders
ADD CONSTRAINT FK_order_product 
FOREIGN KEY (Product_ID) REFERENCES [product](Product_ID);

ALTER TABLE orders
ADD CONSTRAINT FK_order_customer
FOREIGN KEY (Customer_ID) REFERENCES [customers](Customer_ID);

-- AtlasMart key perfomance indicators
SELECT
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID),2) AS Avg_Order_Value,
    ROUND(AVG(Discount) * 100,2) AS Avg_Discount_Pct,
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM orders;

-- Key Metrics
-- Revenue and Profitability Structure
-- Which product categories contribute the most to profit, and which consistently underperform?
SELECT TOP 5				-- Top performers
	p.Category,
	ROUND(SUM(o.Profit),2) AS Profits,
	ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM orders o
LEFT JOIN product p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Profits DESC;

SELECT TOP 5				-- Under performers
	p.Category,
	ROUND(SUM(o.Profit),2) AS Profits,
	ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM orders o
LEFT JOIN product p
ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Profits ASC;


-- Are high sales volumes masking low or negative profitability in certain regions or customer segments?

SELECT						-- Regional Performance
	c.Region,
	ROUND(SUM(o.Sales),2) AS Sales,
    ROUND(SUM(o.Profit),2) AS Profits,
    ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM orders o
LEFT JOIN customers c
	ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region
ORDER BY Profit_Margin DESC;

SELECT						-- Customer Segment Performance
	c.Segment,
	ROUND(SUM(o.Sales),2) AS Sales,
    ROUND(SUM(o.Profit),2) AS Profits,
    ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM orders o
LEFT JOIN customers c
	ON o.Customer_ID = c.Customer_ID
GROUP BY c.Segment
ORDER BY Profit_Margin DESC;

-- Pricing and Discount Risk
-- How does discounting affect profitability across products and customer segments?
SELECT							-- Discounts impact on customer segments profitability
	c.Segment,
	ROUND(AVG(o.Discount) * 100, 2) Avg_Discounts,
	ROUND(SUM(o.Profit),2) Profits,
	ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM orders o
LEFT JOIN customers c
	ON o.Customer_ID = c.Customer_ID
GROUP BY c.Segment
ORDER BY Profits DESC;

SELECT							-- Discounts impact on product categories profitability
	p.Category,
	ROUND(AVG(o.Discount) * 100, 2) Avg_Discounts,
	ROUND(SUM(o.Profit),2) Profits
FROM orders o
LEFT JOIN product p
	ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Profits DESC;

-- Is there a point at which increasing discounts significantly erode margins?
SELECT
    CASE 
        WHEN Discount = 0 THEN '0%'
        WHEN Discount <= 0.1 THEN '1–10%'
        WHEN Discount <= 0.2 THEN '11–20%'
        WHEN Discount <= 0.3 THEN '21–30%'
        ELSE '30%+'
    END AS Discount_Band,
    COUNT(*) AS Order_Count,
    ROUND(SUM(Profit),2) AS Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM orders
GROUP BY 
    CASE 
        WHEN Discount = 0 THEN '0%'
        WHEN Discount <= 0.1 THEN '1–10%'
        WHEN Discount <= 0.2 THEN '11–20%'
        WHEN Discount <= 0.3 THEN '21–30%'
        ELSE '30%+'
    END
ORDER BY Profit_Margin ASC;


-- Operational Performance
-- How do shipping modes influence profitability and order fulfillment timelines?
SELECT
    Ship_Mode,
    AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS Avg_Ship_Days,
    ROUND(SUM(Profit),2) AS Profit
FROM orders
GROUP BY Ship_Mode
ORDER BY Avg_Ship_Days;

-- Are delays between order date and ship date associated with reduced profit outcomes?
 SELECT
    Ship_Mode,
    CASE 
        WHEN DATEDIFF(DAY,Order_Date,Ship_Date) <= 3 THEN 'On Time'
        ELSE 'Delayed'
    END AS Delivery_Status,
    ROUND(SUM(Profit),2) AS Profit,
    ROUND(SUM(Profit)/SUM(Sales)*100,2) AS Profit_Margin
FROM orders
GROUP BY 
    Ship_Mode,
    CASE 
        WHEN DATEDIFF(DAY,Order_Date,Ship_Date) <= 3 THEN 'On Time'
        ELSE 'Delayed'
    END;



---Customer Value
-- Which customers and segments generate the highest profit contribution?
SELECT TOP 5
	c.Customer_Name,
	c.Segment,
	COUNT(DISTINCT o.Order_ID) AS Order_Count,
	ROUND(SUM(o.Profit),2) Profits
FROM orders o 
LEFT JOIN customers c
	ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name,c.Segment
ORDER BY Profits DESC;

-- Are there customers or segments that appear unprofitable after accounting for discounts?
SELECT TOP 5
	c.Customer_Name,
	c.Segment,
	COUNT(DISTINCT o.Order_ID) AS Order_Count,
	ROUND(AVG(o.Discount) * 100, 2) Avg_Discounts,
	ROUND(SUM(o.Profit),2) Profits
FROM orders o 
LEFT JOIN customers c
	ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name,c.Segment
ORDER BY Profits ASC;


--      Time-Based Trend Analysis
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    ROUND(SUM(Sales),2) AS Sales,
    ROUND(SUM(Profit),2) AS Profit
FROM orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

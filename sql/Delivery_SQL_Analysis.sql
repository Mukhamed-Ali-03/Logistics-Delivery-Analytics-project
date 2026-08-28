#Query 1: Overall Business Performance
SELECT
    COUNT(*) AS Total_Orders,
    AVG(Delivery_Time) AS Avg_Delivery_Time,
    AVG(Agent_Rating) AS Avg_Agent_Rating,
    AVG(Agent_Age) AS Avg_Agent_Age
FROM delivery_cleaned;

#Query 2: Delivery Time by Weather
SELECT
    Weather,
    AVG(Delivery_Time) AS Avg_Delivery_Time
FROM delivery_cleaned
GROUP BY Weather
ORDER BY Avg_Delivery_Time DESC;

#Query 3: Delivery Time by Traffic
SELECT
    Traffic,
    AVG(Delivery_Time) AS Avg_Delivery_Time
FROM delivery_cleaned
GROUP BY Traffic
ORDER BY Avg_Delivery_Time DESC;


#Query 4: Best Delivery Vehicle
SELECT
    Vehicle,
    AVG(Delivery_Time) AS Avg_Delivery_Time
FROM delivery_cleaned
GROUP BY Vehicle
ORDER BY Avg_Delivery_Time;

#Query 5: Area-wise Performance
SELECT
    Area,
    AVG(Delivery_Time) AS Avg_Delivery_Time
FROM delivery_cleaned
GROUP BY Area;

#Query 6: Package Category Analysis
SELECT
    Category,
    AVG(Delivery_Time) AS Avg_Delivery_Time
FROM delivery_cleaned
GROUP BY Category
ORDER BY Avg_Delivery_Time DESC;

#Query 7: Fast / Medium / Slow Deliveries
SELECT
    Order_ID,
    Delivery_Time,
    CASE
        WHEN Delivery_Time < 20 THEN 'Fast'
        WHEN Delivery_Time < 40 THEN 'Medium'
        ELSE 'Slow'
    END AS Delivery_Status
FROM delivery_cleaned;

#Query 8: Above Average Deliveries
SELECT
    Order_ID,
    Delivery_Time
FROM delivery_cleaned
WHERE Delivery_Time >
(
    SELECT AVG(Delivery_Time)
    FROM delivery_cleaned
);


#Query 9: Rank Delivery Agents
SELECT
    Order_ID,
    Agent_Rating,
    RANK() OVER (ORDER BY Agent_Rating DESC) AS Rating_Rank
FROM delivery_cleaned;


#Query 10: Monthly Delivery Trend
SELECT
    MONTH(Order_Date) AS Month,
    COUNT(*) AS Total_Orders
FROM delivery_cleaned
GROUP BY MONTH(Order_Date)
ORDER BY Month;


#Query 11: High Volume Categories
SELECT
    Category,
    COUNT(*) AS Total_Orders
FROM delivery_cleaned
GROUP BY Category
HAVING COUNT(*) > 15;


#Query 11 Which deliveries took longer than the average delivery time? 
WITH AvgDelivery AS
(
    SELECT AVG(Delivery_Time) AS Avg_Time
    FROM delivery_cleaned
)
SELECT
    Order_ID,
    Delivery_Time
FROM delivery_cleaned
WHERE Delivery_Time >
(
    SELECT Avg_Time
    FROM AvgDelivery
);


#Query 12: Monthly Order Trend
SELECT
    MONTH(Order_Date) AS Month_Number,
    MONTHNAME(Order_Date) AS Month_Name,
    COUNT(*) AS Total_Orders
FROM delivery_cleaned
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY Month_Number;


#dataset data
SELECT
    MIN(Order_Date) AS Start_Date,
    MAX(Order_Date) AS End_Date
FROM delivery_cleaned;

SELECT DISTINCT YEAR(Order_Date) AS Year
FROM delivery_cleaned
ORDER BY Year;


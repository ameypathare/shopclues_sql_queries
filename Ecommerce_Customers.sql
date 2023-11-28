
--                          **   Converting JSON File to CSV **

Declare @JSON varchar(max)
SELECT @JSON=BulkColumn
FROM OPENROWSET (BULK 'D:\ecommerce_customer.json', SINGLE_CLOB) import
SELECT * INTO Customers_JSON
FROM OPENJSON (@JSON)
WITH  (
       [User_ID] int,	
       [Gender] varchar(255),	
       [Age] varchar(255),	
       [Location] varchar(255),	
       [Device_Type] varchar(255),	
       [Product_Browsing_Time] int,	
       [Total_Pages_Viewed] numeric,	
       [Items_Added_to_Cart] numeric,	
       [Total_Purchases] numeric
)

SELECT * FROM Customers_JSON
SELECT * FROM Customers



                              --  ** Data Cleaning **                                                -- For Table Customers_JSON
                                                    
													                                                 -- Checking Duplicates
WITH Customer_JSON AS
  (SELECT *,
          ROW_NUMBER() OVER (PARTITION BY User_ID
                             ORDER BY USER_ID) AS duplicates
   FROM Customers_JSON)

SELECT *
FROM Customer_JSON
WHERE duplicates > 1




ALTER TABLE Customers_JSON                                                                 -- Adding Column Minutes
ADD Minutes varchar(20)                                                           


SELECT CASE                                                                               -- Validating Query
           WHEN Product_Browsing_Time > 0 THEN 'Minutes'
       END
FROM Customers_JSON


UPDATE Customers_JSON                                                                     -- Updating Column & Filling Minutes As Word Inside Column Minutes
SET Minutes =
  (SELECT CASE
              WHEN Product_Browsing_Time > 0 THEN 'Minutes'
          END)




ALTER TABLE Customers_JSON                                                                -- Adding Column Time_format
ADD Time_format TIME


SELECT CASE                                                                               -- Validating Query
           WHEN cast(Product_Browsing_Time AS varchar(20)) = 60 THEN '00:59:00'
           ELSE '00:' + cast(Product_Browsing_Time AS varchar(20)) + ':00'
       END AS Timeformat
FROM Customers_JSON


UPDATE Customers_JSON                                                                     -- Updating Column & Adjusting Time and Converting Dataype "VARCHAR" To "TIME" Using "TRY_CONVERT"
SET Time_format = TRY_CONVERT(TIME, CASE
                                        WHEN cast(Product_Browsing_Time AS varchar(20)) = 60 THEN '00:59:00'
                                        ELSE '00:' + cast(Product_Browsing_Time AS varchar(20)) + ':00'
                                    END)


UPDATE Customers_JSON                                                                    -- Adjusting Time For Product_Browsing_Time Column
SET Product_Browsing_Time = (CASE
                                 WHEN Product_Browsing_Time = 60 THEN 59
                                 ELSE Product_Browsing_Time
                             END)



							                                                             -- Trimming the Entire Table Customers.csv
UPDATE Customers
SET Gender = trim(Gender)

UPDATE Customers
SET LOCATION = trim(LOCATION)

UPDATE Customers
SET Device_Type = trim(Device_Type)





--                 ** Answering Questions  **

-- What is the average product browsing time for Users

WITH TIME AS
  (SELECT Gender,
          avg(Product_Browsing_Time) AS Product_Browsing_Time,
          Minutes AS TIME
   FROM Customers
   GROUP BY Gender,
            Minutes)
SELECT Gender,
       cast(Product_Browsing_Time AS varchar) + ' ' + TIME AS Product_Browsing_Time
FROM TIME




-- What are the average of total pages viewed across the locations

SELECT LOCATION,
       avg(Total_Pages_Viewed) AS Avg_Pages_Viewed
FROM Customers
GROUP BY LOCATION



-- Ranking Top 5 Locations with the most pages viewed

WITH pages AS
  (SELECT Location,
          sum(Total_Pages_Viewed) AS Pages_Viewed
   FROM Customers
   GROUP BY LOCATION)

SELECT Top 5 Location,
             Pages_Viewed,
             DENSE_RANK() OVER (ORDER BY Pages_Viewed DESC) AS Rank
FROM pages
GROUP BY Location,
         Pages_Viewed



-- How many customers only viewed pages but had not purchased

SELECT Gender,
       count(User_ID) AS Total_Users
FROM Customers
WHERE Total_Pages_Viewed > 0
  AND Total_Purchases = 0
GROUP BY Gender



-- How many Customers added items to cart but had not purchased

SELECT Gender,
       count(User_ID) AS Total_Users
FROM Customers
WHERE Items_Added_to_Cart > 0
  AND Total_Purchases = 0
GROUP BY Gender



-- Top 5 Locations where users purchases are more

SELECT top 5 Location,
             SUM(Total_Purchases) AS Total_Purchases
FROM Customers
GROUP BY Location
ORDER BY Total_Purchases DESC



-- Top 3 Devices with most purchases by location if tie then keep it
WITH devices AS
  (SELECT Location,
          Device_Type,
          sum(Total_Purchases) AS Total_Purchases,
          rank() OVER (PARTITION BY Location
                       ORDER BY sum(Total_Purchases) DESC) AS "Top 3"
   FROM Customers
   GROUP BY Device_Type,
            Location)

SELECT Location,
       Device_Type,
       Total_Purchases,
       "Top 3"
FROM devices
WHERE "Top 3" <= 3



-- Percentage of devices contribute to purchases

SELECT DISTINCT Device_Type AS Devices,
                ceiling(sum(Total_Purchases) * 100 / sum(sum(cast(Total_Purchases AS numeric))) over()) AS purchases_percentage
FROM Customers
GROUP BY Device_Type




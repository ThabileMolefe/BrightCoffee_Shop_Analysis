--Selct all columns from the data in order to do an EDA
SELECT
  *
FROM
  "B_COFFEE"."SALES"."CAFE_TRANSACTIONS"

-- Count the number of shops/ branches
SELECT COUNT(DISTINCT store_id)
FROM CAFE_TRANSACTIONS;

-- To show us where these shops are located
SELECT DISTINCT store_location,
                store_id
FROM CAFE_TRANSACTIONS

-- Revenue by Store location
SELECT store_location,
     SUM(transaction_qty*unit_price) AS Revenue
FROM CAFE_TRANSACTIONS
GROUP BY store_location;
---------------------------------------------------------------------------------------------------------------------------------
-- What time does the store open
SELECT MIN(transaction_time) AS Opening_time
 FROM CAFE_TRANSACTIONS;

 -- What time does the store close
SELECT MAX(transaction_time) AS Closing_time
 FROM CAFE_TRANSACTIONS;
 ---------------------------------------------------------------------------------------------------------------------------------
 -- Earliest and latest transaction date
 SELECT MIN(transaction_date) AS Earliest_Transaction_Date
 FROM CAFE_TRANSACTIONS;

  SELECT MAX(transaction_date) AS Latest_Transaction_Date
  FROM CAFE_TRANSACTIONS;
 ---------------------------------------------------------------------------------------------------------------------------------

 --Getting Transaction Day name
 SELECT transaction_date,
        DAYNAME (transaction_date) AS day_name,
        CASE
           WHEN  DAYNAME (transaction_date) IN ('Sat', 'Sun') THEN 'Weekend'
           ELSE 'Weekday'
        END AS Day_Classification,
        MONTHNAME(transaction_date) AS month_name
 FROM CAFE_TRANSACTIONS;


---------------------------------------------------------------------------------------------------------------------------------
--Large file for exporting to excel
SELECT transaction_date,
        DAYNAME (transaction_date) AS day_name,
        CASE
           WHEN  DAYNAME (transaction_date) IN ('Sat', 'Sun') THEN 'Weekend'
           ELSE 'Weekday'
        END AS Day_Classification,
        MONTHNAME(transaction_date) AS month_name,
        transaction_time,
        CASE
           WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
           WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
           WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening'
           WHEN transaction_time >= '20:00:00' THEN 'Night'
        END AS time_bucket,
        HOUR(transaction_time) AS hour_of_day,
        store_location,
        product_category,
        product_detail,
        product_type,
        unit_price,
        transaction_qty,
        transaction_qty*unit_price AS Revenue       
 FROM CAFE_TRANSACTIONS;

---------------------------------------------------------------------------------------------------------------------------------
         

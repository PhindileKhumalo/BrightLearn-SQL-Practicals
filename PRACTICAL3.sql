-- Dsiplay the columns in the table
SELECT *
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS;


-- 1. Find all records where Size is missing and the purchase_amount is greater than 
-- 50. 
-- Expected Columns: Customer ID, Size, purchase_amount, Item 
-- Purchased 

SELECT CUSTOMER_ID
        size,
        purchase_amount,
        item_purchased
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE size IS NULL AND PURCHASE_AMOUNT > 50;

-- 2. List the total number of purchases grouped by Season, treating NULL values a
--  s 'Unknown Season'. 
-- Expected Columns: Season, Total Purchases

SELECT 
  COALESCE(Season, 'Unknown Season') AS Season,
  COUNT(*) AS TotalPurchases
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY COALESCE(Season, 'Unknown Season');


-- 3. Count how many customers used each Payment Method, treating NULLs as 
-- 'Not Provided'. 
-- Expected Columns: Payment Method, Customer Count 


SELECT 
  COALESCE(PAYMENT_METHOD, 'Not Provided') AS PaymentMethod,
  COUNT(DISTINCT CUSTOMER_ID) AS CustomerCount
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY COALESCE(PAYMENT_METHOD, 'Not Provided');

-- 4. Show customers where Promo Code Used is NULL and Review Rating is below 
-- 3.0. 
-- Expected Columns: Customer ID, Promo Code Used, Review Rating, Item Purchased

SELECT CUSTOMER_ID, PROMO_CODE_USED, REVIEW_RATING, ITEM_PURCHASED
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE PROMO_CODE_USED IS NULL AND REVIEW_RATING < 3.0;




--  5. Group customers by Shipping 
-- Type, and return the average purchase_amount, treating missing values as 0. 
-- Expected Columns: Shipping Type, Average purchase_amount 

SELECT 
  SHIPPING_TYPE,
  AVG(COALESCE(purchase_amount, 0)) AS AveragePurchase
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY SHIPPING_TYPE;


-- 6. Display the number of purchases per Location only for those with more than 
-- 5 purchases and no NULL Payment Method. 
-- Expected Columns: Location, Total Purchases

SELECT Location, COUNT(*) AS TotalPurchases
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE PAYMENT_METHOD IS NOT NULL
GROUP BY Location
HAVING COUNT(*) > 5;


-- 7. Create a column Spender Category that classifies customers using CASE: 
-- 'High' if amount > 80, 'Medium' if BETWEEN 50 AND 80, 
-- 'Low' otherwise. Replace NULLs in purchase_amount with 0. 
-- Expected Columns: Customer ID, purchase_amount, Spender Category 

SELECT 
  CUSTOMER_ID,
  COALESCE(purchase_amount, 0) AS purchase_amount,
  CASE 
    WHEN COALESCE(purchase_amount, 0) > 80 THEN 'High'
    WHEN COALESCE(purchase_amount, 0) BETWEEN 50 AND 80 THEN 'Medium'
    ELSE 'Low'
  END AS SpenderCategory
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS;

-- 8. Find customers who have no Previous 
-- Purchases value but whose Color is not NULL. 
-- Expected Columns: Customer ID, Color, Previous Purchases 

SELECT CUSTOMER_ID, Color, PREVIOUS_PURCHASES
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE PREVIOUS_PURCHASES IS NULL AND Color IS NOT NULL;


-- 9. Group records by Frequency of 
-- Purchases and show the total amount spent per group, treating NULL frequenc
--  ies as 'Unknown'. 
-- Expected Columns: Frequency of Purchases, Total purchase_amount 

SELECT 
  COALESCE(Frequency_Of_Purchases, 'Unknown') AS Frequency,
  SUM(purchase_amount) AS TotalSpent
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY COALESCE(Frequency_Of_Purchases, 'Unknown');


-- 10. Display a list of all Category values with the number of times each was purcha
--  sed, excluding rows where Categoryis NULL. 
-- Expected Columns: Category, Total Purchases 

SELECT Category, COUNT(*) AS Total_Purchases
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE Category IS NOT NULL
GROUP BY Category;

-- 11. Return the top 
-- 5 Locations with the highest total purchase_amount, replacing NULLs in amount 
-- with 0. 
-- Expected Columns: Location, Total purchase_amount

SELECT 
  Location,
  SUM(COALESCE(purchase_amount, 0)) AS Total_Purchase_Amount
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY Location
ORDER BY Total_Purchase_Amount DESC
LIMIT 5;



-- 12. Group customers by Gender and Size, and count how many entries have a NUL
--  L Color. 
-- Expected Columns: Gender, Size, Null Color Count

SELECT 
  Gender,
  Size,
  COUNT(*) AS NullColorCount
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE Color IS NULL
GROUP BY Gender, Size;


-- 13. Identify all Item Purchased where more than 3 purchases had NULL Shipping 
-- Type. 
-- Expected Columns: Item Purchased, NULL Shipping Type Count 
SELECT 
  ITEM_PURCHASED,
  COUNT(*) AS NullShippingTypeCount
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE SHIPPING_TYPE IS NULL
GROUP BY ITEM_PURCHASED
HAVING COUNT(*) > 3;

-- 14. Show a count of how many customers per Payment Method have NULL Review 
-- Rating. 
-- Expected Columns: Payment Method, Missing Review Rating Count 
SELECT 
  PAYMENT_METHOD,
  COUNT(*) AS MissingReviewRatingCount
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE REVIEW_RATING IS NULL
GROUP BY PAYMENT_METHOD;


-- 15. Group by Category and return the average Review Rating, replacing NULLs with 
-- 0, and filter only where average is greater than 3.5. 
SELECT 
  Category,
  AVG(COALESCE(REVIEW_RATING, 0)) AS AverageReviewRating
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY Category
HAVING AVG(COALESCE(Review_Rating, 0)) > 3.5;


-- 16. List all Colors that are missing (NULL) in at least 
-- 2 rows and the average Age of customers for those rows. 
-- Expected Columns: Color, Average Age 

-- Expected Columns: Category, Average Review Rating 

SELECT 
  Color,
  AVG(Age) AS AverageAge
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE Color IS NULL
GROUP BY Color
HAVING COUNT(*) >= 2;


-- 17. Use CASE to create a column Delivery Speed: 'Fast' if Shipping Type is 'Express' or 
-- 'Next Day Air', 'Slow' if 'Standard', 
-- 'Other' for all else including NULL. Then count how many customers fall into 
-- each category. 
-- Expected Columns: Delivery Speed, Customer Count

SELECT 
  CASE 
    WHEN SHIPPING_TYPE IN ('Express', 'Next Day Air') THEN 'Fast'
    WHEN SHIPPING_TYPE = 'Standard' THEN 'Slow'
    ELSE 'Other'
  END AS DeliverySpeed,
COUNT(DISTINCT Customer_ID) AS CustomerCount
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY DeliverySpeed;



-- 18. Find customers whose purchase_amount is NULL and whose Promo Code Used is 
-- 'Yes'. 
-- Expected Columns: Customer ID, purchase_amount, Promo Code Used 

SELECT CUSTOMER_ID, 
        purchase_amount, 
        PROMO_CODE_USED
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE purchase_amount IS NULL AND PROMO_CODE_USED = 'Yes';


-- 19. Group by Location and show the maximum Previous 
-- Purchases, replacing NULLs with 0, only where the average rating is above 4.0. 
-- Expected Columns: Location, Max Previous Purchases, Average 
-- Review Rating 
SELECT 
  Location,
  MAX(COALESCE(PREVIOUS_PURCHASES, 0)) AS MaxPreviousPurchases,
AVG(Review_Rating) AS AverageReviewRating
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
GROUP BY Location
HAVING AVG(Review_Rating) > 4.0;


-- 20. Show customers who have a NULL Shipping 
-- Type but made a purchase in the range of 30 to 70 USD. 
-- Expected Columns: Customer ID, Shipping 
-- Type, purchase_amount, Item Purchased 

SELECT CUSTOMER_ID, 
     Shipping_Type, 
    purchase_amount, 
    ITEM_PURCHASED
FROM PRACTICAL3.SHOP_DATASET.SHOPING_TRENDS
WHERE Shipping_Type IS NULL AND purchase_amount BETWEEN 30 AND 70;








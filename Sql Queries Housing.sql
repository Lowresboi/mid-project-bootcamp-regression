-- 2. Create a table house_price_data with the same columns as given in the csv file.
CREATE TABLE house_price_data (
  `id` bigint DEFAULT NULL,
  `date` text,
  `bedrooms` int DEFAULT NULL,
  `bathrooms` text,
  `sqft_living` int DEFAULT NULL,
  `sqft_lot` int DEFAULT NULL,
  `floors` int DEFAULT NULL,
  `waterfront` int DEFAULT NULL,
  `view` int DEFAULT NULL,
  `condition` int DEFAULT NULL,
  `grade` int DEFAULT NULL,
  `sqft_above` int DEFAULT NULL,
  `sqft_basement` int DEFAULT NULL,
  `yr_built` int DEFAULT NULL,
  `yr_renovated` int DEFAULT NULL,
  `zipcode` int DEFAULT NULL,
  `lat` text,
  `long` text,
  `sqft_living15` int DEFAULT NULL,
  `sqft_lot15` int DEFAULT NULL,
  `price` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. Import the data from the csv file into the table.
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- 4. Select all the data from table house_price_data to check if the data was imported correctly
SELECT *
FROM house_price_data;

-- 5. Droping the 'date' column
ALTER TABLE house_price_data
DROP COLUMN date;

-- Select all data to verify
SELECT *
FROM house_price_data
LIMIT 10;

-- 6. Use sql query to find how many rows of data you have.
SELECT COUNT(*)
FROM house_price_data;

-- 7. Let's find the unique values in some of the categorical columns:
SELECT DISTINCT bedrooms
FROM house_price_data;
SELECT DISTINCT bathrooms
FROM house_price_data;
SELECT DISTINCT floors
FROM house_price_data;
SELECT DISTINCT `condition`
FROM house_price_data;
SELECT DISTINCT grade
FROM house_price_data;

-- 8.Arrange the data in a decreasing order by the price of the house.
SELECT id
FROM house_price_data
ORDER BY price DESC
LIMIT 10;

-- 9. I calculated the average price of all the properties in my data
SELECT AVG(price) AS average_price
FROM house_price_data;

-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data.
SELECT bedrooms, AVG(price) AS average_price
FROM house_price_data
GROUP BY bedrooms;

-- What is the average sqft_living of the houses grouped by bedrooms?
SELECT bedrooms, AVG(sqft_living) AS average_sqft_living
FROM house_price_data
GROUP BY bedrooms;

-- What is the average price of the houses with a waterfront and without a waterfront? T
SELECT waterfront, AVG(price) AS average_price
FROM house_price_data
GROUP BY waterfront;

SELECT 'condition', AVG(grade) AS average_grade
FROM house_price_data
GROUP BY 'condition';

SELECT 'condition', grade, COUNT(*) AS count
FROM house_price_data
GROUP BY 'condition', grade;

SELECT `condition`, grade, COUNT(*) AS count
FROM house_price_data
GROUP BY `condition`, grade
ORDER BY `condition`, grade;

-- 11. One of my customers is only interested in the following houses:
SELECT COUNT(*) AS house_count
FROM house_price_data
WHERE bedrooms IN (3, 4)
    AND bathrooms > 3
    AND floors = 1
    AND waterfront = 0
    AND `condition` >= 3
    AND grade >= 5
    AND price < 300000;
    
-- I tried two diferente queries for this exercise but in both of the display that there's no houses which meet the following criteria.
SELECT
    id,
    bedrooms,
    bathrooms,
    floors,
    `condition`,
    grade,
    price
FROM house_price_data
WHERE
    bedrooms IN (3, 4)
    AND bathrooms > 3
    AND floors = 1
    AND waterfront = 0
    AND `condition` >= 3
    AND grade >= 5
    AND price < 300000;
    
-- 12. I want to find out the list of properties whose prices are twice more than the average of all the properties in the database.

SELECT id, bedrooms, bathrooms, floors, `condition`, grade, price
FROM house_price_data
WHERE price > 2 * (SELECT AVG(price) FROM house_price_data);

-- 13. Since this is something that the senior management is regularly interested in, create a view of the same query.
CREATE VIEW high_priced_properties AS
SELECT id, bedrooms, bathrooms, floors, `condition`, grade, price
FROM house_price_data
WHERE price > 2 * (SELECT AVG(price) FROM house_price_data);
-- Displaying the  view of the query.
SELECT * FROM high_priced_properties;
-- 14. Here is it the difference in average prices of the properties with three and four bedrooms.
SELECT
    bedrooms,
    AVG(price) AS average_price
FROM
    house_price_data
WHERE
    bedrooms IN (3, 4)
GROUP BY
    bedrooms;
-- 15. What are the different locations where properties are available in my  database?  using (distinct zip codes)
SELECT DISTINCT
    zipcode
FROM
    house_price_data;
-- 16. Show the list of all the properties that were renovated.
-- so for this exercise I creade two diferent queries. one which display the whole house whice were renovated since the 1945 year.
-- and the second one which dispaly the house which were renovated in between may 2014 & may 2015.
-- renovation year from 1945 >=
SELECT *
FROM house_price_data
WHERE yr_renovated >= 1945;
-- renovation year in between may 2014 & may 2015.
SELECT
    id,
    bedrooms,
    bathrooms,
    floors,
    `condition`,
    grade,
    price,
    yr_renovated
FROM house_price_data
WHERE
    yr_renovated >= '2014-05-01' AND yr_renovated <= '2015-05-31';
-- 17. Details of the property that is the 11th most expensive property in my database.
SELECT
    id,
    bedrooms,
    bathrooms,
    floors,
    `condition`,
    grade,
    price
FROM house_price_data
ORDER BY price DESC
LIMIT 1 OFFSET 10;

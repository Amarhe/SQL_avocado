SELECT *
FROM avocado_data
ORDER BY region, Date;

-- Project Topics:
-- 1. What are the regions with highest price difference for organic and conventional avocados in years 2015-2017?
-- 2. What are the regions with highest total sales of avocados (organic and conventional) in years 2015-2017?
-- 3. What type of avocados is sales batter in years 2015-2017?
-- 4. What are the months where avocados are sales the most in years 2015-2017?
-- 5. What type of bags are most popular and which make biggest profit in years 2015-2017? (small bag - 5, Large bag - 10, XLarge bag - 15)

-- Topic 1
-- * Organic type:
SELECT 
	region,
    type,
    MIN(AveragePrice) AS Min,
    MAX(AveragePrice) AS Max,
    (MAX(AveragePrice)-MIN(AveragePrice)) AS PriceDifference
FROM avocado_data
WHERE type = "organic"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'
GROUP BY region
ORDER BY PriceDifference DESC
LIMIT 5;

-- Conventional type:

SELECT 
	region,
    type,
    MIN(AveragePrice) AS Min,
    MAX(AveragePrice) AS Max,
    (MAX(AveragePrice)-MIN(AveragePrice)) AS PriceDifference
FROM avocado_data
WHERE type = "conventional"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'
GROUP BY region
ORDER BY PriceDifference DESC
LIMIT 5;

-- Topic 2
-- Conventional type:

SELECT
    region,
    type,
    SUM(`Total Volume`) / 1000000  AS TotalVolumeMln
FROM avocado_data
WHERE type = "conventional"
AND region <> "TotalUS"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'
GROUP BY region
ORDER BY TotalVolumeMln DESC
LIMIT 5;

-- * Organic type:
SELECT
    region,
    type,
    SUM(`Total Volume`) / 1000000  AS TotalVolumeMln
FROM avocado_data
WHERE type = "organic"
AND region <> "TotalUS"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'
GROUP BY region
ORDER BY TotalVolumeMln DESC
LIMIT 5;

-- Topic 3

SELECT
    type,
    SUM(`Total Volume`) / 1000000  AS TotalVolumeMln
FROM avocado_data
WHERE region <> "TotalUS"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'
GROUP BY type

-- Topic 4

SELECT
    MONTHNAME(Date) AS Month,
    SUM(`Total Volume`) / 1000000  AS TotalVolumeMln
FROM avocado_data
WHERE region <> "TotalUS"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'
GROUP BY Month
ORDER BY TotalVolumeMln DESC

-- Topic 5
-- Profits

SELECT
    SUM(`Small Bags` * 5 * AveragePrice) / 1000000 AS SmallBagProfitMln,
    SUM(`Large Bags` * 10 * AveragePrice) / 1000000 AS LargeBagProfitMln,
    SUM(`XLarge Bags` * 15 * AveragePrice) / 1000000 AS XLargeBagProfitMln
FROM avocado_data
WHERE region <> "TotalUS"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'

-- Total count

SELECT
    SUM(`Small Bags`) / 1000000 AS SmallBagProfitMln,
    SUM(`Large Bags`) / 1000000 AS LargeBagProfitMln,
    SUM(`XLarge Bags`) / 1000000 AS XLargeBagProfitMln
FROM avocado_data
WHERE region <> "TotalUS"
AND Date BETWEEN '2015-01-01' AND '2018-01-01'

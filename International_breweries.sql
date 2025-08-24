-- SECTION A: PROFIT ANALYSIS

-- Within the space of the last three years, what was the profit worth of the breweries,inclusive of the anglophone(English speaking country) and the francophone(French Speaking territory) territories?
SELECT
	countries, 
	sum(profit) as total_profit
FROM	
	international_breweries
GROUP BY countries
ORDER BY total_profit DESC;

-- Compare the total profit between these two territories in order for the territory manager, Mr. Stone to made a strategic decision that will aid profit maximization in 2020.
SELECT	
	years, countries, sum(profit) as total_profit
FROM	
	international_breweries
GROUP BY years, countries
ORDER BY years DESC, total_profit DESC;

-- The country that generated the highest profit in 2019
SELECT	
	countries, max(profit) as highest_profit
FROM	
	international_breweries
WHERE
	years = 2019
GROUP BY countries
ORDER BY highest_profit DESC
LIMIT 2;

-- The year with the highest profit.
SELECT	
	years, max(profit) as highest_profit
FROM	
	international_breweries
GROUP BY years
ORDER BY highest_profit DESC
LIMIT 1;

-- Which month in the three years was the least profit generated?
SELECT	
	months, years, min(profit) as least_profit
FROM	
	international_breweries
GROUP BY months, years
ORDER BY least_profit ASC
LIMIT 1;

-- What was the minimum profit in the month of December 2018?
SELECT	
	months, years, min(profit) as minimum_profit
FROM	
	international_breweries
WHERE
	months = 'December' AND years = 2018
GROUP BY months, years;

-- Compare the profit in percentage for each of the months in 2019
SELECT
	months,
	sum(profit) as month_total_profit,
	ROUND((CAST(sum(profit) as DECIMAL) / year_total_profit) * 100 , 2) as 			profit_percentage
FROM
	international_breweries,
	(SELECT CAST(sum(profit) as DECIMAL) as year_total_profit 
	FROM international_breweries
	WHERE years = 2019) as ytp
WHERE 
	years = 2019
GROUP BY
	months, year_total_profit
ORDER BY months;
	

-- Which particular brand generated the highest profit in Senegal?
SELECT 
	brands, 
	sum(profit) as total_profit
FROM	
	international_breweries
WHERE
	countries = 'Senegal'
GROUP BY
	brands
ORDER BY total_profit DESC
LIMIT 1;


-- SECTION B: BRAND ANALYSIS

-- Within the last two years, the brand manager wants to know the top three brands consumed in the francophone countries
SELECT
	brands,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	countries IN ('Senegal', 'Togo', 'Benin') AND
	years BETWEEN 2018 and 2019
GROUP BY brands
ORDER BY total_quantity DESC
LIMIT 3;

-- Find out the top two choices of consumer brands in Ghana
SELECT
	brands,
	COUNT(*) as brand_count,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	countries = 'Ghana' 
GROUP BY brands
ORDER BY brand_count DESC, total_quantity DESC
LIMIT 2;

-- Find out the details of beers consumed in the past three years in the most oil-rich country in West Africa
SELECT
	brands,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	countries = 'Nigeria' AND
	years BETWEEN 2017 and 2019
GROUP BY brands
ORDER BY total_quantity DESC;

-- Favorite malt brand in the Anglophone region between 2018 and 2019
SELECT 
	brands,
	region,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	brands LIKE '%Malt%' AND
	countries IN ('Nigeria', 'Ghana', 'Benin', 'Togo') AND
	years BETWEEN 2018 and 2019
GROUP BY brands, region
ORDER BY total_quantity DESC
LIMIT 1;

-- Which brands sold the highest in 2019 in Nigeria?
SELECT 
	brands,
	sum(profit) as total_profit,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	countries = 'Nigeria' AND
	years = 2019
GROUP BY brands
ORDER BY total_quantity DESC
LIMIT 4;

-- Favorites brand in South_South region in Nigeria
SELECT
	brands,
	region,
	COUNT(*) brand_count,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE 
	countries = 'Nigeria' AND
	region = 'South South'
GROUP BY
	brands, region
ORDER BY total_quantity DESC;

-- Beer consumption in Nigeria
SELECT
	brands,
	sum(quantity) as total_quantity
FROM 
	international_breweries
WHERE 
	countries = 'Nigeria'
GROUP BY
	brands
ORDER BY total_quantity DESC;

-- Level of consumption of Budweiser in the regions in Nigeria
SELECT
	region,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	countries = 'Nigeria' AND
	brands = 'Budweiser'
GROUP BY region
ORDER BY total_quantity DESC;

-- Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
SELECT
	region,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	countries = 'Nigeria' AND
	brands = 'Budweiser' AND
	years = 2019
GROUP BY region
ORDER BY total_quantity DESC;


-- SECTION C: COUNTRIES ANALYSIS

-- The country with the highest consumption of beer.
SELECT
	countries,
	sum(quantity) as total_quantity
FROM
	international_breweries
GROUP BY countries
ORDER BY total_quantity DESC
LIMIT 1;

-- Highest sales personnel of Budweiser in Senegal
SELECT
	sales_rep,
	sum(cost) as total_cost,
	sum(quantity) as total_quantity
FROM
	international_breweries
WHERE
	brands = 'Budweiser' AND
	countries = 'Senegal'
GROUP BY 
	sales_rep
ORDER BY total_quantity DESC
LIMIT 1;

-- The Country with the highest profit in the fourth quarter in 2019
SELECT
	countries,
	max(profit) as highest_profit,
	sum(profit) as total_profit
FROM
	international_breweries
WHERE
	months IN ('October', 'November', 'December') AND
	years = 2019
GROUP BY 
	countries
ORDER BY highest_profit DESC
LIMIT 1;
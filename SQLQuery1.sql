

use bike

SELECT * FROM bike_share_yr_0
SELECT * FROM bike_share_yr_1




--union 2021&2022 years
with cte as (
SELECT * FROM bike_share_yr_0
UNION ALL
SELECT * FROM bike_share_yr_1
)

-- connecting cte with costs table
SELECT *
FROM cte a
LEFT JOIN cost_table b 
on a.yr = b.yr


-- actually we don't need the all columns lets select the needed columns
with cte as (
SELECT * FROM bike_share_yr_0
UNION ALL
SELECT * FROM bike_share_yr_1
)

-- connecting cte with costs table and selecting needed columns and basic calculations like profit revenue
SELECT 
	dteday,
	season,
	a.yr,
	weekday,
	hr,
	rider_type,
	riders,
	price,
	COGS,
	riders*price as revenue,
	(riders*price) - Cogs as profit
FROM cte a
LEFT JOIN cost_table b 
on a.yr = b.yr
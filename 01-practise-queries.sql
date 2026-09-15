
/*
============================================================
SQL Toolbox - Examples of applied solutions
Catalog: T-SQL
============================================================
*/

-- #1. vending machines utilization limited to machines with turnover in selected city

use BCOverview_VENDING;
WITH VOL_COUNT_DIS AS
(
SELECT
	VEND_ID,
	COUNT(DISTINCT LP) AS VOLUME_DIS
FROM
	UTILIZATION
GROUP BY
	VEND_ID
)

SELECT
	p.VEND_ID,
	COUNT (DISTINCT p.VEND_ID) AS VEND_AUTO_ACTIVE_COUNT,
	v.VOLUME_DIS
FROM	
	VEND_TABLE p
INNER JOIN
	VOL_COUNT_DIS v ON p.VEND_ID = v.VEND_ID
WHERE
	p.NETWORK_TYPE = 'DUAL_PAYMENT' AND 
	v.VOLUME_DIS > 0 AND
	p.CITY = 'Example_City'
GROUP BY
	p.VEND_ID,
	v.VOLUME_DIS
ORDER BY
	v.VOLUME_DIS DESC;

-- #2. most popular vending machines locations utilization limited to selected year, network, city and service type

use BCOverview_VENDING;
WITH VOL_COUNT_DIS AS
(
SELECT
	VEND_ID,
	COUNT(DISTINCT LP) AS VOLUME_DIS,
	LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4) AS YEAR
FROM
	UTILIZATION
WHERE
	STATUS = 'FILLED' AND								
	LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4) = '2025'
GROUP BY
	VEND_ID, LEFT(CONVERT(VARCHAR(10), DATA_SP, 23), 4)
),
--rank calculation 
RANKED_VEND AS
(
SELECT
	v.VEND_ID,
	v.VOLUME_DIS,
	CONCAT (p.CITY,', ',p.STREET) AS LOCATION_DET,
	DENSE_RANK() OVER (ORDER BY v.VOLUME_DIS DESC) AS VEND_RANK
FROM	
	VEND_DB p
INNER JOIN
	VOL_COUNT_DIS v ON p.VEND_ID = v.VEND_ID
WHERE
	p.NETWORK_TYPE = 'SINGLE_PAYMENT'
)
--summary table display top 10 selection
SELECT 
	p.VEND_RANK AS RANK,
	p.VEND_ID AS ID,
	p.LOCATION_DET AS LOCATION,
	p.VOLUME_DIS AS 'FILLED VOL'
FROM
	RANKED_VEND p
WHERE
	VEND_RANK <= 10;
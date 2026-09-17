/*
==================================================
PROJECT: SNOWFLAKE HANDS ON PRACTISE

### Achievements:
Badge One - Data Warehousing Workshop [link](https://achieve.snowflake.com/d0146fd6-5654-4a80-b788-73e5968cb30e#acc.2b4mRroM) 
--total credist used for all excercises in the Bdg1 labs: $19.96


### Environment Practise Best Practise and code examples:
1. Warehouse Cost Optimization
2. Mentioned resources
==================================================
*/

--#1 Decrease warehouse standby acticity and auto scalling for sql code cost optimisation

-- Step A: Time travel history limit
ALTER ACCOUNT SET DATA_RETENTION_TIME_IN_DAYS = 1;
-- Step B: Wh acticity limit to 60s
ALTER WAREHOUSE COMPUTE_WH SET AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;
-- Query acceleration limit to 2
ALTER WAREHOUSE COMPUTE_WH SET 
    ENABLE_QUERY_ACCELERATION = TRUE 
    QUERY_ACCELERATION_MAX_SCALE_FACTOR = 2;

--#2 Useful links/sources for data processing

--JSON EDITOR Online - text, tree, table structure of json file    
https://jsoneditoronline.org/
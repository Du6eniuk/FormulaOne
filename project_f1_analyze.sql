-- 1) The average age of driver through the years:

-- This is the last table we want to join. It has information that we need.
-- Name and birthday date of each driver.
SELECT *
FROM drivers
LIMIT 100

-- We should use races as our main table since it has dates as well as raceid
SELECT *
FROM races
LIMIT 100

-- We need to join driver_standings since it will let us join raceid and driverid
SELECT *
FROM driver_standings
LIMIT 100

-- Here is our query: The average age of driver through the years
SELECT 
    EXTRACT(YEAR FROM races.date) AS year,
    ROUND(AVG(EXTRACT(EPOCH FROM AGE(races.date, drivers.dob)) / (365.25 * 24 * 60 * 60)), 2) AS avg_age_in_years
FROM races
INNER JOIN driver_standings AS ds
ON races.raceid = ds.raceid
INNER JOIN drivers
ON ds.driverid = drivers.driverid
GROUP BY 1
ORDER BY 1 DESC;
--Explanation: 1) Extracting years from the dates of the races since we will group by years.
-- 2) Calculates the age of each driver at the time of the race using AGE(races.date, drivers.dob)
-- 3) Converts the age to years by extracting the EPOCH (total seconds) and dividing by the number of seconds in a year (365.25 * 24 * 60 * 60).
-- 4) Rounds the average age to 2 decimal places using the ROUND() function.
-- 5) Groups the results by year and race date and orders them by year.

-- 2) Top 5 nanionalities by the number of drivers vs number of wins

WITH total_drivers AS (SELECT nationality, COUNT(*) AS total_drivers --total number of drivers
FROM drivers
GROUP BY nationality
ORDER BY 2 DESC),


total_wins AS (SELECT nationality, COUNT(*) AS total_wins
FROM races AS r
INNER JOIN driver_standings AS ds
ON r.raceid = ds.raceid
INNER JOIN drivers AS d
ON ds.driverid = d.driverid
WHERE position = 1
GROUP BY 1
ORDER BY 2 DESC) --total number of wins

SELECT tw.nationality, total_wins, total_drivers
FROM total_wins AS tw
INNER JOIN total_drivers AS td
ON tw.nationality = td.nationality



-- 3) Drivers Comparison

WITH max_verstappen_stat AS (
    SELECT
        'max_verstappen' AS driver_name,
        EXTRACT(YEAR FROM races.date) AS year, 
        MAX(ds.points) AS max_points, -- We have to use MAX because unfortunately there is no number we can sum :(
        COUNT(*) AS total_races,
        ROUND(MAX(ds.points) / COUNT(*),2) AS points_per_race
    FROM driver_standings AS ds
    INNER JOIN races
    ON ds.raceid=races.raceid
    WHERE ds.driverid = (SELECT driverid
            FROM drivers
            WHERE driverref = 'max_verstappen') 
            AND EXTRACT(YEAR FROM races.date) > 2009 -- Because before 2010 there was another system
    GROUP BY 2
    ORDER BY 4 DESC
),

hamilton_stat AS (
    SELECT
        'hamilton' AS driver_name,
        EXTRACT(YEAR FROM races.date) AS year, 
        MAX(ds.points) AS max_points, -- We have to use MAX because unfortunately there is no number we can sum :(
        COUNT(*) AS total_races,
        ROUND(MAX(ds.points) / COUNT(*),2) AS points_per_race
    FROM driver_standings AS ds
    INNER JOIN races
    ON ds.raceid=races.raceid
    WHERE ds.driverid = ( SELECT driverid
            FROM drivers
            WHERE driverref = 'hamilton') 
            AND EXTRACT(YEAR FROM races.date) > 2009 -- Because before 2010 there was another system
    GROUP BY 2
    ORDER BY 4 DESC
), 

leclerc_stat AS (
    SELECT
        'leclerc' AS driver_name,
        EXTRACT(YEAR FROM races.date) AS year, 
        MAX(ds.points) AS max_points, -- We have to use MAX because unfortunately there is no number we can sum :(
        COUNT(*) AS total_races,
        ROUND(MAX(ds.points) / COUNT(*),2) AS points_per_race
    FROM driver_standings AS ds
    INNER JOIN races
    ON ds.raceid=races.raceid
    WHERE ds.driverid = ( SELECT driverid
            FROM drivers
            WHERE driverref = 'leclerc') 
            AND EXTRACT(YEAR FROM races.date) > 2009 -- Because before 2010 there was another system
    GROUP BY 2
    ORDER BY 4 DESC
), 

sainz_stats AS (
    SELECT
        'sainz' AS driver_name,
        EXTRACT(YEAR FROM races.date) AS year, 
        MAX(ds.points) AS max_points, -- We have to use MAX because unfortunately there is no number we can sum :(
        COUNT(*) AS total_races,
        ROUND(MAX(ds.points) / COUNT(*),2) AS points_per_race
    FROM driver_standings AS ds
    INNER JOIN races
    ON ds.raceid=races.raceid
    WHERE ds.driverid = ( SELECT driverid
            FROM drivers
            WHERE driverref = 'sainz') 
            AND EXTRACT(YEAR FROM races.date) > 2009 -- Because before 2010 there was another system
    GROUP BY 2
    ORDER BY 4 DESC
),

perez_stats AS (
    SELECT
        'perez' AS driver_name,
        EXTRACT(YEAR FROM races.date) AS year, 
        MAX(ds.points) AS max_points, -- We have to use MAX because unfortunately there is no number we can sum :(
        COUNT(*) AS total_races,
        ROUND(MAX(ds.points) / COUNT(*),2) AS points_per_race
    FROM driver_standings AS ds
    INNER JOIN races
    ON ds.raceid=races.raceid
    WHERE ds.driverid = ( SELECT driverid
            FROM drivers
            WHERE driverref = 'perez') 
            AND EXTRACT(YEAR FROM races.date) > 2009 -- Because before 2010 there was another system
    GROUP BY 2
    ORDER BY 4 DESC
),

drivers_age AS (
    SELECT 
        driverref,
        forename,
        surname,
        ROUND(EXTRACT(EPOCH FROM AGE(now(), dob)) / (365.25 * 24 * 60 * 60),1) AS age_in_years
    FROM drivers
    WHERE driverref IN ('max_verstappen', 'hamilton', 'leclerc', 'sainz', 'perez')
)

SELECT *
FROM (SELECT *
    FROM max_verstappen_stat
UNION 
    SELECT * 
    FROM hamilton_stat
UNION 
    SELECT *
    FROM leclerc_stat
UNION
    SELECT *
    FROM sainz_stats
UNION
    SELECT *
    FROM perez_stats) AS union_stat
INNER JOIN drivers_age
ON union_stat.driver_name = drivers_age.driverref
ORDER BY points_per_race DESC

-- Now we will try to visualize data using simple Excel

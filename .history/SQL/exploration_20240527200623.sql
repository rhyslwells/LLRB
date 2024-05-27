-- Aggregate Statistics
-- Calculate the total number of shouts per month
SELECT DATE_FORMAT(date_of_shout, '%Y-%m') AS month_year, COUNT(*) AS shout_count
FROM Shout
GROUP BY month_year;

-- Data Exploration
-- Analyze trends in shout frequency over time
SELECT YEAR(date_of_shout) AS year, MONTH(date_of_shout) AS month, COUNT(*) AS shout_count
FROM Shout
GROUP BY year, month
ORDER BY year, month;

-- Data Cleansing and Validation
-- Check for duplicate entries in the Shout table
SELECT date_of_shout, time_of_shout, location_of_shout, COUNT(*) AS duplicate_count
FROM Shout
GROUP BY date_of_shout, time_of_shout, location_of_shout
HAVING COUNT(*) > 1;

-- Performance Optimization
-- Create an index on the location_of_shout column
CREATE INDEX idx_location_of_shout ON Shout(location_of_shout);

-- Data Transformation
-- Aggregate data to create a summary report of shouts per month
SELECT YEAR(date_of_shout) AS year, MONTH(date_of_shout) AS month, COUNT(*) AS shout_count
FROM Shout
GROUP BY year, month
ORDER BY year, month;



-- Integration with External Systems
-- Integrate with a weather API to update weather data for each shout
UPDATE Weather w
JOIN Shout s ON w.shout_id = s.shout_id
SET w.weather_at_time_of_shout = external_weather_api(s.location_of_shout, s.date_of_shout);

-- Data Backup and Recovery
-- Backup the Shout table
BACKUP TABLE Shout TO '/path/to/backup/directory';

-- Continuous Improvement
-- Monitor query performance using the EXPLAIN statement and optimize as needed
EXPLAIN SELECT * FROM Shout WHERE location_of_shout = 'Specific Location';

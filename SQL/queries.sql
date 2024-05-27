-- Sample Queries

-- 1. List all shouts with their crew members and their roles
SELECT s.date_of_shout, s.time_of_shout, s.location_of_shout, c.name AS crew_member, sc.on_board, sc.on_shore
FROM Shout s
JOIN Shout_Crew sc ON s.shout_id = sc.shout_id
JOIN Crew c ON sc.crew_id = c.crew_id;

-- 2. Find all shouts where a specific crew member participated
SELECT s.date_of_shout, s.time_of_shout, s.location_of_shout, c.name AS crew_member, sc.on_board, sc.on_shore
FROM Shout s
JOIN Shout_Crew sc ON s.shout_id = sc.shout_id
JOIN Crew c ON sc.crew_id = c.crew_id
WHERE c.name = 'John Doe';

-- 3. Count the number of shouts per crew member
SELECT c.name AS crew_member, COUNT(sc.shout_id) AS shout_count
FROM Crew c
LEFT JOIN Shout_Crew sc ON c.crew_id = sc.crew_id
GROUP BY c.name;

-- 4. Find all shouts with a specific pager code
SELECT *
FROM Shout
WHERE pager_code = 999;

-- 5. Calculate the average duration of shouts
SELECT AVG(TIMESTAMPDIFF(MINUTE, time_boat_launched, time_boat_returned)) AS avg_duration_minutes
FROM Shout
WHERE time_boat_launched IS NOT NULL AND time_boat_returned IS NOT NULL;

-- 6. List all shouts with their associated weather conditions
SELECT s.date_of_shout, s.time_of_shout, s.location_of_shout, w.weather_at_time_of_shout
FROM Shout s
JOIN Weather w ON s.shout_id = w.shout_id;

-- 7. Find the most common location for shouts
SELECT location_of_shout, COUNT(*) AS shout_count
FROM Shout
GROUP BY location_of_shout
ORDER BY shout_count DESC
LIMIT 1;

-- 8. List all crew members who were on board for a specific shout
SELECT c.name AS crew_member
FROM Crew c
JOIN Shout_Crew sc ON c.crew_id = sc.crew_id
WHERE sc.shout_id = (SELECT shout_id FROM Shout WHERE location_of_shout = 'Specific Location');

-- 9. Find all shouts with specific tags in shout details
SELECT *
FROM Shout
WHERE shout_details_tags LIKE '%specific_tag%';

-- 10. Find all shouts within a certain date range
SELECT *
FROM Shout
WHERE date_of_shout BETWEEN 'start_date' AND 'end_date';

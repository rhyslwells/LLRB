-- Create the database (this line is a placeholder for your environment setup)
-- .open LLRB.db

-- Import data from CSV into the temp table (this line assumes you're using the SQLite command line)
-- .import --csv cleaned.csv temp

-- -- Ensure the temp table has no duplicate rows
-- CREATE TABLE IF NOT EXISTS temp_cleaned AS
-- SELECT DISTINCT * FROM temp;

-- -- Drop the existing tables if they exist
-- DROP TABLE IF EXISTS all_data;
-- DROP TABLE IF EXISTS Shout;
-- DROP TABLE IF EXISTS Crew;
-- DROP TABLE IF EXISTS Shout_Crew;
-- DROP TABLE IF EXISTS Weather;

-- .tables

-- -- Create the new table with an INTEGER PRIMARY KEY for all_data
-- CREATE TABLE all_data (
--     id INTEGER PRIMARY KEY,
--     date_of_shout DATE NOT NULL,
--     time_of_shout TIME NOT NULL,
--     time_boat_launched TIME,
--     time_boat_returned TIME,
--     pager_code INT,
--     what_three_words VARCHAR(255),
--     location_of_shout VARCHAR(255),
--     core_lat_long VARCHAR(255),
--     shout_details TEXT,
--     shout_details_tags VARCHAR(255),
--     subcode VARCHAR(50),
--     crew_on_board TEXT,
--     crew_on_shore TEXT,
--     weather_at_time_of_shout VARCHAR(255)
-- );

-- -- Insert data from the temp_cleaned table into the new all_data table
-- INSERT INTO all_data (
--     date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, what_three_words, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode, crew_on_board, crew_on_shore, weather_at_time_of_shout
-- )
-- SELECT 
--     date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, what_three_words, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode, crew_on_board, crew_on_shore, weather_at_time_of_shout
-- FROM temp_cleaned;

-- -- -- Verify the data in the all_data table
-- SELECT * FROM all_data limit 3;

-- DROP TABLE IF EXISTS Shout;

-- -- Create the Shout table
-- CREATE TABLE Shout (
--     id INTEGER PRIMARY KEY,
--     all_data_id INTEGER,
--     date_of_shout DATE NOT NULL,
--     time_of_shout TIME NOT NULL,
--     time_boat_launched TIME,
--     time_boat_returned TIME,
--     pager_code INT,
--     subcode VARCHAR(50),
--     location_of_shout VARCHAR(255),
--     core_lat_long VARCHAR(255),
--     shout_details_tags VARCHAR(255),
--     shout_details TEXT,
--     FOREIGN KEY (all_data_id) REFERENCES all_data(id)
-- );

-- -- Insert data into the Shout table from temp_cleaned
-- INSERT INTO Shout (all_data_id, 
--     date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode
-- )
-- SELECT 
--     id,date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode
-- FROM all_data;

-- -- Verify the data in the Shout table
-- SELECT * FROM Shout Limit 3;

-- -- Create the Weather table
-- DROP TABLE IF EXISTS Weather;
-- CREATE TABLE Weather (
--     id INTEGER PRIMARY KEY,
--     all_data_id INTEGER,
--     weather_at_time_of_shout VARCHAR(255),
--     FOREIGN KEY (all_data_id) REFERENCES all_data(id)
-- );

-- -- Insert data into the Weather table from Shout
-- INSERT INTO Weather (all_data_id, weather_at_time_of_shout)
-- SELECT id, weather_at_time_of_shout
-- FROM all_data;

-- SELECT * FROM all_data Limit 3;

-- -- Verify the data in the Weather table
-- SELECT * FROM Weather Limit 3;

-- Select sample data from all_data
-- SELECT crew_on_board, crew_on_shore FROM all_data LIMIT 3;





-- SELECT * FROM Shout Limit 3;

-- from all_data I want to rcord which crew members were on board and which were on shore
-- I will create a new table Shout_Crew to record this information
--  This table is designed to store information about crew members associated with each shout, indicating whether they were on board or on shore.

-- SELECT * FROM Crew;


-- Drop the Shout_Crew table if it exists
DROP TABLE IF EXISTS Shout_Crew;

-- Create the Shout_Crew table
CREATE TABLE Shout_Crew (
    id INTEGER PRIMARY KEY,
    shout_id INTEGER NOT NULL,
    all_data_id INTEGER NOT NULL,
    crew_id INTEGER NOT NULL,
    crew_initials TEXT, -- Corrected column name from crew_intials to crew_initials
    on_board BOOLEAN NOT NULL DEFAULT 0,
    on_shore BOOLEAN NOT NULL DEFAULT 0,
    FOREIGN KEY (shout_id) REFERENCES Shout(id),
    FOREIGN KEY (all_data_id) REFERENCES all_data(id),
    FOREIGN KEY (crew_id) REFERENCES Crew(id)
);

-- note crew_on_board is a string of crew initials separated by commas

-- Insert data into the Shout_Crew table for crew members who were on board
INSERT INTO Shout_Crew (shout_id, all_data_id, crew_id, crew_initials, on_board)
SELECT 
    s.id, a.id, c.id, c.initials, 1
FROM all_data a
JOIN Shout s ON a.id = s.all_data_id
JOIN Crew c ON a.crew_on_board LIKE '%' || c.initials || '%';

-- Update the on_shore column based on crew_on_shore, only if crew member is not already marked as on board
UPDATE Shout_Crew 
SET on_shore = 1
WHERE all_data_id IN (
    SELECT a.id 
    FROM all_data a
    JOIN Shout s ON a.id = s.all_data_id
    JOIN Crew c ON a.crew_on_shore LIKE '%' || c.initials || '%'
)
AND on_board = 0; -- Ensure crew member is not already marked as on board


.tables

-- Verify the data in the Shout_Crew table
SELECT * FROM Shout_Crew
WHERE all_data_id = 2;



-- using Shout_crew i want to check which crew where on the first 3 shouts in all_data

SELECT id, crew_on_board,crew_on_shore FROM all_data LIMIT 5;

-- Retrieve the initials of crew members who were on board for the fifth shout (all_data_id = 5)
-- SELECT C.initials
-- FROM Shout_Crew SC
-- JOIN Crew C ON SC.crew_id = C.id
-- WHERE SC.all_data_id = 2
-- AND SC.on_board = 1;



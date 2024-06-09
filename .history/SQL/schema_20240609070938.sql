-- CREATE TABLE Shout (
--     shout_id INT AUTO_INCREMENT PRIMARY KEY,
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
--     subcode VARCHAR(50)
-- );

-- CREATE TABLE Crew (
--     crew_id INT AUTO_INCREMENT PRIMARY KEY,
--     initials VARCHAR(10) NOT NULL,
--     name VARCHAR(100) NOT NULL,
--     role VARCHAR(50) NOT NULL
-- );

-- CREATE TABLE Shout_Crew (
--     shout_crew_id INT AUTO_INCREMENT PRIMARY KEY,
--     shout_id INT NOT NULL,
--     crew_id INT NOT NULL,
--     on_board BOOLEAN,
--     on_shore BOOLEAN,
--     FOREIGN KEY (shout_id) REFERENCES Shout(shout_id),
--     FOREIGN KEY (crew_id) REFERENCES Crew(crew_id)
-- );

-- CREATE TABLE Weather (
--     weather_id INT AUTO_INCREMENT PRIMARY KEY,
--     shout_id INT NOT NULL,
--     weather_at_time_of_shout VARCHAR(255),
--     FOREIGN KEY (shout_id) REFERENCES Shout(shout_id)
-- );

-- -- Creates LLRB.db
-- .import --csv cleaned.csv temp

-- SELECT * FROM temp;
-- Step 1: Drop the existing table if it exists
DROP TABLE IF EXISTS all_data;

-- Step 2: Create the new table with an INTEGER PRIMARY KEY
CREATE TABLE all_data (
    shout_id INTEGER PRIMARY KEY,
    date_of_shout DATE NOT NULL,
    time_of_shout TIME NOT NULL,
    time_boat_launched TIME,
    time_boat_returned TIME,
    pager_code INT,
    what_three_words VARCHAR(255),
    location_of_shout VARCHAR(255),
    core_lat_long VARCHAR(255),
    shout_details TEXT,
    shout_details_tags VARCHAR(255),
    subcode VARCHAR(50),
    crew_on_board TEXT,
    crew_on_shore TEXT,
    weather_at_time_of_shout VARCHAR(255)
);

-- Step 3: Insert data from the temp table into the new table
INSERT INTO all_data (
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, subcode, crew_on_board, crew_on_shore, weather_at_time_of_shout
)
SELECT 
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, subcode, crew_on_board, crew_on_shore, weather_at_time_of_shout
FROM temp;

-- Step 4: Select data from the new table to verify the results
SELECT * FROM all_data;



-- INSERT INTO Shout (
--     date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, what_three_words, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode
-- )
-- SELECT 
--     date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, what_three_words, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode
-- FROM temp;

-- --- Weather insert

-- INSERT INTO Weather (shout_id, weather_at_time_of_shout)
-- SELECT id, weather_at_time_of_shout
-- FROM Shout;
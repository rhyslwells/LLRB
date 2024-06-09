-- Create the database (this line is a placeholder for your environment setup)
-- .open LLRB.db

-- Import data from CSV into the temp table (this line assumes you're using the SQLite command line)
-- .import --csv cleaned.csv temp

-- Ensure the temp table has no duplicate rows
CREATE TABLE IF NOT EXISTS temp_cleaned AS
SELECT DISTINCT * FROM temp;

-- Drop the existing tables if they exist
DROP TABLE IF EXISTS all_data;
DROP TABLE IF EXISTS Shout;
DROP TABLE IF EXISTS Crew;
DROP TABLE IF EXISTS Shout_Crew;
DROP TABLE IF EXISTS Weather;

-- Create the new table with an INTEGER PRIMARY KEY for all_data
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

-- Insert data from the temp_cleaned table into the new all_data table
INSERT INTO all_data (
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, subcode, crew_on_board, crew_on_shore, weather_at_time_of_shout
)
SELECT 
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, subcode, crew_on_board, crew_on_shore, weather_at_time_of_shout
FROM temp_cleaned;

-- Verify the data in the all_data table
SELECT * FROM all_data;

-- Create the Shout table
CREATE TABLE Shout (
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
    subcode VARCHAR(50)
);

-- Create the Crew table
CREATE TABLE Crew (
    crew_id INTEGER PRIMARY KEY,
    initials VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- Create the Shout_Crew table
CREATE TABLE Shout_Crew (
    shout_crew_id INTEGER PRIMARY KEY,
    shout_id INTEGER NOT NULL,
    crew_id INTEGER NOT NULL,
    on_board BOOLEAN,
    on_shore BOOLEAN,
    FOREIGN KEY (shout_id) REFERENCES Shout(shout_id),
    FOREIGN KEY (crew_id) REFERENCES Crew(crew_id)
);

-- Create the Weather table
CREATE TABLE Weather (
    weather_id INTEGER PRIMARY KEY,
    shout_id INTEGER NOT NULL,
    weather_at_time_of_shout VARCHAR(255),
    FOREIGN KEY (shout_id) REFERENCES Shout(shout_id)
);

-- Insert data into the Shout table from temp_cleaned
INSERT INTO Shout (
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, subcode
)
SELECT 
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, subcode
FROM temp_cleaned;

-- Insert data into the Weather table from Shout
INSERT INTO Weather (shout_id, weather_at_time_of_shout)
SELECT shout_id, weather_at_time_of_shout
FROM all_data;

-- Creates LLRB.db
.import --csv cleaned.csv temp


-- Create a temporary table for the raw data
CREATE TABLE temp_raw_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_of_shout DATE,
    time_of_shout TIME,
    time_boat_launched TIME,
    time_boat_returned TIME,
    pager_code INT,
    what_three_words VARCHAR(255),
    location_of_shout VARCHAR(255),
    core_lat_long VARCHAR(255),
    shout_details TEXT,
    shout_details_tags VARCHAR(255),
    crew_on_board VARCHAR(255),
    crew_on_shore VARCHAR(255),
    weather_at_time_of_shout VARCHAR(255),
    subcode VARCHAR(50)
);

INSERT INTO temp_raw_data (
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, crew_on_board, crew_on_shore, 
    weather_at_time_of_shout, subcode
)
SELECT 
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, crew_on_board, crew_on_shore, 
    weather_at_time_of_shout, subcode
FROM temp;

-- Deletes temporary table
DROP TABLE "temp";

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

-- .tables
-- -- SELECT * FROM temp_raw_data;
-- SELECT * FROM Shout;

-- INSERT INTO Shout (
--     date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, what_three_words, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode
-- )
-- SELECT 
--     date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
--     pager_code, what_three_words, location_of_shout, core_lat_long, 
--     shout_details, shout_details_tags, subcode
-- FROM temp_raw_data;

-- --- Crew insert

-- -- Assuming a function or procedure exists to split the crew strings and insert into Crew and Shout_Crew tables

-- DELIMITER //

-- CREATE PROCEDURE PopulateCrewAndShoutCrew()
-- BEGIN
--     DECLARE crew_name VARCHAR(100);
--     DECLARE shout_id INT;
--     DECLARE crew_id INT;
--     DECLARE done INT DEFAULT 0;
--     DECLARE cur CURSOR FOR SELECT id, crew_on_board, crew_on_shore FROM temp_raw_data;
--     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

--     OPEN cur;
--     read_loop: LOOP
--         FETCH cur INTO shout_id, crew_on_board, crew_on_shore;
--         IF done THEN
--             LEAVE read_loop;
--         END IF;

--         -- Process crew_on_board
--         SET @crew_list = crew_on_board;
--         SET @crew_names = SUBSTRING_INDEX(@crew_list, ',', 1);
--         WHILE LENGTH(@crew_list) > 0 DO
--             SET crew_name = SUBSTRING_INDEX(@crew_list, ',', 1);
--             SET @crew_list = TRIM(BOTH ',' FROM SUBSTRING(@crew_list, LENGTH(crew_name) + 2));
--             INSERT INTO Crew (name, role) VALUES (crew_name, 'on_board') ON DUPLICATE KEY UPDATE role='on_board';
--             SET crew_id = LAST_INSERT_ID();
--             INSERT INTO Shout_Crew (shout_id, crew_id, on_board) VALUES (shout_id, crew_id, TRUE);
--         END WHILE;

--         -- Process crew_on_shore
--         SET @crew_list = crew_on_shore;
--         SET @crew_names = SUBSTRING_INDEX(@crew_list, ',', 1);
--         WHILE LENGTH(@crew_list) > 0 DO
--             SET crew_name = SUBSTRING_INDEX(@crew_list, ',', 1);
--             SET @crew_list = TRIM(BOTH ',' FROM SUBSTRING(@crew_list, LENGTH(crew_name) + 2));
--             INSERT INTO Crew (name, role) VALUES (crew_name, 'on_shore') ON DUPLICATE KEY UPDATE role='on_shore';
--             SET crew_id = LAST_INSERT_ID();
--             INSERT INTO Shout_Crew (shout_id, crew_id, on_board) VALUES (shout_id, crew_id, FALSE);
--         END WHILE;
--     END LOOP;

--     CLOSE cur;
-- END //

-- DELIMITER ;

-- -- Execute the procedure
-- CALL PopulateCrewAndShoutCrew();

-- --- Weather insert

-- INSERT INTO Weather (shout_id, weather_at_time_of_shout)
-- SELECT id, weather_at_time_of_shout
-- FROM temp_raw_data;




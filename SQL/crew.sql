
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






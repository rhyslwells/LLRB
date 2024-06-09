-- Drop the Crew table if it exists
DROP TABLE IF EXISTS Crew;

-- Create the Crew table
CREATE TABLE Crew (
    id INTEGER PRIMARY KEY,
    initials VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL
);

-- Import crew data from crew.csv into a temporary table, skipping the first row
.import --csv --skip 1 crew.csv Crew_temp

-- Insert data from the Crew_temp table into the Crew table
INSERT INTO Crew (initials, name)
SELECT DISTINCT initials, name FROM Crew_temp;

-- Delete the row containing "initials" and "name" in the Crew table
DELETE FROM Crew WHERE initials = 'initials';

-- Verify the data in the Crew table
SELECT * FROM Crew;

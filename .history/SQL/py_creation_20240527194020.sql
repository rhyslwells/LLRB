import pandas as pd
from sqlalchemy import create_engine, text

# Load the cleaned CSV file
file_path = '/mnt/data/cleaned.csv'
data = pd.read_csv(file_path)

# Create a SQLAlchemy engine for connecting to your database
engine = create_engine('mysql+pymysql://username:password@localhost/your_database')

# Create the temporary table and load data into it
data.to_sql('temp_raw_data', con=engine, if_exists='replace', index=False, dtype={
    'date_of_shout': 'DATE',
    'time_of_shout': 'TIME',
    'time_boat_launched': 'TIME',
    'time_boat_returned': 'TIME',
    'pager_code': 'INT',
    'what_three_words': 'VARCHAR(255)',
    'location_of_shout': 'VARCHAR(255)',
    'core_lat_long': 'VARCHAR(255)',
    'shout_details': 'TEXT',
    'shout_details_tags': 'VARCHAR(255)',
    'crew_on_board': 'VARCHAR(255)',
    'crew_on_shore': 'VARCHAR(255)',
    'weather_at_time_of_shout': 'VARCHAR(255)',
    'subcode': 'VARCHAR(50)'
})

# SQL statements to create tables and populate data
create_tables_sql = """
CREATE TABLE Shout (
    shout_id INT AUTO_INCREMENT PRIMARY KEY,
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

CREATE TABLE Crew (
    crew_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE Shout_Crew (
    shout_crew_id INT AUTO_INCREMENT PRIMARY KEY,
    shout_id INT NOT NULL,
    crew_id INT NOT NULL,
    on_board BOOLEAN,
    FOREIGN KEY (shout_id) REFERENCES Shout(shout_id),
    FOREIGN KEY (crew_id) REFERENCES Crew(crew_id)
);

CREATE TABLE Weather (
    weather_id INT AUTO_INCREMENT PRIMARY KEY,
    shout_id INT NOT NULL,
    weather_at_time_of_shout VARCHAR(255),
    FOREIGN KEY (shout_id) REFERENCES Shout(shout_id)
);
"""

populate_shout_sql = """
INSERT INTO Shout (
    date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, 
    pager_code, what_three_words, location_of_shout, core_lat_long, 
    shout_details, shout_details_tags, subcode
)
SELECT 
    date_of_shout, time_of_shout, time_boat_launched, time_boat

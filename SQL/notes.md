Consider: cleaned.csv

Suppose I wanted to construct a database using SQL to make the most out of this data. 
How would I go about this? What would be the propose enity relation diagram?


To construct a database using SQL from this dataset, we need to create a relational model that effectively organizes the data. Here's a step-by-step approach:

Step 1: Identify Entities and Relationships
From the provided data, we can identify the following entities:

Shout: Each incident reported (date_of_shout, time_of_shout, location_of_shout, shout_details, etc.).
Crew: Information about crew members on board and on shore.
Weather: Weather conditions at the time of shout.

Step 2: Define Entity Attributes
Shout: shout_id, date_of_shout, time_of_shout, time_boat_launched, time_boat_returned, pager_code, what_three_words, location_of_shout, core_lat_long, shout_details, shout_details_tags, subcode
Crew: crew_id, name, role
Shout_Crew: Linking table to represent many-to-many relationships between Shout and Crew with shout_id, crew_id, on_board
Weather: weather_id, shout_id, weather_at_time_of_shout

Step 3: Design the Entity-Relationship Diagram (ERD)
Here's a textual representation of the ERD:

Shout
shout_id (Primary Key)
date_of_shout
time_of_shout
time_boat_launched
time_boat_returned
pager_code
what_three_words
location_of_shout
core_lat_long
shout_details
shout_details_tags
subcode

Crew
crew_id (Primary Key)
initials
name
role

Shout_Crew
shout_crew_id (Primary Key)
shout_id (Foreign Key)
crew_id (Foreign Key)
on_board (Boolean indicating if the crew member was on board or on shore)

Weather
weather_id (Primary Key)
shout_id (Foreign Key)
weather_at_time_of_shout

Step 4: Create SQL Tables
Based on the ERD, we can write SQL statements to create these tables:



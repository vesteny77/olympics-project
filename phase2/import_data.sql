-- loading the schema
\i schema.ddl 

-- create temporary tables
DROP TABLE IF EXISTS AthletesTmp CASCADE;
DROP TABLE IF EXISTS EventsTmp CASCADE;

CREATE TABLE AthletesTmp (
    id INT,
    name TEXT,
    nationality TEXT,
    sex TEXT,
    dob TIMESTAMP,
    height FLOAT,
    weight FLOAT,
    sport TEXT,
    gold INT,
    silver INT,
    bronze INT,
    PRIMARY KEY (id)
);

CREATE TABLE EventsTmp (
    id INT,
    sport TEXT,
    discipline TEXT,
    name TEXT,
    sex TEXT,
    venues TEXT,
    PRIMARY KEY (id)
);

-- load the data into temporary tables
\COPY AthletesTmp from /Users/steveny/Documents/csc343_files/olympics-project/data/athletes.csv with csv header

\COPY EventsTmp from /Users/steveny/Documents/csc343_files/olympics-project/data/events.csv with csv header

-- load the data into actual tables
\COPY Countries from /Users/steveny/Documents/csc343_files/olympics-project/data/countries_full.csv with csv header


-- insert data from temporary tables into the actual tables
INSERT INTO Athletes
	SELECT id, name, dob, height, weight
	FROM AthletesTmp;

INSERT INTO Performance
	SELECT id, nationality, sport, gold, silver, bronze
	FROM AthletesTmp;

INSERT INTO Events
	SELECT id, sport
	FROM EventsTmp;

-- drop temporary tables
DROP TABLE IF EXISTS AthletesTmp CASCADE;
DROP TABLE IF EXISTS EventsTmp CASCADE;

-- getting a description of each table 
-- \d Athletes
-- \d Countries
-- \d Performance
-- \d Events

-- --showing the number of rows in each table 
-- SELECT count(*) FROM Athletes;
-- SELECT count(*) FROM Countries;
-- SELECT count(*) FROM Performance;
-- SELECT count(*) FROM Events;

-- --showing a sample of each table's content
-- SELECT * FROM Athletes;
-- SELECT * FROM Countries;
-- SELECT * FROM Performance;
-- SELECT * FROM Events;

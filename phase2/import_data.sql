-- loading the schema
\i /Users/steveny/Documents/csc343_files/olympics-project/phase2/schema.ddl

-- create temporary tables
DROP TABLE IF EXISTS AthletesTmp CASCADE;
DROP TABLE IF EXISTS EventsTmp CASCADE;

CREATE TABLE AthletesTmp (
    id INT,
    name VARCHAR(80),
    nationality CHAR(3),
    sex TEXT,
    dob TIMESTAMP,
    height FLOAT,
    weight FLOAT,
    sport VARCHAR(35),
    gold INT,
    silver INT,
    bronze INT,
    PRIMARY KEY (id)
);

CREATE TABLE EventsTmp (
    id INT,
    sport VARCHAR(35),
    discipline TEXT,
    name TEXT,
    sex TEXT,
    venues TEXT,
    PRIMARY KEY (id)
);

-- load the data into temporary tables
\COPY AthletesTmp from /Users/steveny/Documents/csc343_files/olympics-project/data/athletes_cleaned.csv with csv header

\COPY EventsTmp from /Users/steveny/Documents/csc343_files/olympics-project/data/events_cleaned.csv with csv header

-- prepare constraint tables
INSERT INTO Events
	SELECT DISTINCT sport
	FROM EventsTmp;

INSERT INTO Entities
    SELECT DISTINCT nationality AS code
    FROM AthletesTmp
    ORDER BY nationality;

-- load the data into actual tables
\COPY Countries from /Users/steveny/Documents/csc343_files/olympics-project/data/countries_full_cleaned.csv with csv header

-- insert data from temporary tables into the actual tables
INSERT INTO Athletes
	SELECT id, name, dob, height, weight
	FROM AthletesTmp;

INSERT INTO Performance
	SELECT id, nationality, sport, gold, silver, bronze
	FROM AthletesTmp;


-- drop temporary tables
DROP TABLE IF EXISTS AthletesTmp CASCADE;
DROP TABLE IF EXISTS EventsTmp CASCADE;

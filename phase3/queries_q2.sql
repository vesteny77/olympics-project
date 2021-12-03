-- What does the ideal athlete for each sport look like? That is, does the weight, height, and age of an athlete
-- affect their likelihood to obtain a medal in their sports category?
-- And which category of sport has the strongest such correlation?

SET SEARCH_PATH TO Olympics;
DROP TABLE IF EXISTS q2 CASCADE;

CREATE TABLE q2 (
    id INT,
    age INT,
    height FLOAT,
    weight FLOAT,
    sport VARCHAR(35),
    gold INT,
    silver INT,
    bronze INT,
    total INT
);

-- Define Views
DROP VIEW IF EXISTS AthletePerformance CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceHeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAquatics CASCADE;
DROP VIEW IF EXISTS AthletePerformanceTableTennis CASCADE;
DROP VIEW IF EXISTS AthletePerformanceVolleyball CASCADE;

CREATE VIEW AthletePerformance AS
    SELECT id, (2016 - EXTRACT(YEAR FROM dob)) AS age, height, weight,
        sport, gold, silver, bronze, gold + silver + bronze as total
    FROM Athletes NATURAL JOIN Performance
    ORDER BY sport, total DESC;

-- First part
CREATE VIEW AthletePerformanceAge AS
    SELECT (2016 - EXTRACT(YEAR FROM dob)) AS age, sport,
        sum(gold) as gold, sum(silver) as silver, sum(bronze) as bronze, 
        sum(gold + silver + bronze) as total
    FROM Athletes NATURAL JOIN Performance
    WHERE (2016 - EXTRACT(YEAR FROM dob)) > 0
    GROUP BY age, sport
    ORDER BY sport, total DESC;

CREATE VIEW AthletePerformanceHeight AS
    SELECT height, sport, sum(gold) as gold, sum(silver) as silver, sum(bronze) as bronze,
        sum(gold + silver + bronze) as total
    FROM Athletes NATURAL JOIN Performance
    GROUP BY height, sport
    ORDER BY sport, total DESC;

CREATE VIEW AthletePerformanceWeight AS
    SELECT weight, sport, sum(gold) as gold, sum(silver) as silver, sum(bronze) as bronze,
        sum(gold + silver + bronze) as total
    FROM Athletes NATURAL JOIN Performance
    GROUP BY weight, sport
    ORDER BY sport, total DESC;

-- Second Part
CREATE VIEW AthletePerformanceAquatics AS
    SELECT age, height, weight, total
    FROM AthletePerformance
    WHERE sport = 'aquatics';

CREATE VIEW AthletePerformanceTableTennis AS
    SELECT age, height, weight, total
    FROM AthletePerformance
    WHERE sport = 'table tennis';

CREATE VIEW AthletePerformanceVolleyball AS
    SELECT age, height, weight, total
    FROM AthletePerformance
    WHERE sport = 'volleyball';

-- Output Results
INSERT INTO q2
    SELECT * FROM AthletePerformance;

-- SELECT * FROM AthletePerformanceAge;
-- SELECT * FROM AthletePerformanceHeight;
-- SELECT * FROM AthletePerformanceWeight;

COPY (SELECT * FROM AthletePerformanceage) to '/Users/steveny/Documents/csc343_files/olympics-project/phase3/athlete_performance_age.csv' csv header;
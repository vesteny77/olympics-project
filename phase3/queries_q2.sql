-- What does the ideal athlete for each sport look like? That is, does the weight, height, and age of an athlete
-- affect their likelihood to obtain a medal in their sports category?
-- And which category of sport has the strongest such correlation?

SET SEARCH_PATH TO Olympics;
DROP TABLE IF EXISTS q2_age CASCADE;
DROP TABLE IF EXISTS q2_weight CASCADE;
DROP TABLE IF EXISTS q2_height CASCADE;

CREATE TABLE q2_age (
    sport VARCHAR(35),
    age INT,
    total INT
);

CREATE TABLE q2_weight (
    sport VARCHAR(35),
    weight FLOAT,
    total INT
);

CREATE TABLE q2_height (
    sport VARCHAR(35),
    height FLOAT,
    total INT
);

-- Define Views
DROP VIEW IF EXISTS AthletePerformanceAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceHeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAquaticsAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceTableTennisAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceVolleyballAge CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAquaticsWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceTableTennisWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceVolleyballWeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceAquaticsHeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceTableTennisHeight CASCADE;
DROP VIEW IF EXISTS AthletePerformanceVolleyballHeight CASCADE;

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
CREATE VIEW AthletePerformanceAquaticsAge AS
    SELECT sport, age, total
    FROM AthletePerformanceAge
    WHERE sport = 'aquatics';

CREATE VIEW AthletePerformanceAquaticsWeight AS
    SELECT sport, weight, total
    FROM AthletePerformanceWeight
    WHERE sport = 'aquatics';

CREATE VIEW AthletePerformanceAquaticsHeight AS
    SELECT sport, height, total
    FROM AthletePerformanceHeight
    WHERE sport = 'aquatics';

CREATE VIEW AthletePerformanceTableTennisAge AS
    SELECT sport, age, total
    FROM AthletePerformanceAge
    WHERE sport = 'table tennis';

CREATE VIEW AthletePerformanceTableTennisWeight AS
    SELECT sport, weight, total
    FROM AthletePerformanceWeight
    WHERE sport = 'table tennis';

CREATE VIEW AthletePerformanceTableTennisHeight AS
    SELECT sport, height, total
    FROM AthletePerformanceHeight
    WHERE sport = 'table tennis';

CREATE VIEW AthletePerformanceVolleyballAge AS
    SELECT sport, age, total
    FROM AthletePerformanceAge
    WHERE sport = 'volleyball';

CREATE VIEW AthletePerformanceVolleyballWeight AS
    SELECT sport, weight, total
    FROM AthletePerformanceWeight
    WHERE sport = 'volleyball';

CREATE VIEW AthletePerformanceVolleyballHeight AS
    SELECT sport, height, total
    FROM AthletePerformanceHeight
    WHERE sport = 'volleyball';

-- Output Results
INSERT INTO q2_age
    SELECT * FROM AthletePerformanceAquaticsAge LIMIT 1;
INSERT INTO q2_age
    SELECT * FROM AthletePerformanceTableTennisAge LIMIT 1;
INSERT INTO q2_age
    SELECT * FROM AthletePerformanceVolleyballAge LIMIT 1;

INSERT INTO q2_height
    SELECT * FROM AthletePerformanceAquaticsHeight LIMIT 1;
INSERT INTO q2_height
    SELECT * FROM AthletePerformanceTableTennisHeight LIMIT 1;
INSERT INTO q2_height
    SELECT * FROM AthletePerformanceVolleyballHeight LIMIT 1;

INSERT INTO q2_weight
    SELECT * FROM AthletePerformanceAquaticsWeight LIMIT 1;
INSERT INTO q2_weight
    SELECT * FROM AthletePerformanceTableTennisWeight LIMIT 1;
INSERT INTO q2_weight
    SELECT * FROM AthletePerformanceVolleyballWeight LIMIT 1;
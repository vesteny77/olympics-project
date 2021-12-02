-- In which sport category (if exists), is each country
-- 1) most likely to obtain more medals than other sports and 
-- 2) most likely to obtain more medals then other countries?

SET SEARCH_PATH TO Olympics;
DROP TABLE IF EXISTS q3a CASCADE;
DROP TABLE IF EXISTS q3b CASCADE;

CREATE TABLE q3a (
    country VARCHAR(60),
    sport VARCHAR(60),
    num_medals INT
);

CREATE TABLE q3b(
    sport VARCHAR(60),
    country VARCHAR(60),
    num_medals INT
);

-- Define Views
DROP VIEW IF EXISTS totalpersport CASCADE;
DROP VIEW IF EXISTS aggtps CASCADE;
DROP VIEW IF EXISTS best CASCADE;

-- Total number of medals for each sport for nation 
CREATE VIEW totalpersport AS (
    SELECT nationality, sport, (gold + silver + bronze) as total
    FROM Performance
    WHERE (gold + silver + bronze) <> 0
);

-- Aggerated results from totalpersport 
CREATE VIEW aggtps AS (
    SELECT nationality, sport, sum(total) as total
    FROM totalpersport
    GROUP BY nationality, sport
);

-- The sport with top number of medal for each country
CREATE VIEW isbestC AS (
    SELECT nationality as code, sport, total
    FROM aggtps a1
    WHERE total >= ALL(
        SELECT total
        FROM aggtps a2
        WHERE a1.nationality = a2.nationality and a1.sport <> a2.sport
        )
);

-- Replace the sport column as Null for countries with no sports that won the most medals 
CREATE VIEW nobestC AS (
    SELECT code, NULL as sport, 0 as total
    FROM countries
    WHERE code NOT IN(
        SELECT code FROM isbestC
    )
);

-- JOIN the two 
CREATE VIEW besttempC AS (SELECT * FROM isbestC) UNION (SELECT * FROM nobestC);

-- The country with top number of medal for each sport
CREATE VIEW isbestS AS (
    SELECT sport, nationality as code, total
    FROM aggtps a1
    WHERE total >= ALL (
        SELECT total 
        FROM aggtps a2
        WHERE a1.sport = a2.sport and a1.nationality <> a2.nationality
    )
);

-- Replace the country column as Null for sports with no country that won the most medals
CREATE VIEW nobestS AS (
    SELECT sport, NULL as code, 0 as total 
    FROM events
    WHERE sport NOT IN (
        SELECT sport from isbestS
    )
);

-- Join the two
CREATE VIEW besttempS AS (SELECT * FROM isbestS) UNION (SELECT * FROM nobestS);

-- Sort the results for part 1 by the country code (just for being viewing)
CREATE VIEW bestC AS (
    SELECT * 
    FROM besttempC
    ORDER BY code
);

-- Sort the results for part 2 by the name of sport (just for being viewing)
CREATE VIEW bestS AS (
    SELECT * 
    FROM besttempS
    ORDER BY sport
);

-- Output Results
insert into q3a select * from bestC;
insert into q3b select * from bestS;

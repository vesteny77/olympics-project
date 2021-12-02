-- In which sport category (if exists), is each country
-- 1) most likely to obtain more medals than other sports and
-- 2) most likely to obtain more medals than other countries?

SET SEARCH_PATH TO Olympics;
DROP TABLE IF EXISTS q1 CASCADE;

CREATE TABLE q3 (
    country VARCHAR(60),
    sport VARCHAR(60),
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
CREATE VIEW best AS (
    SELECT nationality, sport, total
    FROM aggtps a1
    WHERE total >= ALL(
        SELECT total
        FROM aggtps a2
        WHERE a1.nationality = a2.nationality and a1.sport <> a2.sport
        )
);

-- Output Results
insert into q3 select * from best;

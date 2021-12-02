-- How does a country’s living condition indicated by its GDP per capita affect its performance in the Olympics
-- indicated by the number of medals won by its athletes? And how does GDP affect performance of athletes?

SET SEARCH_PATH TO Olympics;
DROP TABLE IF EXISTS q1 CASCADE;

CREATE TABLE q1 (
    country VARCHAR(60),
    gdp_per_capita FLOAT,
    gdp FLOAT,
    gold INT,
    silver INT,
    bronze INT,
    total INT
);
-- Define Views
DROP VIEW IF EXISTS numMedals CASCADE;
DROP VIEW IF EXISTS countrygdp CASCADE;

-- number of each types of medals won by each country
CREATE VIEW numMedals AS 
    SELECT nationality, sum(gold) as numGold, sum(silver) as numSilver, sum(bronze) as numBronze
    FROM performance
    GROUP BY nationality ;

CREATE VIEW countrygdp AS
    SELECT country, gdp_per_capita, (gdp_per_capita * population) as gdp, numGold, numSilver, numBronze, 
        (numGold + numSilver + numBronze) as total
    FROM countries, numMedals
    WHERE countries.code = numMedals.nationality
    ORDER BY total DESC;

-- Output Results
insert into q1 select * from countrygdp;

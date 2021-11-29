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
DROP VIEW IF EXISTS IntermediateView CASCADE;

CREATE VIEW IntermediateView;

-- Output Results
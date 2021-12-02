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
DROP VIEW IF EXISTS IntermediateView CASCADE;


CREATE VIEW IntermediateView;

-- Output Results
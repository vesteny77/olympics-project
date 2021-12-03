DROP SCHEMA IF EXISTS Olympics CASCADE;
CREATE SCHEMA Olympics;
SET SEARCH_PATH TO Olympics;

-- A tuple in this relation represents an athlete that participated
-- in the 2016 Olympics in Rio de Janeiro.
CREATE TABLE Athletes (
    id INT NOT NULL,
    name VARCHAR(80),
    dob TIMESTAMP NOT NULL,
    height FLOAT NOT NULL,
    weight FLOAT NOT NULL,
    CHECK (height > 0.0 AND height < 3.0),
    CHECK (weight > 0.0),
    PRIMARY KEY (id)
);

-- A tuple in this table represents a country or an association that participated in the Olympics
CREATE TABLE Entities (
    code CHAR(3) PRIMARY KEY
);

-- A tuple in this relation represents a country that participated
-- in the 2016 Olympics in Rio de Janeiro.
CREATE TABLE Countries (
    country VARCHAR(60) NOT NULL,
    code CHAR(3) NOT NULL,
    population FLOAT NOT NULL,
    gdp_per_capita FLOAT NOT NULL,
    PRIMARY KEY (code),
    UNIQUE (country),
    FOREIGN KEY (code) REFERENCES Entities,
    CHECK (population > 0 AND gdp_per_capita > 0.0)
);

-- A tuple in this table represents a sport category in 2016 Olympics.
CREATE TABLE Events (
    sport VARCHAR(35) PRIMARY KEY
);

-- A tuple in this relation represents the fact that an athlete
-- obtained a certain number of gold, silver, and bronze medals
-- for a particular sport in the 2016 Olympics.
CREATE TABLE Performance (
    id INT NOT NULL,
    nationality CHAR(3) NOT NULL,
    sport VARCHAR(35) NOT NULL,
    gold INT NOT NULL,
    silver INT NOT NULL,
    bronze INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Athletes,
    FOREIGN KEY (sport) REFERENCES Events,
    FOREIGN KEY (nationality) REFERENCES Entities,
    CHECK (gold >= 0 AND silver >= 0 AND bronze >= 0)
);

DROP SCHEMA IF EXISTS Olympics CASCADE;
CREATE SCHEMA Olympics;
SET SEARCH_PATH TO Olympics;

CREATE TABLE Atheletes (
    id INT NOT NULL,
    name TEXT,
    dob TIMESTAMP NOT NULL,
    height FLOAT NOT NULL,
    weight FLOAT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Performance (
    id INT NOT NULL,
    nationality TEXT NOT NULL,
    sport TEXT NOT NULL,
    gold INT NOT NULL,
    silver INT NOT NULL,
    bronze INT NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE Countries (
    country TEXT NOT NULL,
    code INT NOT NULL,
    population FLOAT NOT NULL,
    gdb_per_capita FLOAT NOT NULL,
    PRIMARY KEY (code),
    UNIQUE (country)
);

CREATE TABLE Events (
    id INT NOT NULL,
    sport TEXT NOT NULL,
    PRIMARY KEY (id)
);

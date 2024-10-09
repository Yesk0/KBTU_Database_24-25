
CREATE DATABASE Faculty;

CREATE TABLE Students (
    id SERIAL,
    firstname VARCHAR(70),
    lastname VARCHAR(70)
);

ALTER TABLE Students ADD gender INTEGER;

ALTER TABLE Students ALTER COLUMN gender SET DEFAULT 0;

ALTER TABLE Students ADD PRIMARY KEY (id);

CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INTEGER
);

DROP TABLE tasks;

DROP TABLE Students;

DROP DATABASE Faculty;

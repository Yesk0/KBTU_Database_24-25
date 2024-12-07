CREATE TABLE Reviewer (
    rID INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Movie (
    mID INT PRIMARY KEY,
    title VARCHAR(200),
    year INT,
    director VARCHAR(100)
);

CREATE TABLE Rating (
    rID INT REFERENCES Reviewer(rID),
    mID INT REFERENCES Movie(mID),
    stars INT CHECK(stars BETWEEN 1 AND 10),
    ratingDate DATE,
    PRIMARY KEY (rID, mID)
);


INSERT INTO Reviewer (rID, name) VALUES
(201, 'Sarah Martinez'),
(202, 'Daniel Lewis'),
(203, 'Brittany Harris'),
(204, 'Mike Anderson'),
(205, 'Chris Jackson'),
(206, 'Elizabeth Thomas'),
(207, 'James Cameron'),
(208, 'Ashley White');

INSERT INTO Movie (mID, title, year, director) VALUES
(101, 'Gone with the Wind', 1939, 'Victor Fleming'),
(102, 'Star Wars', 1977, 'George Lucas'),
(103, 'The Sound of Music', 1965, 'Robert Wise'),
(104, 'E.T.', 1982, 'Steven Spielberg'),
(105, 'Titanic', 1997, 'James Cameron'),
(106, 'Snow White', 1937, NULL),
(107, 'Avatar', 2009, 'James Cameron'),
(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES
(201, 101, 2, '2011-01-22'),
(201, 101, 4, '2011-01-27'),
(202, 106, 4, NULL),
(203, 103, 2, '2011-01-20'),
(203, 108, 4, '2011-01-12'),
(204, 101, 3, '2011-01-09'),
(207, 103, 3, '2011-01-27'),
(205, 104, 2, '2011-01-22');


CREATE OR REPLACE FUNCTION add_reviewer(rID INT, name VARCHAR)
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Reviwer WHERE rID = $1) THEN
       INSERT INTO Reviewer(rID, name) VALUES ($1, $2)
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Добавление рецензента Miras с ID 209
SELECT add_reviewer(209, 'Miras');


CREATE OR REPLACE FUNCTION avg_movie_rating(mID INT)
RETURNS FLOAT AS $$
DECLARE
       avg_rating FLOAT;
BEGIN
    SELECT AVG(stars) INTO avg_rating FROM Rating WHERE mID = $1;
    RETURN avg_rating;
END;
$$ LANGUAGE plpgsql;

-- Проверка функции для фильма с ID 108
SELECT avg_movie_rating(108);


CREATE OR REPLACE count_movies_by_director(director_name VARCHAR)
RETURNS INT AS $$
DECLARE
       count_movie INT;
BEGIN
    SELECT COUNT(*) INTO count_movie FROM Movie WHERE director = $1;
    RETURN count_movie;
END;
$$ LANGUAGE plpgsql;

-- Проверка функции для режиссёра James Cameron
SELECT count_movies_by_director('James Cameron');


CREATE OR REPLACE FUNCTION update_rating(rID INT, mID INT, new_star INT)
RETURNS VOID AS $$
BEGIN
    IF EXISTS(SELECT 1 FROM RATING WHERE rID = $1 AND mID = $2) THEN
       UPDATE Rating SET new_star = $3 WHERE rID = $1 AND mID = $2;
    ELSE
        INSERT INTO Rating (rID, mID, new_star) VALUES($1, $2, $3, CURRENT_DATE);
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Пример вызова функции
SELECT update_rating(201, 108, 5);


CREATE OR REPLACE FUNCTION movie_rating_summary(mID INT, OUT highest INT, OUT lowest INT, OUT avg_rating FLOAT)
AS $$
BEGIN
    SELECT MAX(stars), MIN(stars), AVG(stars)
    INTO highest, lowest, avg_rating
    FROM Rating
    WHERE mID = $1;
END;
$$ LANGUAGE plpgsql;

-- Пример вызова функции
SELECT * FROM movie_rating_summary(108);


DO $$
DECLARE
    counter INT := 10; -- Внешняя переменная
BEGIN
    RAISE NOTICE 'Outer counter: %', counter; -- Печатаем значение внешней переменной
    BEGIN
        DECLARE
            counter INT := 5; -- Внутренняя переменная с тем же именем
        BEGIN
            RAISE NOTICE 'Inner counter: %', counter; -- Печатаем значение внутренней переменной
        END;
    END;
    RAISE NOTICE 'Outer counter after inner block: %', counter; -- Печатаем значение внешней переменной снова
END;
$$;


CREATE OR REPLACE FUNCTION movies_with_avg_rating()
RETURNS TABLE(title VARCHAR, avg_rating FLOAT) AS $$
BEGIN
    RETURN QUERY
    SELECT M.title, AVG(R.stars)
    FROM Movie M
    JOIN Rating R ON M.mID = R.mID
    GROUP BY M.title
    HAVING COUNT(R.stars) > 0;
END;
$$ LANGUAGE plpgsql;

-- Пример вызова функции
SELECT * FROM movies_with_avg_rating();


CREATE OR REPLACE FUNCTION get_movies(year INT)
RETURNS TABLE(title VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT title FROM Movie WHERE year = $1;
END;
$$ LANGUAGE plpgsql;

-- Пример вызова функции
SELECT * FROM get_movies(1997);

CREATE OR REPLACE FUNCTION get_movies(director_name VARCHAR)
RETURNS TABLE(title VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT title FROM Movie WHERE director = $1;
END;
$$ LANGUAGE plpgsql;

-- Пример вызова функции
SELECT * FROM get_movies('James Cameron');

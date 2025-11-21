DROP DATABASE IF EXISTS Movies2324;
CREATE DATABASE Movies2324;
USE Movies2324;

CREATE USER IF NOT EXISTS 'flaskuser'@'localhost' 
IDENTIFIED WITH mysql_native_password BY 'flaskpass123!';

GRANT ALL PRIVILEGES ON Movies2324.* TO 'flaskuser'@'localhost';

FLUSH PRIVILEGES;

CREATE TABLE Movies (
    tconst VARCHAR(10) PRIMARY KEY,
    primaryTitle VARCHAR(255),
    isAdult INT,
    startYear INT,
    runtimeMinutes INT
) ENGINE=InnoDB;

CREATE TABLE Genres (
    tconst VARCHAR(10),
    genre VARCHAR(255),
    PRIMARY KEY (tconst, genre),
    FOREIGN KEY (tconst) REFERENCES Movies(tconst)
) ENGINE=InnoDB;

CREATE TABLE Names (
    nconst VARCHAR(10) PRIMARY KEY,
    primaryName VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Directors (
    tconst VARCHAR(10),
    nconst VARCHAR(10),
    PRIMARY KEY (tconst, nconst),
    FOREIGN KEY (tconst) REFERENCES Movies(tconst),
    FOREIGN KEY (nconst) REFERENCES Names(nconst)
) ENGINE=InnoDB;

CREATE TABLE Writers (
    tconst VARCHAR(10),
    nconst VARCHAR(10),
    PRIMARY KEY (tconst, nconst),
    FOREIGN KEY (tconst) REFERENCES Movies(tconst),
    FOREIGN KEY (nconst) REFERENCES Names(nconst)
) ENGINE=InnoDB;

CREATE TABLE Ratings (
    tconst VARCHAR(10) PRIMARY KEY,
    averageRating DECIMAL(3,1),
    numVotes INT,
    FOREIGN KEY (tconst) REFERENCES Movies(tconst)
) ENGINE=InnoDB;

SET GLOBAL local_infile = true;

LOAD DATA LOCAL INFILE '~/Desktop/movies_2324/data/movies.csv'
INTO TABLE Movies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, primaryTitle, isAdult, startYear, runtimeMinutes);

LOAD DATA LOCAL INFILE '~/Desktop/movies_2324/data/genres.csv'
INTO TABLE Genres
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, genre);

LOAD DATA LOCAL INFILE '~/Desktop/movies_2324/data/names.csv'
INTO TABLE Names
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nconst, primaryName);

LOAD DATA LOCAL INFILE '~/Desktop/movies_2324/data/directors.csv'
INTO TABLE Directors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, nconst);

LOAD DATA LOCAL INFILE '~/Desktop/movies_2324/data/writers.csv'
INTO TABLE Writers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, nconst);

LOAD DATA LOCAL INFILE '~/Desktop/movies_2324/data/ratings.csv'
INTO TABLE Ratings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(tconst, averageRating, numVotes);

CREATE INDEX idx_movies_isAdult ON Movies(isAdult);
CREATE INDEX idx_movies_startYear ON Movies(startYear);
CREATE INDEX idx_movies_runtimeMinutes ON Movies(runtimeMinutes);

CREATE INDEX idx_genres_genre_tconst ON Genres(genre, tconst);

CREATE INDEX idx_names_primaryName ON Names(primaryName(255));

CREATE INDEX idx_directors_nconst ON Directors(nconst);

CREATE INDEX idx_writers_nconst ON Writers(nconst);

CREATE INDEX idx_ratings_numVotes_avgRating ON Ratings(numVotes, averageRating);
CREATE INDEX idx_ratings_avgRating ON Ratings(averageRating);
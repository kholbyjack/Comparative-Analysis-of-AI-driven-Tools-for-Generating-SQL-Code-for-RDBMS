-- Horse Racing Database
-- MySQL-compatible schema

CREATE DATABASE IF NOT EXISTS horse_racing_db;
USE horse_racing_db;

CREATE TABLE Owners (
    owner_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE Trainers (
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE Jockeys (
    jockey_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    birth_date DATE
);

CREATE TABLE Tracks (
    track_id INT PRIMARY KEY AUTO_INCREMENT,
    track_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    surface VARCHAR(30)
);

CREATE TABLE Horses (
    horse_id INT PRIMARY KEY AUTO_INCREMENT,
    horse_name VARCHAR(100),
    birth_date DATE,
    sex VARCHAR(20),
    breed VARCHAR(50),
    owner_id INT,
    trainer_id INT,

    CONSTRAINT fk_horses_owner
        FOREIGN KEY (owner_id)
        REFERENCES Owners(owner_id),

    CONSTRAINT fk_horses_trainer
        FOREIGN KEY (trainer_id)
        REFERENCES Trainers(trainer_id)
);

CREATE TABLE Races (
    race_id INT PRIMARY KEY AUTO_INCREMENT,
    race_name VARCHAR(100),
    race_date DATE,
    track_id INT,
    distance INT,
    race_type VARCHAR(50),
    prize_money DECIMAL(12,2),

    CONSTRAINT fk_races_track
        FOREIGN KEY (track_id)
        REFERENCES Tracks(track_id)
);

CREATE TABLE RaceResults (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    race_id INT,
    horse_id INT,
    jockey_id INT,
    finish_position INT,
    finishing_time DECIMAL(8,3),
    starting_odds DECIMAL(8,2),
    prize_earned DECIMAL(12,2),

    CONSTRAINT fk_results_race
        FOREIGN KEY (race_id)
        REFERENCES Races(race_id),

    CONSTRAINT fk_results_horse
        FOREIGN KEY (horse_id)
        REFERENCES Horses(horse_id),

    CONSTRAINT fk_results_jockey
        FOREIGN KEY (jockey_id)
        REFERENCES Jockeys(jockey_id)
);

-- Optional indexes to improve joins and foreign-key lookups
CREATE INDEX idx_horses_owner_id ON Horses(owner_id);
CREATE INDEX idx_horses_trainer_id ON Horses(trainer_id);
CREATE INDEX idx_races_track_id ON Races(track_id);
CREATE INDEX idx_results_race_id ON RaceResults(race_id);
CREATE INDEX idx_results_horse_id ON RaceResults(horse_id);
CREATE INDEX idx_results_jockey_id ON RaceResults(jockey_id);

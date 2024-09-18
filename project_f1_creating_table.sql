-- Creating Tables based on their values. Every Table should be created in the correct order from. From 1 to 14. 
CREATE TABLE circuits (
    circuitId INT PRIMARY KEY,
    circuitRef VARCHAR(255),
    name VARCHAR(255),
    location VARCHAR(255),
    country VARCHAR(100),
    lat DECIMAL(9, 6),
    lng DECIMAL(9, 6),
    alt INT,
    url VARCHAR(255)
);--1 circuits (no dependencies)

CREATE TABLE constructors (
    constructorId INT PRIMARY KEY,
    constructorRef VARCHAR(50),
    name VARCHAR(100),
    nationality VARCHAR(50),
    url VARCHAR(255)
);--3 constructors (no dependencies)

CREATE TABLE constructor_results (
    constructorResultsId INT PRIMARY KEY,
    raceId INT,
    constructorId INT,
    points DECIMAL(5, 2),
    status VARCHAR(10),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId),
    FOREIGN KEY (raceId) REFERENCES races(raceId)
);--7 constructor_results (depends on races and constructors)

CREATE TABLE constructor_standings (
    constructorStandingsId INT PRIMARY KEY,
    raceId INT,
    constructorId INT,
    points DECIMAL(5, 2),
    position INT,
    positionText VARCHAR(10),
    wins INT,
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId),
    FOREIGN KEY (raceId) REFERENCES races(raceId)
);--8 constructor_standings (depends on races and constructors)

CREATE TABLE drivers (
    driverId INT PRIMARY KEY,
    driverRef VARCHAR(50),
    number INT,
    code VARCHAR(3),
    forename VARCHAR(100),
    surname VARCHAR(100),
    dob DATE,
    nationality VARCHAR(50),
    url VARCHAR(255)
);--4 drivers (no dependencies)

CREATE TABLE driver_standings (
    driverStandingsId INT PRIMARY KEY,
    raceId INT,
    driverId INT,
    points DECIMAL(5, 2),
    position INT,
    positionText VARCHAR(10),
    wins INT,
    FOREIGN KEY (driverId) REFERENCES drivers(driverId),
    FOREIGN KEY (raceId) REFERENCES races(raceId)
);--9 driver_standings (depends on races and drivers)

CREATE TABLE lap_times (
    raceId INT,
    driverId INT,
    lap INT,
    position INT,
    time INTERVAL,
    milliseconds INT,
    PRIMARY KEY (raceId, driverId, lap),
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId)
);--10 lap_times (depends on races and drivers)

CREATE TABLE pit_stops (
    raceId INT,
    driverId INT,
    stop INT,
    lap INT,
    time VARCHAR(20), --needs to be cleaned first. 
    duration DECIMAL(6, 3),
    milliseconds INT,
    PRIMARY KEY (raceId, driverId, stop),
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId)
);--11 pit_stops (depends on races and drivers)

CREATE TABLE qualifying (
    qualifyId INT PRIMARY KEY,
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    position INT,
    q1 VARCHAR(10),
    q2 VARCHAR(10),
    q3 VARCHAR(10),
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId)
);--12 qualifying (depends on races, drivers, and constructors)

CREATE TABLE races (
    raceId INT PRIMARY KEY,
    year INT,
    round INT,
    circuitId INT,
    name VARCHAR(255),
    date DATE,
    time TIME,
    url VARCHAR(255),
    fp1_date DATE,
    fp1_time TIME,
    fp2_date DATE,
    fp2_time TIME,
    fp3_date DATE,
    fp3_time TIME,
    quali_date DATE,
    quali_time TIME,
    sprint_date DATE,
    sprint_time TIME,
    FOREIGN KEY (circuitId) REFERENCES circuits(circuitId),
    FOREIGN KEY (year) REFERENCES seasons(year)
);--6 races (depends on circuits and seasons)

CREATE TABLE results (
    resultId INT PRIMARY KEY,
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    grid INT,
    position INT,
    positionText VARCHAR(30),
    positionOrder INT,
    points DECIMAL(7,4),
    laps INT,
    time VARCHAR(30),
    milliseconds VARCHAR(30), --needs to be cleaned first. 
    fastestLap INT,
    rank INT,
    fastestLapTime VARCHAR(30),
    fastestLapSpeed DECIMAL(7, 4),
    statusId INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId),
    FOREIGN KEY (statusId) REFERENCES status(statusId)
);--13 results (depends on races, drivers, constructors, and status)

CREATE TABLE seasons (
    year INT PRIMARY KEY,
    url VARCHAR(255)
);--2 seasons (no dependencies)

CREATE TABLE sprint_results (
    resultId INT PRIMARY KEY,
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    grid INT,
    position INT,
    positionText VARCHAR(10),
    positionOrder INT,
    points DECIMAL(5, 2),
    laps INT,
    time VARCHAR(10),
    milliseconds BIGINT,
    fastestLap INT,
    fastestLapTime VARCHAR(10),
    statusId INT,
    FOREIGN KEY (raceId) REFERENCES races(raceId),
    FOREIGN KEY (driverId) REFERENCES drivers(driverId),
    FOREIGN KEY (constructorId) REFERENCES constructors(constructorId),
    FOREIGN KEY (statusId) REFERENCES status(statusId)
);--14 sprint_results (depends on races, drivers, constructors, and status)

CREATE TABLE status (
    statusId INT PRIMARY KEY,
    status VARCHAR(50)
);--5 status (no dependencies)
-- Inserting Data into our tables from CSV files. Every Table should be created in the correct order from. From 1 to 14.
COPY circuits (circuitId, circuitRef, name, location, country, lat, lng, alt, url)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/circuits.csv'
DELIMITER ','
CSV HEADER;--1 circuits (no dependencies)

COPY constructor_results (constructorResultsId, raceId, constructorId, points, status)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/constructor_results.csv'
DELIMITER ','
CSV HEADER;--7 constructor_results (depends on races and constructors)

COPY constructor_standings (constructorStandingsId, raceId, constructorId, points, position, positionText, wins)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/constructor_standings.csv'
DELIMITER ','
CSV HEADER;--8 constructor_standings (depends on races and constructors)

COPY constructors (constructorId, constructorRef, name, nationality, url)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/constructors.csv'
DELIMITER ','
CSV HEADER;--3 constructors (no dependencies)

COPY driver_standings (driverStandingsId, raceId, driverId, points, position, positionText, wins)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/driver_standings.csv'
DELIMITER ','
CSV HEADER;--9 driver_standings (depends on races and drivers)

COPY drivers (driverId, driverRef, number, code, forename, surname, dob, nationality, url)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/drivers.csv'
DELIMITER ','
CSV HEADER
NULL AS '\N';--4 drivers (no dependencies)

COPY lap_times (raceId, driverId, lap, position, time, milliseconds)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/lap_times.csv'
DELIMITER ','
CSV HEADER;--10 lap_times (depends on races and drivers)

COPY pit_stops (raceId, driverId, stop, lap, time, duration, milliseconds)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/pit_stops.csv'
DELIMITER ','
CSV HEADER;--11 pit_stops (depends on races and drivers)

COPY qualifying (qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/qualifying.csv'
DELIMITER ','
CSV HEADER;--12 qualifying (depends on races, drivers, and constructors)

COPY races (raceId, year, round, circuitId, name, date, time, url, fp1_date, fp1_time, fp2_date, fp2_time, fp3_date, fp3_time, quali_date, quali_time, sprint_date, sprint_time)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/races.csv'
DELIMITER ','
CSV HEADER
NULL AS '\N';--6 races (depends on circuits and seasons)

COPY results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, rank, fastestLapTime, fastestLapSpeed, statusId)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/results.csv'
DELIMITER ','
CSV HEADER
NULL AS '\N';--13 results (depends on races, drivers, constructors, and status)

COPY seasons (year, url)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/seasons.csv'
DELIMITER ','
CSV HEADER;--2 seasons (no dependencies)

COPY sprint_results (resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, fastestLap, fastestLapTime, statusId)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/sprint_results.csv'
DELIMITER ','
CSV HEADER
NULL AS '\N';--14 sprint_results (depends on races, drivers, constructors, and status)

COPY status (statusId, status)
FROM 'D:/SQL Projects Includes Learning/SQL_Project_F1/status.csv'
DELIMITER ','
CSV HEADER;--5 status (no dependencies)
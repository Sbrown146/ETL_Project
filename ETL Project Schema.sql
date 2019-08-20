CREATE SCHEMA etl;

SET search_path TO "etl";


--Atlanta Crime Table

DROP TABLE IF EXISTS "Atlanta_Crimes";
CREATE TABLE "Atlanta_Crimes" (
Prinx FLOAT,
ID FLOAT,
Report_date DATE,
Occur_date DATE,
Occur_time Time,
Process_date Date,
Process_time Time,
Beat FLOAT,
Prefix VARCHAR,
Prefix_Num VARCHAR,
Location VARCHAR,
Min FLOAT,
Min_Code VARCHAR,
Dis_Code VARCHAR,
Number_of_Victims INT,
Shift VARCHAR,
Day VARCHAR,
Loc_type INT,
Description VARCHAR,
Neighborhood VARCHAR,
NPU VARCHAR,
Longitude FLOAT,
Latitude FLOAT
);


--Baltimore Crimes Table

DROP TABLE IF EXISTS "Baltimore_Crimes";
CREATE TABLE "Baltimore_Crimes" (
Occur_date DATE,
Time TIME,
Crime_code VARCHAR,
Location VARCHAR,
Description VARCHAR,
Area VARCHAR,
Weapon VARCHAR,
Post FLOAT,
District VARCHAR,
Neighborhood VARCHAR,
Longitude FLOAT,
Latitude FLOAT,
Coordinates VARCHAR,
Premise VARCHAR,
Number_of_Incidents INT
);


--Boston Crimes Table NOT WORKING
--WHAT IS THIS:  invalid byte sequence for encoding "UTF8": 0xa0

DROP TABLE IF EXISTS "Boston_Crimes";
CREATE TABLE "Boston_Crimes" (
Incident_number VARCHAR,
Code FLOAT,
Code_group VARCHAR,
Description VARCHAR,
District VARCHAR,
Area VARCHAR,
Occur_date DATE,
Year INT,
Month INT,
Day VARCHAR,
Hour INT,
Part VARCHAR,
Street VARCHAR,
Latitude FLOAT,
Longitude FLOAT,
Coordinates VARCHAR
);


--Chicago Crimes Table

DROP TABLE IF EXISTS "Chicago_Crimes";
CREATE TABLE "Chicago_Crimes" (
Number FLOAT,
ID FLOAT,
Case_number VARCHAR,
Occur_date Date,
Block VARCHAR,
IUCR VARCHAR,
Type VARCHAR,
Description VARCHAR,
Location_type VARCHAR,
Arrest VARCHAR,
Domestic VARCHAR,
Beat FLOAT,
District INT,
Ward INT,
Area INT,
FBI_code VARCHAR,
X_coord FLOAT,
Y_coord FLOAT,
Year FLOAT,
Updated DATE,
Latitude FLOAT,
Longitude FLOAT,
Location VARCHAR
);


--Orlando Crime Table

DROP TABLE IF EXISTS "Orlando_Crimes";
CREATE TABLE "Orlando_Crimes" (
Case_Number VARCHAR,
Occur_date TIMESTAMP,
Location VARCHAR,
Offense_location VARCHAR,
Offense_category VARCHAR,
Description VARCHAR,
Charge_type VARCHAR,
Case_status VARCHAR,
Status VARCHAR
);


--This is added since no coordinates are given.

ALTER TABLE "Orlando_Crimes"
ADD COLUMN City VARCHAR;
UPDATE "Orlando_Crimes" SET City='Orlando';

CREATE TABLE "Orlando_Crimes" AS
SELECT *, extract(hour FROM occur_date) FROM "Orlando_Crime";


--Portland Crimes Table

DROP TABLE IF EXISTS "Portland_Crimes";
CREATE TABLE "Portland_Crimes" (
Address VARCHAR,
Case_Number VARCHAR,
Crime_Against VARCHAR,
Neighborhood VARCHAR,
Records INT,
Occur_date DATE,
Month_Year DATE,
Occur_time FlOAT,
Category VARCHAR,
Count INT,
Description VARCHAR,
Latitude FLOAT,
Longitude FLOAT,
X_coord FLOAT,
Y_coord FLOAT,
Report_date DATE,
Report VARCHAR
);


--Seattle Crime Table

DROP TABLE IF EXISTS "Seattle_Crime";
CREATE TABLE "Seattle_Crime" (
Report_number VARCHAR,
Occur_date DATE,
Occur_time FLOAT,
Report_date DATE,
Report_time FLOAT,
Subcategory VARCHAR,
Description VARCHAR,
Precinct VARCHAR,
Sector VARCHAR,
Beat VARCHAR,
Neighborhood VARCHAR
);


--City is added due to there being no coordinate data

ALTER TABLE "Seattle_Crimes"
ADD COLUMN City VARCHAR;
UPDATE "Seattle_Crimes" SET City='Seattle';


--Prototype code for joining the 6 data sets
--SET PRIMARY KEYS


CREATE TABLE "Seattle_Crimes" AS
SELECT *,
CASE
WHEN occur_time BETWEEN 0 AND 600 THEN 'Night'
WHEN occur_time BETWEEN 601 and 1200 THEN 'Morning'
WHEN occur_time BETWEEN 1201 and 2200 THEN 'Daytime'
ELSE 'Night'
END AS Time_of_day
FROM "Seattle_Crime";
DROP TABLE "Seattle_Crime";



DROP TABLE IF EXISTS "Orlando_Seattle_Crimes";
CREATE TABLE "Orlando_Seattle_Crimes" AS
SELECT o.Occur_date AS "Crime Date",
s.Description AS "Seattle Crime",
o.Description AS "Orlando Crime"
FROM "Orlando_Crimes" AS o
RIGHT OUTER JOIN "Seattle_Crimes" AS s
ON (o.Occur_date=s.Occur_date)
WHERE o.Occur_date >= ('2017-01-01')
AND o.Occur_date < ('2017-01-08');
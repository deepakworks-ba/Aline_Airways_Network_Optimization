/*
==========================================================
Aline Airways Network Optimization
==========================================================

Investigation 2 : Customer Demand Analysis (CDA)

Objective:
Analyze passenger demand and seat occupancy across airline
routes to identify high-demand, low-demand, and underutilized
routes for strategic network planning.

Business Questions:

1. Which routes generate the highest passenger traffic?

2. Which routes generate the lowest passenger traffic?

3. Which routes have the highest average load factor?

4. Which routes have the lowest average load factor?

5. Which routes consistently operate below 60% seat occupancy?

6. Which routes consistently operate above 60% seat occupancy?

==========================================================
*/


/*=========================================================
Q1. Which routes generate the highest passenger traffic?
=========================================================*/

SELECT
    CONCAT(R.Origin_City, ' - ', R.Destination_City) AS Route,
    CONCAT(ROUND(SUM(Passenger_Count)/1000,1),'K') AS Passenger_Count
FROM aline_airways.flights AS F
JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID
GROUP BY Route
ORDER BY CONCAT(ROUND(SUM(Passenger_Count)/1000,1),'K') DESC
LIMIT 10;


/*=========================================================
Q2. Which routes generate the lowest passenger traffic?
=========================================================*/

SELECT
    CONCAT(R.Origin_City, ' - ', R.Destination_City) AS Route,
    CONCAT(ROUND(SUM(Passenger_Count)/1000,1),'K') AS Passenger_Count
FROM aline_airways.flights AS F
JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID
GROUP BY Route
ORDER BY CONCAT(ROUND(SUM(Passenger_Count)/1000,1),'K') ASC
LIMIT 10;


/*=========================================================
Q3. Which routes have the highest average load factor?
=========================================================*/

SELECT
    CONCAT(R.Origin_City, ' - ', R.Destination_City) AS Route,
    CONCAT(CEIL(AVG(F.Load_Factor)),'%') AS Load_Factor
FROM aline_airways.flights AS F
JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID
GROUP BY
    R.Origin_City,
    R.Destination_City
ORDER BY Load_Factor DESC
LIMIT 10;


/*=========================================================
Q4. Which routes have the lowest average load factor?
=========================================================*/

SELECT
    CONCAT(R.Origin_City, ' - ', R.Destination_City) AS Route,
    CONCAT(CEIL(AVG(F.Load_Factor)),'%') AS Load_Factor
FROM aline_airways.flights AS F
JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID
GROUP BY
    R.Origin_City,
    R.Destination_City
ORDER BY Load_Factor ASC
LIMIT 10;


/*=========================================================
Q5. Which routes consistently operate below 60% seat occupancy?
=========================================================*/

SELECT
    CONCAT(R.Origin_City, ' - ', R.Destination_City) AS Route,
    CONCAT(CEIL(AVG(F.Load_Factor)),'%') AS Load_Factor
FROM aline_airways.flights AS F
JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID
GROUP BY
    R.Origin_City,
    R.Destination_City
HAVING Load_Factor < '60';


/*=========================================================
Q6. Which routes consistently operate above 60% seat occupancy?
=========================================================*/

SELECT
    CONCAT(R.Origin_City, ' - ', R.Destination_City) AS Route,
    CONCAT(CEIL(AVG(F.Load_Factor)),'%') AS Load_Factor
FROM aline_airways.flights AS F
JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID
GROUP BY
    R.Origin_City,
    R.Destination_City
HAVING Load_Factor > '60';

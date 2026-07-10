/*
==========================================================
Aline Airways Network Optimization
==========================================================

Investigation 3 : Aircraft Utilization Analysis (AUA)

Objective:
Analyze aircraft ownership, utilization, operating costs,
maintenance, revenue generation, and passenger occupancy
to evaluate fleet performance and support strategic
decision-making.

Business Questions:

1. What are the total ownership and leasing costs for each aircraft type (A100, A200, and A300)?

2. How many aircraft of each type require maintenance, and how many are owned versus leased?

3. Which aircraft types operate with the lowest passenger occupancy, and on which routes do they operate?

4. Which aircraft type generates the highest and lowest revenue?

5. Which aircraft type incurs the highest fuel costs?

6. Which aircraft type incurs the highest maintenance costs?

7. Which aircraft type incurs the highest operating costs?

8. Which aircraft type is utilized the most, and which is utilized the least?

9. Which aircraft type has the highest and lowest average load factor?

==========================================================
*/


/*=========================================================
Q1. What are the total ownership and leasing costs for
each aircraft type (A100, A200, and A300)?
=========================================================*/

SELECT
    Aircraft_Type,

    -- Total Cost of Ownership (TCW)
    CONCAT('₹',ROUND(SUM(Purchase_Cost_INR)/10000000,2),' Cr') AS TCW,

    -- Total Monthly Lease Cost (TMLC)
    CONCAT('₹',ROUND(SUM(Monthly_Lease_Cost_INR)/10000000,2),' Cr') AS TMLC

FROM aline_airways.aircraft

GROUP BY Aircraft_Type;


/*=========================================================
Q2. How many aircraft of each type require maintenance,
and how many are owned versus leased?
=========================================================*/

SELECT

    A.Aircraft_Type,

    COUNT(CASE
            WHEN A.Ownership_Type='Owned'
            THEN 1
         END) AS Owned_Aircraft,

    COUNT(CASE
            WHEN A.Ownership_Type='Leased'
            THEN 1
         END) AS Leased_Aircraft,

    -- Aircraft Required Maintenance
    COUNT(CASE
            WHEN A.Status='Maintenance'
            THEN 1
         END) AS ARM

FROM aline_airways.aircraft AS A

GROUP BY Aircraft_Type;


/*=========================================================
Q3. Which aircraft types operate with the lowest passenger
occupancy, and on which routes do they operate?
=========================================================*/

SELECT

    A.Aircraft_Type,

    CONCAT(CEIL(MIN(F.Load_Factor)),'%') AS Load_Factor,

    CONCAT(R.Origin_City,' - ',R.Destination_City) AS Route

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

JOIN aline_airways.routes AS R
ON F.Route_ID=R.Route_ID

GROUP BY
A.Aircraft_Type,
Route;


/*=========================================================
Q4. Which aircraft type generates the highest revenue?
=========================================================*/

SELECT

    A.Aircraft_Type,

    CONCAT('₹',ROUND(MAX(F.Revenue)/100000,2),'L') AS Revenue

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

GROUP BY A.Aircraft_Type;


/*=========================================================
Q5. Which aircraft type generates the lowest revenue?
=========================================================*/

SELECT

    A.Aircraft_Type,

    CONCAT('₹',ROUND(MIN(F.Revenue)/100000,2),'L') AS Revenue

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

GROUP BY A.Aircraft_Type;


/*=========================================================
Q6. Which aircraft type incurs the highest fuel costs?
=========================================================*/

SELECT

    A.Aircraft_Type,

    CONCAT('₹',ROUND(SUM(F.Fuel_Cost)/10000000,2),'Cr') AS Fuel_Cost

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

GROUP BY A.Aircraft_Type;


/*=========================================================
Q7. Which aircraft type incurs the highest maintenance
costs?
=========================================================*/

SELECT

    A.Aircraft_Type,

    CONCAT('₹',ROUND(SUM(F.Maintenance_Cost)/10000000,2),'Cr') AS Maintenance_Cost

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

GROUP BY A.Aircraft_Type;


/*=========================================================
Q8. Which aircraft type incurs the highest operating costs?
=========================================================*/

SELECT

    A.Aircraft_Type,

    CONCAT('₹',ROUND(SUM(F.Total_Cost)/10000000,2),'Cr') AS Total_Cost

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

GROUP BY A.Aircraft_Type;


/*=========================================================
Q9. Which aircraft type is utilized the most, and which
is utilized the least?
=========================================================*/

SELECT

    A.Aircraft_Type,

    COUNT(F.Aircraft_ID) AS NTU,

    CONCAT('₹',ROUND(SUM(F.Revenue-F.Total_Cost)/10000000,2),' Cr') AS Profits

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

GROUP BY A.Aircraft_Type;


/*=========================================================
Q10. Which aircraft type has the highest and lowest
average load factor?
=========================================================*/

SELECT

    A.Aircraft_Type,

    CONCAT(MAX(CEIL(Load_Factor)),'%') AS Load_Factor

FROM aline_airways.flights AS F

JOIN aline_airways.aircraft AS A
ON F.Aircraft_ID=A.Aircraft_ID

GROUP BY A.Aircraft_Type;

/*
==========================================================
Aline Airways Network Optimization
==========================================================

Investigation 1 : Route Profitability Analysis (RPA)

Objective:
Analyze the financial performance of airline routes to
identify high-performing, low-performing, and strategic
routes for future business decisions.

==========================================================
Business Questions
==========================================================

1. Which routes generate the highest revenue?

2. Which routes generate the lowest revenue?

3. Which routes are the most profitable?

4. Which routes are the least profitable?

5. Which routes should be reviewed for expansion,
   reduction, or discontinuation based on
   profitability and demand?



==========================================================

Q1. Which routes generate the highest revenue?
SELECT
    CONCAT(R.Origin_Airport_ID,' - ',R.Destination_Airport_ID) AS Route,
    R.Route_Type,
    R.Route_Status,

    ROUND(SUM(F.Revenue)/10000000,2) AS `Revenue (₹ Cr)`

FROM aline_airways.routes AS R
JOIN aline_airways.flights AS F
ON R.Route_ID = F.Route_ID

GROUP BY
    R.Route_ID,
    Route,
    R.Route_Type,
    R.Route_Status

ORDER BY SUM(F.Revenue) DESC

LIMIT 10;






Q2. Which routes generate the lowest revenue?
SELECT
    CONCAT(R.Origin_Airport_ID,' - ',R.Destination_Airport_ID) AS Route,
    R.Route_Type,
    R.Route_Status,

    ROUND(SUM(F.Revenue)/10000000,2) AS `Revenue (₹ Cr)`

FROM aline_airways.routes AS R
JOIN aline_airways.flights AS F
ON R.Route_ID = F.Route_ID

GROUP BY
    R.Route_ID,
    Route,
    R.Route_Type,
    R.Route_Status

ORDER BY SUM(F.Revenue) ASC

LIMIT 10;





Q3. Which routes are the most profitable?
SELECT

    CONCAT(R.Origin_Airport_ID,' - ',R.Destination_Airport_ID) AS Route,

    ROUND(SUM(F.Revenue - F.Total_Cost)/10000000,2)
    AS `Net Profit (₹ Cr)`

FROM aline_airways.flights AS F

JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID

GROUP BY
    R.Route_ID,
    Route

ORDER BY SUM(F.Revenue - F.Total_Cost) DESC

LIMIT 10;






Q4. Which routes are the least profitable?
SELECT

    CONCAT(R.Origin_Airport_ID,' - ',R.Destination_Airport_ID) AS Route,

    ROUND(SUM(F.Revenue - F.Total_Cost)/10000000,2)
    AS `Net Profit (₹ Cr)`

FROM aline_airways.flights AS F

JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID

GROUP BY
    R.Route_ID,
    Route

ORDER BY SUM(F.Revenue - F.Total_Cost) ASC

LIMIT 10;







Q5. Which routes should be reviewed for expansion, reduction, or discontinuation based on profitability and demand?
SELECT

    CONCAT(R.Origin_Airport_ID,' - ',R.Destination_Airport_ID) AS Route,

    ROUND(SUM(F.Revenue - F.Total_Cost)/10000000,2)
    AS `Net Profit (₹ Cr)`,

    CASE
        WHEN SUM(F.Revenue - F.Total_Cost)/10000000 >= 50 THEN 'High'
        WHEN SUM(F.Revenue - F.Total_Cost)/10000000 >= 20 THEN 'Medium'
        ELSE 'Low'
    END AS Profitability,

    ROUND(AVG(F.Load_Factor),1) AS `Average Load Factor (%)`,

    CASE
        WHEN AVG(F.Load_Factor) >= 80 THEN 'High'
        WHEN AVG(F.Load_Factor) >= 50 THEN 'Medium'
        ELSE 'Low'
    END AS Demand,

    CASE

        WHEN SUM(F.Revenue - F.Total_Cost)/10000000 >= 50
             AND AVG(F.Load_Factor) >= 80
        THEN 'Expand'

        WHEN SUM(F.Revenue - F.Total_Cost)/10000000 < 20
             AND AVG(F.Load_Factor) < 50
        THEN 'Consider Discontinuation'

        ELSE 'Review'

    END AS Recommendation

FROM aline_airways.flights AS F

JOIN aline_airways.routes AS R
ON F.Route_ID = R.Route_ID

GROUP BY
    R.Route_ID,
    Route

ORDER BY SUM(F.Revenue - F.Total_Cost) DESC;
*/

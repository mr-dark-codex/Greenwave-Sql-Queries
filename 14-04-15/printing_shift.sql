-- 2020-12-29 15:54:54.000

-- SELECT
--     IIF(
--         DATEPART(HOUR, DateAndTime) >= 6 AND DATEPART(HOUR, DateAndTime) < 14, 'A',
--         IIF(
--             DATEPART(HOUR, DateAndTime) >= 14 AND DATEPART(HOUR, DateAndTime) < 22, 'B',
--             'C'
--         )
--     ) AS Shift
-- FROM DBO.FloatTable_test
-- WHERE MONTH(DateAndTime) = 12
--     AND YEAR(DateAndTime) = 2020;


-- SELECT
--     CAST(
--         IIF(
--             DATEPART(HOUR, DateAndTime) >= 0 AND DATEPART(HOUR, DateAndTime) < 6,
--             DATEADD(DAY, -1, CAST(DateAndTime AS DATE)),
--             CAST(DateAndTime AS DATE)
--         ) AS DATE
--     ) AS ShiftDate
-- FROM DBO.FloatTable_test 
-- WHERE MONTH(DateAndTime) = 12 
--   AND YEAR(DateAndTime) = 2020;


-- SELECT 
-- CASE 
-- WHEN DATEPART(HOUR, DateAndTime) >= 6 and DATEPART(HOUR, DateAndTime) < 14 THEN 'A'
-- WHEN DATEPART(HOUR, DateAndTime) >= 14 and DATEPART(HOUR, DateAndTime) < 22 THEN 'B'
-- ELSE 'C'
-- END 
-- AS [Shift]

-- FROM dbo.FloatTable_test 
-- WHERE MONTH(DateAndTime) = 12 and YEAR(DateAndTime) = 2020


SELECT 
CASE 
WHEN DATEPART(HOUR, DateAndTime) >= 0 AND DATEPART(HOUR, DateAndTime) < 6 
THEN DATEADD(DAY, -1, CAST(DateAndTime AS DATE))
ELSE CAST(DateAndTime AS DATE)
END AS [Shift]

FROM dbo.FloatTable_test 
WHERE MONTH(DateAndTime) = 12 and YEAR(DateAndTime) = 2020




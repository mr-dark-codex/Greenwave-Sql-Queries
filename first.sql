SELECT *
FROM
    (
        SELECT
        -- F.DateAndTime,
        dbo.getEquipmentName(T.TagName) [TagName],
        dbo.GetSecondSegment(T.TagName) [Office],
        MONTH(F.DateAndTime) [MONTH],
        YEAR(F.DateAndTime) [YEAR],
        F.VAL [Value]
    FROM dbo.FloatTable_test F
        JOIN dbo.TagTable T
        ON T.TagIndex = F.TagIndex
    WHERE 
        MONTH(F.DateAndTime) = 12
        AND YEAR(F.DateAndTime) = 2020
        AND F.Val > 0
        AND dbo.getEquipmentName(T.TagName) IN ('Energy_App', 'PF', 'Energy')    
    ) AS S
PIVOT
(
    AVG(S.Value)
    FOR TAGNAME IN ([PF], [ENERGY_APP], [ENERGY])
) AS PIVOTTABLE

/*
SELECT *
FROM (
    SELECT
        COALESCE(t2.Month, 'December') AS [Month],
        COALESCE(t2.Year, 2020) AS [Year],
        COALESCE(t2.Equipment, 
            SUBSTRING(
                t1.TagName, 
                CHARINDEX('\', t1.TagName) + 1, 
                CHARINDEX('\', t1.TagName, CHARINDEX('\', t1.TagName) + 1) - CHARINDEX('\', t1.TagName) - 1
            )
        ) AS [Equipment],
        COALESCE(t2.Tag, 
            REVERSE(SUBSTRING(REVERSE(t1.TagName), 0, CHARINDEX('\', REVERSE(t1.TagName))))
        ) AS [TAG],
        T1.TagName [TAGNAME],
        t1.TagIndex,
        --t1.TagName,
        COALESCE(t2.Val, 0.0) AS [V_Val]
    FROM (
        SELECT TagIndex, TagName
        FROM [dbo].[TagTable]
        WHERE TagName LIKE '%Energy_App' OR TagName LIKE '%PF' or TagName LIKE '%Energy'
    ) AS t1
        LEFT JOIN (
        SELECT
            t.TagIndex,
            t.TagName,
            DATENAME(month, f.DateAndTime) AS [Month],
            YEAR(f.DateAndTime) AS [Year],
            SUBSTRING(
                t.TagName, 
                CHARINDEX('\', t.TagName) + 1, 
                CHARINDEX('\', t.TagName, CHARINDEX('\', t.TagName) + 1) - CHARINDEX('\', t.TagName) - 1
            ) AS [Equipment],
            REVERSE(SUBSTRING(REVERSE(t.TagName), 0, CHARINDEX('\', REVERSE(t.TagName)))) AS [Tag],
            coalesce(f.Val,0.0) AS [Val]
        FROM [dbo].[TagTable] AS t
            JOIN [dbo].[FloatTable_test] AS f ON t.TagIndex = f.TagIndex
        WHERE 
            f.DateAndTime >= '2020-12-01'
            AND f.DateAndTime <= '2020-12-31'
            AND (t.TagName LIKE '%Energy_App' OR t.TagName LIKE '%PF' or t.TagName LIKE '%Energy')
        GROUP BY 
            t.TagIndex, 
            t.TagName, 
            YEAR(f.DateAndTime), 
            DATENAME(month, f.DateAndTime),
			f.Val
    ) AS t2 ON t1.TagIndex = t2.TagIndex
) AS result_1
pivot(
MAX(V_VAL) for [Tag] in ([Energy_App],[PF],[Energy])
) as p */

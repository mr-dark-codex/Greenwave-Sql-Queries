SELECT *
FROM (
    SELECT
        dbo.getEquipmentName(T.TagName) AS [TagName],
        dbo.GetSecondSegment(T.TagName) AS [Office],
        MONTH(F.DateAndTime) AS [Month],
        YEAR(F.DateAndTime) AS [Year],
        AVG(COALESCE(F.Val, 0.0)) AS [AVG_VAL]
        F.VAL AS [Value]
    FROM dbo.FloatTable_test F
        JOIN dbo.TagTable T ON T.TagIndex = F.TagIndex
    WHERE 
        MONTH(F.DateAndTime) = 12
        AND YEAR(F.DateAndTime) = 2020
        AND F.Val > 0
        AND dbo.getEquipmentName(T.TagName) IN ('Energy_App', 'PF', 'Energy')
    GROUP BY 
        dbo.getEquipmentName(T.TagName), 
        dbo.GetSecondSegment(T.TagName),
        MONTH(F.DateAndTime), 
        YEAR(F.DateAndTime)
) AS S
PIVOT (
    MAX(AVG_VAL)
    -- AVG(S.Value)
    FOR TagName IN ([PF], [Energy_App], [Energy])
) AS PivotTable

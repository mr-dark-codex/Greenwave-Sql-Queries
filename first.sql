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
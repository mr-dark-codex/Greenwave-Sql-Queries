SELECT *
FROM 
( SELECT -- T.TagName, 
    F.VAL,
    -- F.DateAndTime, 
    DBO.getEquipmentName(T.TagName) AS [TAG],
    SUBSTRING(T.TagName, 0, LEN(T.TagName) - CHARINDEX('\', REVERSE(T.TagName)) + 1) [Eqiupment]
    FROM dbo.FloatTable_test F, DBO.TagTable T
    WHERE T.TagIndex = F.TagIndex
    AND dbo.getEquipmentName(T.TagName) IN ('Energy_App', 'PF', 'Energy')
    AND MONTH(F.DateAndTime) = 12 
    AND YEAR(F.DateAndTime) = 2020
    AND F.Val > 0
) AS S
PIVOT 
(
    LEAD(VAL)
    FOR S.TAG IN ([PF], [ENERGY_APP], [ENERGY])
) AS PIVOTTABLE
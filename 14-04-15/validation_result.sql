-- SELECT * 
-- FROM 
-- (
--     SELECT 
--     --T.TagName,
--     T.TagIndex, 
--     F.Val, 
--     dbo.getSecondLastSegment(T.TagName) [Section], 
--     dbo.getEquipmentName(T.TagName) [Tag]
--     FROM dbo.FloatTable_test F, dbo.TagTable T
--     WHERE T.TagIndex = F.TagIndex
--     AND MONTH(F.DateAndTime) = 12 
--     AND YEAR(F.DateAndTime) = 2020
--     AND F.Val > 0
-- ) AS S
-- WHERE S.Tag LIKE 'ENERGY_APP' AND S.Section LIKE 'Bagging'


SELECT 
    --T.TagName,
    T.TagIndex, 
    F.Val, 
    dbo.getSecondLastSegment(T.TagName) [Section], 
    dbo.getEquipmentName(T.TagName) [Tag]
    FROM dbo.FloatTable_test F, dbo.TagTable T
    WHERE T.TagIndex = F.TagIndex
    AND MONTH(F.DateAndTime) = 12 
    AND YEAR(F.DateAndTime) = 2020
    AND F.Val > 0
-- SELECT 
--     cc.dateandtime,
--     p.Shift,
--     p.CWNO,   
--     COUNT(cc.WEIGHT) AS TOTAL_ACCEPTED,
--     MAX(CC.WEIGHT) AS UPPER_COUNT,
--     MIN(CC.WEIGHT) AS LOWER_COUNT
-- FROM dbo.CW_DATA cc
-- CROSS APPLY dbo.UDTVT_SAMPLE_CW_PARAMETER(cc.dateandtime, cc.CW_NO) p
-- WHERE 
--     cc.dateandtime BETWEEN '2022-06-10 00:00:00' AND '2022-06-11 00:00:00'
--     AND cc.WEIGHT BETWEEN p.SKU_PKT_LOW_VALUE AND p.SKU_PKT_HIGH_VALUE
-- GROUP BY 
--     cc.dateandtime, 
--     p.Shift, p.CWNO;


-- SELECT 
--     cc.dateandtime,
--     ROW_NUMBER() OVER (PARTITION BY p.Shift ORDER BY cc.dateandtime) AS RowNum,
--     P.Shift,
--     p.CWNO,   
--     COUNT(cc.WEIGHT) AS TOTAL_ACCEPTED,
--     MAX(cc.WEIGHT) AS UPPER_COUNT,
--     MIN(cc.WEIGHT) AS LOWER_COUNT
-- FROM dbo.CW_DATA cc
-- CROSS APPLY dbo.UDTVT_SAMPLE_CW_PARAMETER(cc.dateandtime, cc.CW_NO) p
-- WHERE 
--     cc.dateandtime BETWEEN '2022-06-10 00:00:00' AND '2022-06-11 00:00:00'
--     AND cc.WEIGHT BETWEEN p.SKU_PKT_LOW_VALUE AND p.SKU_PKT_HIGH_VALUE
-- GROUP BY 
--     cc.dateandtime, 
--     p.Shift, p.CWNO;

SELECT 
    p.Shift,
    p.CWNO,
    COUNT(*) AS TOTAL_SAMPLES,
    
    COUNT(CASE 
        WHEN cc.WEIGHT BETWEEN p.SKU_PKT_LOW_VALUE AND p.SKU_PKT_HIGH_VALUE 
        THEN 1 
    END) AS TOTAL_ACCEPTED,
    
    COUNT(CASE 
        WHEN cc.WEIGHT > p.SKU_PKT_HIGH_VALUE 
        THEN 1 
    END) AS UPPER_COUNT,
    
    COUNT(CASE 
        WHEN cc.WEIGHT < p.SKU_PKT_LOW_VALUE 
        THEN 1 
    END) AS LOWER_COUNT

FROM dbo.CW_DATA cc
CROSS APPLY dbo.UDTVT_SAMPLE_CW_PARAMETER(cc.dateandtime, cc.CW_NO) p
-- WHERE 
    -- cc.dateandtime BETWEEN '2022-06-10 00:00:00' AND '2022-06-11 00:00:00'
GROUP BY 
    p.Shift, 
    p.CWNO;


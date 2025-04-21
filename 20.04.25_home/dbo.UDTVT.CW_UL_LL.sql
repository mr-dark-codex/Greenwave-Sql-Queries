SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[UDTVT_SAMPLE_CW_PARAMETER] (@givenDateAndTime DATETIME, @CW INT)
RETURNS TABLE
AS 
RETURN 
SELECT *
FROM
	(
	    			SELECT
			DateAndTime,
			ParameterName,
			Val,
			CWNO,
			CASE 
            WHEN DATEPART(HOUR, DateAndTime) >= 6 AND DATEPART(HOUR, DateAndTime) < 14 THEN 'A'
            WHEN  DATEPART(HOUR, DateAndTime) >= 14 AND DATEPART(HOUR, DateAndTime) < 21 THEN 'B'
            ELSE 'C'
        END AS Shift
		FROM
			(
		SELECT TOP(1)
				F.VAL,
				SUBSTRING(T.TAGNAME, 0, CHARINDEX('\', T.tagName)) AS CWNO,
				SUBSTRING(T.TagName, CHARINDEX('\', T.TagName) + 1, LEN(T.tagName)) AS ParameterName,
				F.DateAndTime
			FROM dbo.FloatTable_15min F
				JOIN dbo.TagTable_15min T ON T.TagIndex = F.TagIndex
			WHERE F.DateAndTime BETWEEN DATEADD(MINUTE, -1440, @givenDateAndTime) AND @givenDateAndTime
				AND T.TagName LIKE CONCAT('%', @CW, '%HIGH_VALUE')
			ORDER BY F.DateAndTime DESC
	) AS HIGH_VALUE

	UNION ALL

		SELECT
			DateAndTime,
			ParameterName,
			Val,
			CWNO,
			CASE 
            WHEN DATEPART(HOUR, DateAndTime) >= 6 AND DATEPART(HOUR, DateAndTime) < 14 THEN 'A'
            WHEN  DATEPART(HOUR, DateAndTime) >= 14 AND DATEPART(HOUR, DateAndTime) < 21 THEN 'B'
            ELSE 'C'
        END AS Shift
		FROM
			(
		SELECT TOP(1)
				F.VAL,
				SUBSTRING(T.TAGNAME, 0, CHARINDEX('\', T.tagName)) AS CWNO,
				SUBSTRING(T.TagName, CHARINDEX('\', T.TagName) + 1, LEN(T.tagName)) AS ParameterName,
				F.DateAndTime
			FROM dbo.FloatTable_15min F
				JOIN dbo.TagTable_15min T ON T.TagIndex = F.TagIndex
			WHERE F.DateAndTime BETWEEN DATEADD(MINUTE, -1440, @givenDateAndTime) AND @givenDateAndTime
				AND T.TagName LIKE CONCAT('%', @CW, '%LOW_VALUE')
			ORDER BY F.DateAndTime DESC
	) AS LOW_VALUE

	UNION ALL

		SELECT
			DateAndTime,
			ParameterName,
			Val,
			CWNO,
			CASE 
            WHEN DATEPART(HOUR, DateAndTime) >= 6 AND DATEPART(HOUR, DateAndTime) < 14 THEN 'A'
            WHEN  DATEPART(HOUR, DateAndTime) >= 14 AND DATEPART(HOUR, DateAndTime) < 21 THEN 'B'
            ELSE 'C'
        END AS Shift
		FROM
			(
		SELECT TOP(1)
				F.VAL,
				SUBSTRING(T.TAGNAME, 0, CHARINDEX('\', T.tagName)) AS CWNO,
				SUBSTRING(T.TagName, CHARINDEX('\', T.TagName) + 1, LEN(T.tagName)) AS ParameterName,
				F.DateAndTime
			FROM dbo.FloatTable_15min F
				JOIN dbo.TagTable_15min T ON T.TagIndex = F.TagIndex
			WHERE F.DateAndTime BETWEEN DATEADD(MINUTE, -1440, @givenDateAndTime) AND @givenDateAndTime
				AND T.TagName LIKE CONCAT('%', @CW, '%TARGET_VALUE')
			ORDER BY F.DateAndTime DESC
	) AS TARGET_VALUE
) AS ALL_TABLE
-- )
PIVOT (
    MAX(VAL)
    FOR ParameterName IN (SKU_PKT_HIGH_VALUE, SKU_PKT_LOW_VALUE, SKU_PKT_target_VALUE)
) AS PT

GO

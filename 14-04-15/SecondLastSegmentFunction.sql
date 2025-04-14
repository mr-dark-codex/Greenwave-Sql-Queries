SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getSecondLastSegment] (@input NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    -- DECLARE @value as NVARCHAR(MAX) = REVERSE(@input)
    -- RETURN RIGHT(@input, CHARINDEX('\', @value, CHARINDEX('\', @value)) - 1)

    DECLARE @value as NVARCHAR(MAX) = REVERSE(@input)
    DECLARE @temp as NVARCHAR(MAX)= RIGHT(@input, CHARINDEX('\', @value, CHARINDEX('\', @value) + 1) - 1)
    RETURN SUBSTRING(@temp, 0, CHARINDEX('\', @temp));
END
GO

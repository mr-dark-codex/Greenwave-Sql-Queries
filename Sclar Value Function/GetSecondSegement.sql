SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetSecondSegment] (@TagName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @FirstSlash INT = CHARINDEX('\', @TagName);
    DECLARE @SecondSlash INT = CHARINDEX('\', @TagName, @FirstSlash + 1);
    DECLARE @Result NVARCHAR(MAX);

    IF @FirstSlash > 0 AND @SecondSlash > 0
    BEGIN
        SET @Result = SUBSTRING(@TagName, @FirstSlash + 1, @SecondSlash - @FirstSlash - 1);
    END
    ELSE
    BEGIN
        SET @Result = NULL;
    END

    RETURN @Result;
END;

GO

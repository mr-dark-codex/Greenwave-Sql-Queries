SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetSecondLastSegment] (
    @path NVARCHAR(MAX)
)
RETURNS NVARCHAR(255)
AS
BEGIN
    -- Find the position of the last backslash
    -- DECLARE @lastSlashPos INT;
    -- SELECT @lastSlashPos = LEN(@path) - CHARINDEX('\', REVERSE(@path)) + 1;
    DECLARE @seconlastSegmeenttolast NVARCHAR(MAX);
    SELECT @seconlastSegmeenttolast = SUBSTRING(@path, LEN(@path) - CHARINDEX('\', REVERSE(@path), CHARINDEX('\', REVERSE(@path)) + 1) + 2, LEN(@path));

    -- Find the position of the second-to-last backslash
    -- DECLARE @secondLastSlashPos INT;
    -- SELECT @secondLastSlashPos = LEN(@path) - CHARINDEX('\', REVERSE(@path), CHARINDEX('\', REVERSE(@path)) + 1) + 1;

    -- -- Handle cases with fewer than two backslashes
    -- IF @secondLastSlashPos IS NULL OR @secondLastSlashPos >= @lastSlashPos
    -- BEGIN
    --     RETURN NULL; -- Or handle this case differently if needed
    -- END;

    -- -- Extract the second-to-last segment
    -- RETURN SUBSTRING(@path, @secondLastSlashPos, @lastSlashPos - @secondLastSlashPos - 1);

    RETURN SUBSTRING(@seconlastSegmeenttolast, 0, CHARINDEX('\', @seconlastSegmeenttolast));
END;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetLastSegment] (
    @path NVARCHAR(MAX)
)
RETURNS NVARCHAR(255)
AS
BEGIN
    RETURN RIGHT(@path, CHARINDEX('\', REVERSE(@path)) - 1);
END;
GO

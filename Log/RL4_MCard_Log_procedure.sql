USE Rook
GO

-- =============================================
-- Author:		<Vizsy I.>
-- Create date: <2023.09.18.>
-- Modified date: <>
-- Description:	SP for Visitor LOG API
-- =============================================

CREATE or ALTER PROCEDURE Loger.SP_MCardResult @brCode CHAR(8), @sessCode CHAR(6)
    ,@points SMALLINT, @moves SMALLINT, @duration TIME(3)
    AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @nowDt DATETIME
    DECLARE @brCNorm CHAR(8)
    DECLARE @sessCNorm CHAR(6)
    DECLARE @total BIGINT
    DECLARE @worse BIGINT


    -- Now and Norming
    SET @nowDt = GETDATE()
    SET @brCNorm = LOWER(@brCode)
    SET @sessCNorm = LOWER(@sessCode)

    -- Counts
    SELECT @total = COUNT(*) FROM Loger.MCardResult
    SELECT @worse = COUNT(*) FROM Loger.MCardResult mr
        WHERE mr.Points < @points OR mr.Points = @points AND mr.Duration > @duration

    -- Insert into
    INSERT INTO Loger.MCardResult (BrCode, SessCode, Points, Moves, Duration, Created)
        VALUES (@brCNorm, @sessCNorm, @points, @moves, @duration, @nowDt)

	-- Final result
	SELECT @total [total], @worse [worse]

END -- of PROCEDURE

----- Execute
/*
EXEC Rook.loger.SP_MCardResult @brCode = 'as-s45', @sessCode = 'a-s5'
    ,@points = 5201, @moves = 50, @duration = '23:59:59.9999999'

*/

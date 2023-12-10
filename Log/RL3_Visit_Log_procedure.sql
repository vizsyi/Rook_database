USE Rook
GO

-- =============================================
-- Author:		<Vizsy I.>
-- Create date: <2023.09.15.>
-- Modified date: <>
-- Description:	SP for Visitor LOG API
-- =============================================

CREATE or ALTER PROCEDURE Loger.visitorLOG @brCode CHAR(8), @sessCode CHAR(6), @lang VARCHAR(7)
    ,@brand VARCHAR(24), @vers SMALLINT, @dMem FLOAT, @isNew BIT
    AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @bbId SMALLINT
    DECLARE @versDb SMALLINT
	DECLARE @nowDt DATETIME
	DECLARE @brandNorm CHAR(24)
    DECLARE @brCNorm CHAR(8)
    DECLARE @sessCNorm VARCHAR(6)

    -- Now and Norming
    SET @nowDt = GETDATE()
    SET @brCNorm = LOWER(@brCode)
    SET @sessCNorm = LOWER(@sessCode)

    -- Cheking the exist and the version of the Browser data
    SELECT @versDb = Vers FROM Loger.Browser WHERE BrCode = @brCNorm

    IF @versDb IS NULL OR @versDb != @vers BEGIN
        -- Browser brand Id
        SET @brandNorm = LOWER(@brand)
        SELECT @bbId = BB_Id FROM Loger.Browser_brand WHERE BrandNormal = @brandNorm

        IF @bbId IS NULL BEGIN
            INSERT INTO Loger.Browser_brand (BrandName, BrandNormal)
                VALUES (@brand, @brandNorm)
            SET @bbId = @@IDENTITY
        END

        -- New Br Code
        IF @versDb IS NULL BEGIN
            INSERT INTO Loger.Browser (BrCode, BB_Id, Vers,Lang, DeviceMemory, IsNew, Created)
                VALUES (@brCNorm, @bbId, @vers, @lang, @dMem, @isNew, @nowDt)
        END
        -- Update Br data
        ELSE BEGIN
            UPDATE Loger.Browser SET
                BB_Id = @bbId,
                Vers = @vers,
                Lang = @lang,
                DeviceMemory = @dMem,
                Modified = @nowDt
                WHERE BrCode = @brCNorm
        END
    END -- IF

    -- Insert session data
    INSERT INTO Loger.Sess (BrCode, SessCode, Created)
        VALUES (@brCNorm, @sessCNorm, @nowDt)

	-- Final result
	SELECT @bbId [ID], @nowDt [most], @brand, @brandNorm, 200 Ok

END -- of PROCEDURE

----- Execute
/*
EXEC Rook.loger.visitorLOG @brCode = 'as-s45', @sessCode = 'a-s5', @lang = 'hu-HU'
    ,@brand = 'Macro Hard Electric', @vers = 116, @dMem = 7.5, @isNew = 1

EXEC Rook.loger.visitorLOG @brCode = 'yy-s47', @sessCode = 'y-49', @lang = 'hu-HW'
    ,@brand = 'Macry Hard Electric', @vers = 119, @dMem = 8.2, @isNew = 1

*/

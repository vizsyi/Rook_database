USE Rook
GO

-- =============================================
-- Author:		<Vizsy István>
-- Create date: <2023.11.11.>
-- Modified date: <>
-- Description:	SP for Creating Celebs
-- =============================================

/*
	[Id] [char](6) NOT NULL,
	[CelebName] [nvarchar](max) NOT NULL,
	[Sex] [tinyint] NOT NULL,
	[ProfessionId] [int] NULL,
	[PhotoFile] [char](11) NOT NULL,
	[PairId] [char](6) NULL,
	[Ready] [bit] NOT NULL,
        Created DATETIME NOT NULL,
    Modified DATETIME
*/

CREATE or ALTER PROCEDURE Celeb.SP_CelebCreate @IsNew BIT = 1, @Id CHAR(6), @CelebName NVARCHAR(36)
    ,@Sex TINYINT, @ProfessionId SMALLINT, @PhotoFile CHAR(6) = '', @PairId CHAR(6) = '', @ready BIT = 0
    AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @nowDt DATETIME
    DECLARE @pair2Id CHAR(6)
    DECLARE @result SMALLINT

    -- Now and Norming
    SET @result = 20
    SET @nowDt = GETDATE()
    SET @Id = LOWER(@Id)
    SET @PairId = LOWER(@PairId)

    -- Single pair checking
    IF @PairId != '' BEGIN
        SELECT @pair2Id = c.PairId FROM Celeb.Celeb c
            WHERE c.Id = @PairId

        IF @Pair2Id != '' BEGIN
            SET @PairId = ''
            SET @result = 431
        END
    END

    -- Setting the pair
    BEGIN TRY
    BEGIN TRANSACTION

    IF @IsNew = 1 BEGIN
        INSERT INTO Celeb.Celeb (Id, CelebName, Sex, ProfessionId, PhotoFile, PairId, Ready, Created)
            VALUES (@Id, @CelebName, @Sex, @ProfessionId, @PhotoFile, @PairId, @Ready, @nowDt)
    END
    ELSE BEGIN
        -- The old pair
        SELECT @pair2Id = c.PairId FROM Celeb.Celeb c
            WHERE c.Id = @Id
        IF @pair2Id IS NULL SET @result = 44
        ELSE BEGIN
            -- Clearing the old pair
            IF @pair2Id != '' AND @pair2Id != @PairId
                UPDATE Celeb.Celeb SET
                    PairId = ''
                    WHERE Id = @PairId
            
            IF @PhotoFile = ''
                UPDATE Celeb.Celeb SET
                    Id = @Id, CelebName = @CelebName, Sex = @Sex, ProfessionId = @ProfessionId
                    , PairId = @PairId, Ready = @ready, Modified = @nowDt
                    WHERE Id = @Id
            ELSE
                UPDATE Celeb.Celeb SET
                    Id = @Id, CelebName = @CelebName, Sex = @Sex, ProfessionId = @ProfessionId
                    ,PhotoFile = @PhotoFile, PairId = @PairId, Ready = @ready, Modified = @nowDt
                    WHERE Id = @Id

            IF @@ROWCOUNT != 1
                IF @@ROWCOUNT = 0 SET @result = 54
                ELSE SET @result = 55

        END
    END

	-- Final result
    COMMIT TRANSACTION
    SELECT @result [result]
    END TRY


    BEGIN CATCH
        ROLLBACK TRANSACTION
        SELECT 77 [result]
    END CATCH

END -- of PROCEDURE

----- Execute
/*
EXEC Rook.loger.SP_MCardResult @brCode = 'as-s45', @sessCode = 'a-s5'
    ,@points = 5201, @moves = 50, @duration = '23:59:59.9999999'

*/

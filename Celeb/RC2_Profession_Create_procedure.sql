USE Rook
GO

-- =============================================
-- Author:		<Vizsy I.>
-- Create date: <2023.11.07.>
-- Modified date: <>
-- Description:	SP for Creating the Professions of the Celebs
-- =============================================

CREATE or ALTER PROCEDURE Celeb.SP_ProfessionCreate @Profession NVARCHAR(40), @sport BIT = 0
    AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @prId INT
    DECLARE @prNorm NVARCHAR(40)

    -- Norming
    SET @prNorm = LOWER(@Profession)

    -- Counts
    SELECT @prId = Id FROM Celeb.Profession p
        WHERE LOWER(p.ProfessionName) = @prNorm

    -- Insert into
    IF @prId IS NULL BEGIN
        INSERT INTO Celeb.Profession (ProfessionName, Sport)
        VALUES (@Profession, @sport)

        SELECT 20 Result
    END
    ELSE SELECT 43 Result


END -- of PROCEDURE

----- Execute
/*
EXEC Celeb.SP_ProfessionCreate @Profession = "Footballer", @sport = true

*/

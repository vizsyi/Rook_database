USE Rook
GO

-- =============================================
-- Author:		<Vizsy I.>
-- Create date: <2023.12.08.>
-- Modified date: <>
-- Description:	Listing the single celebs by sex
-- =============================================

CREATE or ALTER PROCEDURE Celeb.SP_Couples AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Final result
	SELECT cel.Id, cel.CelebName, cel.PhotoFile
        ,pair.Id Id2, pair.CelebName CelebName2, pair.PhotoFile PhotoFile2
        FROM Celeb.Celeb cel
        INNER JOIN Celeb.Celeb pair ON cel.PairId = pair.Id
        WHERE cel.Ready=1 AND pair.Ready=1 AND cel.ProfessionId IS NOT NULL
            AND (pair.ProfessionId IS NULL OR cel.Id < cel.PairId)

END -- of PROCEDURE

----- Execute
/*
EXEC Celeb.SP_SingleCelebs @sex = 1

*/


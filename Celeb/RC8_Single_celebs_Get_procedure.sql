USE Rook
GO

-- =============================================
-- Author:		<Vizsy I.>
-- Create date: <2023.12.08.>
-- Modified date: <>
-- Description:	Listing the single celebs by sex
-- =============================================

CREATE or ALTER PROCEDURE Celeb.SP_SingleCelebs @sex TINYINT AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Final result
	SELECT Id, CelebName, Sex FROM Celeb.Celeb
        WHERE Sex = @sex

END -- of PROCEDURE

----- Execute
/*
EXEC Celeb.SP_SingleCelebs @sex = 1

*/


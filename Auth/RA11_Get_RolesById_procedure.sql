USE Rook
GO

-- =============================================
-- Author:		<Vizsy I.>
-- Create date: <2023.12.04.>
-- Modified date: <>
-- Description:	Getting roles by UserId
-- =============================================

CREATE or ALTER PROCEDURE Auth.SP_RolesGetByUserId @userId INT
    AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Final result
    SELECT r.Name
        FROM Auth.AspNetUserRoles ur
        INNER JOIN Auth.AspNetRoles r ON ur.RoleId = r.Id
        WHERE ur.UserId = @userId

END -- of PROCEDURE

----- Execute
/*
EXEC Auth.SP_RolesGetByUserId @userId = 3

*/

USE Rook
GO

-- =============================================
-- Author:		<Vizsy I.>
-- Create date: <2023.12.04.>
-- Modified date: <>
-- Description:	RefreshToken upsert procedure
-- =============================================

CREATE or ALTER PROCEDURE Auth.SP_RefreshT_Ups @userKey CHAR(8), @userId INT, @secKey CHAR(7)
    ,@longToken CHAR(12), @dateExpire DATETIME
    AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @affRows SMALLINT

    -- Updating if the row already exists
    UPDATE Auth.RefreshToken SET
        SecKey = @secKey,
        LongToken = @LongToken,
        DateExpire = @DateExpire,
        IsRevoked = 0
        WHERE UserKey = @userKey

    SET @affRows = @@ROWCOUNT

    IF @affRows = 0 BEGIN
        INSERT INTO Auth.RefreshToken (UserKey, UserId, SecKey, LongToken, DateExpire, IsRevoked)
            VALUES (@userKey, @userId, @secKey, @longToken, @dateExpire, 0)
        SET @affRows = @@ROWCOUNT
    END

	-- Final result
	SELECT IIF(@affRows=1, 200, 400) Ok

END -- of PROCEDURE

----- Execute
/*
EXEC Auth.SP_RefreshT_Ups @userKey = 'agts-s45', @userId = 3, @secKey = 'hu-HUhu'
    ,@longToken = 'Macro-Hard E', @dateExpire = '2023.12.05 15:38'

*/

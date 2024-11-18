-- Create Profile
CREATE PROCEDURE [CW1].[Create Profile]
    @Username as VARCHAR(50),
    @Passwd as VARCHAR(50),
    @FirstName as VARCHAR(50),
    @LastName as VARCHAR(50),
    @Email as VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Password validation
    IF LEN(@Passwd) < 8 OR LEN(@Passwd) > 20
    BEGIN
        RAISERROR('Password must be between 8 to 20 characters', 16, 1);
        RETURN;
    END

    -- Check for at least one symbol, one uppercase, one lowercase, and one number
    IF NOT (@Passwd LIKE '%[^a-zA-Z0-9]%') -- Contains at least one number
    BEGIN
        RAISERROR('Password must contain at least one symbol, one uppercase, one lowercase, and one number', 16, 1);
        RETURN;
    END

    -- Email validation
    IF @Email NOT LIKE '%_@__%.__%'
    BEGIN
        RAISERROR('Invalid email address format.', 16, 1);
        RETURN;
    END

    DECLARE @UserId UNIQUEIDENTIFIER;
    -- NEWID(): generate the new unique ID
    SET @UserId = NEWID();

    INSERT INTO [CW1].[User] (user_id, username, [password], first_name, last_name, email)
    VALUES (@UserId, @Username, @Passwd, @FirstName, @LastName, @Email);

    -- Return the new user_id
    SELECT @UserId AS UserID;
END

-- EXEC [CW1].[Create Profile] @Username = 'peter', @Passwd = 'peter@25Mj', @FirstName = 'Peter', @LastName = 'Parker', @Email = 'peter@gmail.com';



-- Edit Profile
CREATE PROCEDURE [CW1].[Edit Profile]
    @UserId as UNIQUEIDENTIFIER,
    @Passwd as VARCHAR(50),
    @FirstName as VARCHAR(50),
    @LastName as VARCHAR(50),
    @Email as VARCHAR(50),
    @AboutMe as text,
    @Location as NVARCHAR(50),
    @Language as INT,
    @ProfilePhoto as VARBINARY(8000),
    @Dob as DATE,
    @PhoneNum as VARCHAR(8)
AS
BEGIN
    SET NOCOUNT ON;

    -- Password validation
    IF LEN(@Passwd) < 8 OR LEN(@Passwd) > 20
    BEGIN
        RAISERROR('Password must be between 8 to 20 characters', 16, 1);
        RETURN;
    END
    -- Check for at least one symbol, one uppercase, one lowercase, and one number
    IF NOT (@Passwd LIKE '%[^a-zA-Z0-9]%') -- Contains at least one number
    BEGIN
        RAISERROR('Password must contain at least one symbol, one uppercase, one lowercase, and one number', 16, 1);
        RETURN;
    END

    -- First name and last name validation
    IF @FirstName NOT LIKE '%_%' OR @LastName NOT LIKE '%_%'
    BEGIN
        RAISERROR('First name and last name can not be empty', 16, 1);
        RETURN;
    END

    -- Email validation
    IF @Email NOT LIKE '%_@__%.__%'
    BEGIN
        RAISERROR('Invalid email address format.', 16, 1);
        RETURN;
    END

    -- Phone number validation
    IF LEN(@Passwd) != 8
    BEGIN
        RAISERROR('Length of phone number must equal to 8', 16, 1);
        RETURN;
    END

    -- Edit Details
    UPDATE [CW1].[User] 
    SET [password] = @Passwd, first_name = @FirstName, last_name = @LastName, email = @Email, about_me = @AboutMe, [location] = @Location, language_id = @Language, Dob = @Dob, phone_number = @PhoneNum
    WHERE user_id = @UserId;

END



-- Delete Profile

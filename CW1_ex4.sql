CREATE VIEW [CW1].[User Public Info] AS
SELECT first_name, last_name, about_me, profile_photo, [CW1].[Activity].activity
FROM (([CW1].[User Favority Activity]
INNER JOIN [CW1].[User] ON [CW1].[User Favority Activity].user_id = [CW1].[User].user_id)
INNER JOIN [CW1].[Activity] ON [CW1].[User Favority Activity].activity_id = [CW1].[Activity].activity_id);
WHERE [CW1].[User].[isAdmin] = 0;

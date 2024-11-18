-- Create Tables
-- User
CREATE TABLE [CW1].[User] (
  user_id UNIQUEIDENTIFIER PRIMARY KEY,
  username varchar(50) NOT NULL,
  password varchar(50) NOT NULL,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL,
  email nvarchar(50) NOT NULL,
  phone_number varchar(8), 
  about_me text,
  location varchar(50),
  language_id int NOT NULL,
  profile_photo varbinary(8000),
  Dob date NOT NULL DEFAULT GETDATE(),
  isAdmin bit NOT NULL,
  UNIQUE NONCLUSTERED ([password] ASC),
  UNIQUE NONCLUSTERED ([username] ASC),
  UNIQUE NONCLUSTERED ([email] ASC),
  CONSTRAINT fk_language FOREIGN KEY(language_id) REFERENCES [CW1].[Language](language_id)
); 

-- Archived Log
CREATE TABLE [CW1].[Archived Log] (
    archived_id UNIQUEIDENTIFIER PRIMARY KEY,
    user_id UNIQUEIDENTIFIER NOT NULL,
    archived_date DATE NOT NULL,
    reason text,
    account_status VARCHAR(10) NOT NULL,
    archived_by UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT fk_archived_user FOREIGN KEY(user_id) REFERENCES [CW1].[User](user_id),
    ADD CONSTRAINT fk_admin FOREIGN KEY(archived_by) REFERENCES [CW1].[User](user_id)
);

-- Language
CREATE TABLE [CW1].[Language] (
  language_id int IDENTITY (1, 1) NOT NULL,
  language nvarchar(50) NOT NULL,
  PRIMARY KEY CLUSTERED ([language_id] ASC)
);

-- Trail
CREATE TABLE [CW1].[Trail] (
  trail_id UNIQUEIDENTIFIER PRIMARY KEY,
  user_id UNIQUEIDENTIFIER NOT NULL,
  trail_name varchar(50) NOT NULL,
  trail_date datetime,
  trail_photo varbinary(8000),
  CONSTRAINT fk_user_trail FOREIGN KEY(user_id) REFERENCES [CW1].[User](user_id)
);

-- Activity
CREATE TABLE [CW1].[Activity] (
  activity_id int IDENTITY (1, 1) NOT NULL,
  activity varchar(20) NOT NULL,
  PRIMARY KEY CLUSTERED ([activity_id] ASC)
);

-- User Favority Activity
CREATE TABLE [CW1].[User Favority Activity] (
  user_fav_activity_id UNIQUEIDENTIFIER PRIMARY KEY,
  user_id UNIQUEIDENTIFIER NOT NULL,
  activity_id int NOT NULL,
  CONSTRAINT fk_user_fav_activity FOREIGN KEY (user_id) REFERENCES [CW1].[User](user_id),
  CONSTRAINT fk_activity FOREIGN KEY (activity_id) REFERENCES [CW1].[Activity](activity_id)
);



-- Insert Values
-- Activity's values
INSERT INTO [CW1].[Activity] VALUES
('Backpacking'),
('Bike touring'),
('Birding'),
('Camping'),
('Cross-country skiing'),
('Fishing'),
('Hiking'),
('Horseback riding'),
('Mountain biking'),
('Off-road driving'),
('Paddle sports'),
('Road biking'),
('Rock climbing'),
('Running'),
('Scenic driving'),
('Skiing'),
('Skiing'),
('Snowsheing'),
('Via ferrata'),
('Walking');

-- Language's values
INSERT INTO [CW1].[Language] VALUES
('English'),
(N'中文 (繁體)'),
(N'中文 (簡體)');

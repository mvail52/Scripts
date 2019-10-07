DROP TABLE [AddressUpdate]
--SELECT * FROM [AddressUpdate]
-- select * from [AddressInsert]
CREATE TABLE [AddressUpdate]
(
		[Address] VARCHAR(100),
        [City] VARCHAR(25),
        [State] VARCHAR(50),
        [PostalCode] VARCHAR(10),
        [Country] VARCHAR(40),
        [County] VARCHAR(40),
        [Latitude] NUMERIC(18, 9),
        [Longitude] NUMERIC(18, 9),
        [URL]  VARCHAR(MAX),
		[ID] int PRIMARY KEY NOT NULL 
		)

INSERT INTO [dbo].[AddressUpdate]
(
    [Address],
    [City],
    [State],
    [PostalCode],
    [Country],
    [County],
    [Latitude],
    [Longitude],
    [URL],
    [ID]
)
VALUES
(   '1234 Shenandoah Dr E',   -- Address - varchar(100)
    '',   -- City - varchar(25)
    '',   -- State - varchar(50)
    '98112',   -- PostalCode - varchar(10)
    '',   -- Country - varchar(40)
    '',   -- County - varchar(40)
    NULL, -- Latitude - numeric(18, 9)
    NULL, -- Longitude - numeric(18, 9)
    '',   -- URL - varchar(max)
    0     -- ID - int
    )
,

(   '1234 Huson Dr',   -- Address - varchar(100)
    '',   -- City - varchar(25)
    'WA ',   -- State - varchar(50)
    '',   -- PostalCode - varchar(10)
    '',   -- Country - varchar(40)
    '',   -- County - varchar(40)
    NULL, -- Latitude - numeric(18, 9)
    NULL, -- Longitude - numeric(18, 9)
    '',   -- URL - varchar(max)
    1     -- ID - int
    )
	,

(   '15 North 3rd Avenue',   -- Address - varchar(100)
    ' Walla Walla',   -- City - varchar(25)
    ' ',   -- State - varchar(50)
    '',   -- PostalCode - varchar(10)
    '',   -- Country - varchar(40)
    '',   -- County - varchar(40)
    NULL, -- Latitude - numeric(18, 9)
    NULL, -- Longitude - numeric(18, 9)
    '',   -- URL - varchar(max)
    2     -- ID - int
    )

DELETE FROM [AddressInsert]
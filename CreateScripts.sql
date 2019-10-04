-- create database if you need it 

IF NOT EXISTS
  (SELECT [name]
     FROM [sys].[databases]
    WHERE [name] = 'Test_DB')
  BEGIN
    CREATE DATABASE [Test_DB]
  END
GO

USE [Test_DB]
GO

-- usually i define the tables i need. If you want you can pull this from sys info or differnt query, just delete here through line 36.
IF OBJECT_ID('[dbo].[Tables_Pulled]', 'U') IS NOT NULL
  BEGIN
    DROP TABLE [dbo].[Tables_Pulled]
  END
GO

CREATE TABLE [dbo].[Tables_Pulled]
  ([database] VARCHAR(25)
  ,[table] VARCHAR(25))
GO

INSERT INTO [dbo].[Tables_Pulled]
     (
       [database]
      ,[table]
     )
VALUES
     ('LeeroyJenkin', 'WOW')
    ,('Link', 'Zelda')
    ,('Link', 'Boy_Toy')

-- Variables I will use 
DECLARE @database VARCHAR(25)
       ,@table VARCHAR(25)

-- open cursor loop through my table 
DECLARE [cur] CURSOR FAST_FORWARD READ_ONLY FOR
  SELECT [table]
    FROM [dbo].[Tables_Pulled]
OPEN [cur]

FETCH NEXT FROM [cur]
 INTO @table

WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @database = [database]
      FROM [dbo].[Tables_Pulled]
     WHERE @table = [table]

    -- choose what i want just uncomment 

    --writes my query which i can populate into anoter sql script 
	    --PRINT ('Select * into [' + @database + '].[' + @table + '_after] FROM [' + @database + '].[' + @table + '] GO')

	--execute because i know it will work
		 --EXEC ('Select * into [' + @database + '].[' + @table + '_after] FROM [' + @database + '].[' + @table + ']')

    -- clear @datbase
    SET @database = ''

    FETCH NEXT FROM [cur]
     INTO @table

  END

-- clean up
CLOSE [cur]
DEALLOCATE [cur]
GO
DECLARE @Address AS VARCHAR(100),
        @City AS VARCHAR(25),
        @State AS VARCHAR(50),
        @PostalCode AS VARCHAR(10),
        @Country AS VARCHAR(40),
        -- getting information out of google
        @County AS VARCHAR(40),
        @GPSLatitude AS NUMERIC(18, 9),
        @GPSlongitude AS NUMERIC(18, 9),
        -- these are used to send the request and handle erros 
        @URL VARCHAR(MAX),
        @Response VARCHAR(8000),
        @XML XML,
        @Obj INT,
        @result INT,
        @httpstatus INT,
        @errormsg VARCHAR(MAX),
        --used in cursor to get each item
        @UniqueID AS INT,
		--Used to decide if you want to insert or update table 
        @InsertOrUpdate AS BINARY

-- if your using this to update a current table 1 if you using this to insert into a new table 0
SET @InsertOrUpdate = 0


--Declare a cursor on the list you want to run this on, just need to update Table name and column
DECLARE cur CURSOR FAST_FORWARD READ_ONLY
FOR
SELECT [ID]
FROM [AddressUpdate]

-- Open cursor and begin looping
OPEN cur

FETCH NEXT FROM cur INTO @UniqueID

WHILE @@FETCH_STATUS = 0
BEGIN

-- set the address.
SELECT @Address = [Address],
       @City = [City],
       @State = [State],
       @PostalCode = [PostalCode],
       @Country = [Country]
FROM [AddressUpdate]
WHERE [ID] = @UniqueID


-- Used to Create My URL 

SET @URL
    = 'https://maps.google.com/maps/api/geocode/xml?sensor=false&address='
      + IIF(@Address IS NOT NULL, @Address + ' ', '') 
	  + IIF(@City IS NOT NULL, @City + ' ', '')
      + IIF(@State IS NOT NULL, @State + ' ', '') 
	  + IIF(@PostalCode IS NOT NULL, @PostalCode + ' ', '')
      + IIF(@Country IS NOT NULL, @Country + ' ', '')

--The format requires spaces to be +.
--Please visit to https://developers.google.com/maps/documentation/embed/get-api-key to get instructions to get API key inset below and uncomment 
   SET @URL = REPLACE(RTRIM(@URL), ' ', '+') -- +'PUT KEY HERE'

   -- get my data from Google
   EXEC @result = [sp_OACreate] 'MSXML2.ServerXMLHttp' , @Obj OUT
   -- 
   BEGIN TRY
		EXEC @result = [sp_OAMethod] @Obj, 'open' , NULL, 'Get', @URL, [false]
		EXEC @result = [sp_OAMethod] @Obj, 'setrequestheader' , NULL, 'Content-Type', 'application/x-www-form-urlencoded'
		EXEC @result = [sp_OAMethod] @Obj, [send] , NULL, ''
		EXEC @result = [sp_OAGetProperty] @Obj, 'status' , @httpstatus OUT
		EXEC @result = [sp_OAGetProperty] @Obj, 'responseXML.xml' , @Response OUT
	END TRY

	-- get any errors, common error is 404 and or max limit has been been reached when using google free key which is 1500 
	BEGIN CATCH
	SET @errormsg = ERROR_MESSAGE()
	END CATCH

	-- get the results from google 
	EXEC @result = [sp_OADestroy] @Obj

	-- Display error
	IF(@errormsg IS NOT NULL) OR (@httpstatus <> 200)
	BEGIN
		SET @errormsg = 'Error in spgeocode: ' +ISNULL(@errormsg, 'HTTP result is: ' + CAST(@httpstatus AS VARCHAR(10)))
		RAISERROR(@errormsg, 16 , 1, @httpstatus)
		RETURN
	END



SET @XML = CAST(@Response AS XML)
-- Update Variables 
SET @GPSLatitude = @XML.[value]('(/GeocodeResponse/result/geometry/location/lat) [1]', 'Numeric(18,9)')
SET @GPSlongitude = @XML.[value]('(/GeocodeResponse/result/geometry/location/lng) [1]', 'Numeric(18,9)')
SET @City = @XML.[value]('(/GeocodeResponse/result/address_component[type="locality"]/long_name) [1]', 'Varchar(40)')
SET @State = @XML.[value]('(/GeocodeResponse/result/address_component[type="administrative_area_level_1"]/short_name) [1]', 'Varchar(40)')
SET @PostalCode = @XML.[value]('(/GeocodeResponse/result/address_component[type="postal_code"]/long_name) [1]', 'Varchar(20)')
SET @Country = @XML.[value]('(/GeocodeResponse/result/address_component[type="country"]/short_name) [1]', 'Varchar(40)')
SET @County = @XML.[value]('(/GeocodeResponse/result/formatted_address) [1]', 'Varchar(100)')


--I wrote both one to update or one insert into a new table change the variable at the top to change what you use. 
--Just change the tables name to match what you need.
IF @InsertOrUpdate = 0
BEGIN
    INSERT INTO [AddressInsert] --Your Table here 
    ( -- Column here 
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
    SELECT @Address AS [Address],
           @City AS [City],
           @State AS [State],
           @PostalCode AS [PostalCode],
           @Country AS [Country],
           @County AS [County],
           @GPSLatitude [Latitude],
           @GPSlongitude [Longitude],
           @URL [URL],
		   @UniqueID [ID]

END
ELSE IF @InsertOrUpdate = 1
BEGIN
UPDATE [AddressUpdate]
SET [Address] = @Address,
    [City] = @City,
    [State] = @State,
    [PostalCode] = @PostalCode,
    [Country] = @Country,
    [County] = @County,
    [Latitude] = @GPSLatitude,
    [Longitude] = @GPSlongitude,
    [URL] = @URL
WHERE [ID] = @UniqueID
END

-- reseting variables, if you do not reset the variables then you will give mix up and random erros 
SET @Address = ''
SET @City = ''
SET @State = ''
SET @PostalCode = ''
SET @Country = ''
SET @County = ''
SET @GPSLatitude = NULL
SET @GPSlongitude = NULL
SET @URL = ''


-- get next Item and repeat 
     FETCH NEXT FROM [cur] INTO @UniqueID

   END

-- clean up
CLOSE [cur]
DEALLOCATE [cur]
GO
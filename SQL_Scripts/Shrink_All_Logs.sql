DECLARE @site VARCHAR(MAX)
DECLARE @log VARCHAR(MAX)
DECLARE @sql VARCHAR(MAX)


DECLARE [cur] CURSOR FAST_FORWARD READ_ONLY FOR
  SELECT DISTINCT [db].[name] AS [DBName]
    FROM [sys].[master_files] [mf]
    INNER JOIN [sys].[databases] [db]
      ON [db].[database_id] = [mf].[database_id]
   WHERE [type_desc] = 'LOG'
   ORDER BY [db].[name]

OPEN [cur]

FETCH NEXT FROM [cur]
 INTO @site

WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @log =
      (SELECT DISTINCT [mf].[name]
         FROM [sys].[master_files] [mf]
         INNER JOIN [sys].[databases] [db]
           ON [db].[database_id] = [mf].[database_id]
        WHERE [type_desc] = 'LOG'
          AND [db].[name] = @site)

    SET @sql = 'use ' + @site + '; DBCC SHRINKFILE (N''' + @log + ''', 0, TRUNCATEONLY)'
	PRINT(@site + ' logs are starting to be truncated')
    EXEC (@sql)
	PRINT(@site + ' logs finished truncating')
    FETCH NEXT FROM [cur]
     INTO @site

  END
DEALLOCATE [cur]



ALTER Procedure productListOR
@page int,
@size int,
@sort nvarchar(50),
@searchText nvarchar(250),
@debug bit=0
AS
BEGIN
	DECLARE @sql NVARCHAR(4000),@paramlist  NVARCHAR(MAX)
	SET NOCOUNT ON
	SET @sql='SELECT * FROM Product WHERE Name= @searchText OR Description=@searchText OR ImageUrl=@searchText OR Category=@searchText
	ORDER BY '+@sort+' ASC OFFSET @size*(@page-1) ROWS FETCH NEXT  @size ROWS ONLY'
	IF @debug=1 PRINT @sql
	SELECT @paramlist='@searchText [NVARCHAR](250),@page [int],@size [int]'
	EXEC sp_executesql @sql,@paramlist,@searchText,@page,@size

END;

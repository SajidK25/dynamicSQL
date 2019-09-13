ALTER PROCEDURE [dbo].[ProductListAND]
	@Page			int,
	@size			int,
	@sort			nvarchar(50),
	@id				int =NULL,
	@Name			nvarchar(250)=NULL,
	@Price			decimal(18,2)=NULL,
	@Description	nvarchar(MAX)=NULL,
	@ImageUrl		nvarchar(250)=NULL,
	@Rating			decimal(18,2)=NULL,
	@Weight			decimal(18,2)=NULL,
	@Width			int=NULL,
	@Height			int=NULL,
	@Category		nvarchar(50)=NULL,
	@IsActive		bit=NULL,
	@debug			bit=0
	
AS
BEGIN
	DECLARE @sql nvarchar(MAX),@paramlist nvarchar(MAX),@searchString nvarchar(4000)
	SET NOCOUNT ON;
	SET @sql=' SELECT * FROM Product '
			
	 IF @id IS NOT NULL OR
		@Name IS NOT NULL OR
		@Price IS NOT NULL OR
		@Description IS NOT NULL OR
		@ImageUrl IS NOT NULL OR
		@Rating IS NOT NULL OR
		@Weight IS NOT NULL OR
		@Width IS NOT NULL OR
		@Height IS NOT NULL OR
		@Category IS NOT NULL OR
		@IsActive IS NOT NULL SET @sql+='WHERE 1=1'

	 SET @searchString='%'+@Name+'%'

	 IF @id IS NOT NULL
		SET @sql+=' AND Id=@id'
	 IF @Name IS NOT NULL
		SET @sql+=' AND [Name] LIKE  @searchString'
	 IF @Price IS NOT NULL
		SET @sql+=' AND Price=@Price'
	 IF @Description IS NOT NULL
		SET @sql+=' AND Description=@Description'
	 IF @ImageUrl IS NOT NULL
		SET @sql+=' AND ImageUrl=@ImageUrl'
	 IF @Category IS NOT NULL
		SET @sql+=' AND Category=@Category'

	 SET @sql+= ' ORDER BY '+ @sort+' ASC OFFSET @size *(@page-1) ROWS FETCH NEXT @size ROWS ONLY'

	 IF @debug=1 PRINT(@sql)
	 SELECT @paramlist= '@id [int],
	@searchString	[nvarchar](4000),
	@Price	[decimal](18,2),
	@Description  [nvarchar](MAX),
	@ImageUrl	[nvarchar](250),
	@Rating		[decimal](18,2),
	@Weight		[decimal](18,2),
	@Width		[int],
	@Height		[int],
	@Category	[nvarchar](50),
	@IsActive	[bit],
	@Page [int],
	@size [int]'
	
	EXEC sp_executesql @sql,@paramlist,@id,@searchString,@Price,
	@Description,@ImageUrl,@Rating,
	@Weight,@Width,@Height,@Category,
	@IsActive,@Page,@size

	

END
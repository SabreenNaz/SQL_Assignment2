create database Assignmrnt2
use Assignmrnt2
----Tasks to be performed:
---1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
    ---Chicken Bites’.

CREATE OR ALTER FUNCTION fn_StuffChicken
(
@Name NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN
   DECLARE @RESULT NVARCHAR (200)
   IF @Name = 'Chiken'
      RETURN 'Quick Chicken Bites';
    RETURN @RESULT
END


select dbo.fn_StuffChiken('Chiken')


--2. Use the function to display the restaurant name and cuisine type which has the
    --maximum number of rating.

select TOP 1 RestaurantName,
           CuisinesType		   
from Jomato
OrdER BY Rating DESC


-- 3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4start rating, 
    -- ‘Good’ if it has above 3.5 and below 5 star rating, ‘Average’ if it is above 3 and below 3.5 and ‘Bad’ if it is below 3 star rating.

ALTER TABLE Jomato
ADD Rating_Status NVARCHAR(50)


UPDATE Jomato
SET Rating_Status = 
CASE
    WHEN Rating >4 THEN 'Excellent'
	WHEN Rating >=3.5 AND Rating < 5 THEN 'Good'
	WHEN Rating >=3 AND Rating < 3.5 THEN 'Average'
	ELSE 'Bad'
END 


--4. Find the Ceil, floor and absolute values of the rating column and display the current date
   -- and separately display the year, month_name and day.



SELECT Rating,
       CEILING(Rating) AS RatingCeil,
	   FLOOR(Rating) AS RatingFloor,
	   ABS(Rating)AS RatingAbsolute,
	   GETDATE() AS CurrentDate,
	   DATEPART(YY,GETDATE()) AS [Year],
	   DATENAME(MM,GETDATE()) AS [Month],
	   DATEPART(DD,GETDATE()) AS [Day]
FROM Jomato

--5. Display the restaurant type and total average cost using rollup.
select 
       ISNULL(RestaurantType, 'Total') AS RestaurantType,
       SUM(AverageCost)TotalAverageCost 
	   from Jomato
GROUP BY
ROLLUP (RestaurantType)




-- identifying null values --
SELECT *
FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL
-- Removing null values --
DELETE FROM dbo.googleplaystore
WHERE App IS NULL
OR Category IS NULL
OR Rating IS NULL
OR Reviews IS NULL
OR Size IS NULL
OR Installs IS NULL
OR Type IS NULL
OR Price IS NULL
OR Content_Rating IS NULL
OR Genres IS NULL
OR Last_Updated IS NULL
OR Current_Ver IS NULL
OR Android_Ver IS NULL
-- Overall view of daatset --
SELECT
COUNT(DISTINCT APP) AS total_apps,
COUNT(DISTINCT Category) AS total_categories
FROM dbo.googleplaystore

--Exploring App Categories--
SELECT TOP 5
Category,
COUNT(App) AS Total_app
FROM DBO.googleplaystore
GROUP BY  Category
ORDER BY Total_app DESC

-- Identifying Top Rated Free-Apps -- 
SELECT TOP 10
Rating,
Reviews,
Installs,
App
FROM DBO.googleplaystore
WHERE Type = 'Free' AND Rating <> 'NaN'
ORDER BY Rating DESC

-- Identifying Most Reviewed Apps --
SELECT TOP 10
Reviews,
App
FROM DBO.googleplaystore
ORDER BY Reviews DESC

-- Average Rating By Categories --
SELECT TOP 5
Category,
AVG(TRY_CAST(Rating AS FLOAT)) AS avg_rating
FROM DBO.googleplaystore
GROUP BY Category
ORDER BY avg_rating DESC

-- Top categories by number of Installs --
SELECT TOP 5
Category,
COUNT(Installs) AS number_of_installs
FROM DBO.googleplaystore
GROUP BY Category
ORDER BY number_of_installs DESC

-- Avg sentiment polarity by app category --
SELECT
Category,
AVG(TRY_CAST(Sentiment_Polarity AS FLOAT)) AS avg_sentiment_polarity
FROM DBO.googleplaystore
JOIN DBO.googleplaystore_user_reviews
ON DBO.googleplaystore.App	= DBO.googleplaystore_user_reviews.App
GROUP BY Category
ORDER BY avg_sentiment_polarity DESC

--SENTIMENT REVIEW BY APP CATEGORY --
SELECT
Category,
Sentiment,
COUNT(*) AS total_sentiment
FROM DBO.googleplaystore
JOIN DBO.googleplaystore_user_reviews
ON DBO.googleplaystore.App	= DBO.googleplaystore_user_reviews.App
WHERE Sentiment <> 'NAN'
GROUP BY Category, Sentiment
ORDER BY total_sentiment DESC
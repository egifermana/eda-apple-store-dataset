-- Combining all separated file
CREATE TABLE appleStore_description_combined AS
SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4


** EXPLORATORY DATA ANALYSIS **
-- Check the number of unique apps in both tableAppleStore
SELECT COUNT(DISTINCT id) as UniqueAppIDs
From AppleStore

SELECT COUNT(DISTINCT id) as UniqueAppIDs
From appleStore_description_combined


-- Check for any missing values in key fields 
SELECT COUNT(*) as MissingValues
From AppleStore
WHERE track_name is NULL or user_rating is NULL or prime_genre is NULL

SELECT COUNT(*) as MissingValues
From appleStore_description_combined
WHERE app_desc is NULL


-- Find out the number of apps per genre 
SELECT prime_genre, COUNT(*) as NumApps
FROM AppleStore
GROUP BY prime_genre
order BY NumApps DESC


-- Get an overview of the apps ratings 
SELECT min(user_rating) as MinRating,
       max(user_rating) as MaxRating,
       avg(user_rating)	as AvgRating
FROM AppleStore


-- Get the distribution of app prices
SELECT
	(price / 2) *2 as PriceBinStart,
    ((price / 2) *2) +2 As PriceBinEnd,
    COUNT(*) as NumApps
FROM AppleStore
group by PriceBinStart
ORDER BY PriceBinStart


** DATA ANALYSIS **
-- Determine whether paid apps have higher ratings than free apps 
SELECT CASE
			When price > 0 THEN 'Paid'
            ELSE 'Free'
       End as App_Type,
       avg(user_rating) as Avg_Rating
FROM AppleStore
Group By App_Type


-- Check if apps with more supported languages have higher ratings 
SELECT CASE
			WHEN lang_num < 10 Then '<10 Languages'
            when lang_num BETWEEN 10 and 30 then '10-30 Languages'
            ELSE '>30 Languages'
       End as language_bucket,
       avg(user_rating) as Avg_Rating
FROM AppleStore
group by language_bucket
ORDER by Avg_Rating DESC


-- Check genres with low ratings 
SELECT prime_genre, avg(user_rating) as Avg_Rating
FROM AppleStore
group by prime_genre
order by Avg_Rating DESC
LIMIT 10


-- Check if there is correlation between the lenght of the app description and the user rating 
SELECT CASE
			WHen length(b.app_desc) <500 Then 'Short'
            WHEn length(b.app_desc) BETWEEN 500 and 1000 then 'Medium'
            ELSE 'Long'
       End as description_length_bucket,
       avg(a.user_rating) as average_rating
from AppleStore as A
JOIN appleStore_description_combined as B 
On a.id = b.id
GROUP by description_length_bucket
ORDER by average_rating DESC


-- Check the top-rated apps for each genre 
SELECT prime_genre, track_name, user_rating
FROM (
  	  SELECT prime_genre, track_name, user_rating,
      RANK() OVER(PARTITION by prime_genre ORDER BY user_rating DESC, rating_count_tot Desc) as rank
      FROM AppleStore) As a 
WHERE a.rank = 1
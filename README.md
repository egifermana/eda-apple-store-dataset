# SQL Exploratory Data Analysis on Apple Store Dataset

![SQL Preview](Screenshot.jpg)
## Overview
This repository contains an exploratory data analysis (EDA) on Apple Store Apps data using SQL. The analysis includes various SQL queries to gain insights into the dataset, such as checking missing values, exploring the distribution of app genres, reviewing app ratings, and more.

## Key Insights
* Paid apps generally have better ratings than free apps.
* Apps supporting between 10-30 languages tend to have higher ratings.
* Finance and book apps have lower average ratings.
* Apps with longer descriptions tend to have better ratings.
* A new app should aim for an average rating above 3.5.
* Games and Entertainment genres face high competition.

## Data Integration
To facilitate analysis, the project combines data from multiple files into a unified table named `appleStore_description_combined`. This consolidated table contains data from `appleStore_description1`, `appleStore_description2`, `appleStore_description3`, and `appleStore_description4`.

```sql
CREATE TABLE appleStore_description_combined AS
SELECT * FROM appleStore_description1
UNION ALL
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL
SELECT * FROM appleStore_description4;
```

## Exploratory Data Analysis
### Unique App IDs
Check the number of unique apps in both `AppleStore` and `appleStore_description_combined` tables.

```sql
SELECT COUNT(DISTINCT id) as UniqueAppIDs
FROM AppleStore;

SELECT COUNT(DISTINCT id) as UniqueAppIDs
FROM appleStore_description_combined;
```
Output:
```output
7197
```
### Missing Values
Identify missing values in key fields of both tables.

```sql
SELECT COUNT(*) as MissingValues
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL;

SELECT COUNT(*) as MissingValues
FROM appleStore_description_combined
WHERE app_desc IS NULL;
```
Output:
```output
0
```
### Number of Apps per Genre
Find out the number of apps per genre in the `AppleStore` table.

```sql
SELECT prime_genre, COUNT(*) as NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC;
```
Output:
| prime_genre        | NumApp |
|--------------------|--------|
| Games              | 3862   |
| Entertainment      | 535    |
| Education          | 453    |
| Photo & Video      | 349    |
| Utilities          | 248    |
| Health & Fitness   | 180    |
| Productivity       | 178    |
| Social Networking  | 167    |
| Lifestyle          | 144    |
| Music              | 138    |
| Shopping           | 122    |
| Sports             | 114    |
| Book               | 112    |
| Finance            | 104    |
| Travel             | 81     |
| News               | 75     |
| Weather            | 72     |
| Reference          | 64     |
| Food & Drink       | 63     |
| Business           | 57     |
| Navigation         | 46     |
| Medical            | 23     |
| Catalogs           | 10     |

### Overview of App Ratings
Get an overview of the app ratings, including minimum, maximum, and average ratings.

```sql
SELECT MIN(user_rating) as MinRating,
       MAX(user_rating) as MaxRating,
       AVG(user_rating) as AvgRating
FROM AppleStore;
```
Output:
| MinRating | MaxRating | AvgRating              |
|-----------|-----------|------------------------|
| 0         | 5         | 3.526955675976101     |

### Distribution of App Prices
Explore the distribution of app prices in the `AppleStore` table.

```sql
SELECT
    (price / 2) * 2 as PriceBinStart,
    ((price / 2) * 2) + 2 AS PriceBinEnd,
    COUNT(*) as NumApps
FROM AppleStore
GROUP BY PriceBinStart
ORDER BY PriceBinStart;
```
Output:
| PriceBinStart | PriceBinEnd | NumApps |
|---------------|-------------|---------|
| 0             | 2           | 4056    |
| 0.99          | 2.99        | 728     |
| 1.99          | 3.99        | 621     |
| 2.99          | 4.99        | 683     |
| 3.99          | 5.99        | 277     |
| 4.99          | 6.99        | 394     |
| 5.99          | 7.99        | 52      |
| 6.99          | 8.99        | 166     |
| 7.99          | 9.99        | 33      |
| 8.99          | 10.99       | 9       |
| 9.99          | 11.99       | 81      |
| 11.99         | 13.99       | 6       |
| 12.99         | 14.99       | 5       |
| 13.99         | 15.99       | 6       |
| 14.99         | 16.99       | 21      |
| 15.99         | 17.99       | 4       |
| 16.99         | 18.99       | 2       |
| 17.99         | 19.99       | 3       |
| 18.99         | 20.99       | 1       |
| 19.99         | 21.99       | 13      |
| 20.99         | 22.99       | 2       |
| 21.99         | 23.99       | 1       |
| 22.99         | 24.99       | 2       |
| 23.99         | 25.99       | 2       |
| 24.99         | 26.99       | 8       |
| 27.99         | 29.99       | 2       |
| 29.99         | 31.99       | 6       |
| 34.99         | 36.99       | 1       |
| 39.99         | 41.99       | 2       |
| 47.99         | 49.99       | 1       |
| 49.99         | 51.99       | 2       |
| 59.99         | 61.99       | 3       |
| 74.99         | 76.99       | 1       |
| 99.99         | 101.99      | 1       |
| 249.99        | 251.99      | 1       |
| 299.99        | 301.99      | 1       |


## Data Analysis
### Paid vs. Free Apps
Determine whether paid apps have higher ratings than free apps.
```sql
SELECT CASE
           WHEN price > 0 THEN 'Paid'
           ELSE 'Free'
       END as App_Type,
       AVG(user_rating) as Avg_Rating
FROM AppleStore
GROUP BY App_Type;
```
Output:
| App_Type | Avg_Rating              |
|----------|-------------------------|
| Free     | 3.3767258382642997     |
| Paid     | 3.720948742438714      |

### Ratings Based on Supported Languages
Check if apps with more supported languages have higher ratings.

```sql
SELECT CASE
           WHEN lang_num < 10 THEN '<10 Languages'
           WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 Languages'
           ELSE '>30 Languages'
       END as language_bucket,
       AVG(user_rating) as Avg_Rating
FROM AppleStore
GROUP BY language_bucket
ORDER BY Avg_Rating DESC;
```
Output:
| language_bucket    | Avg_Rating            |
|-------------------- |-----------------------|
| 10-30 Languages    | 4.1305120910384066   |
| >30 Languages      | 3.7777777777777777   |
| <10 Languages      | 3.368327402135231    |

### Genres with Low Ratings
Identify genres with low average ratings in the `AppleStore` table.

```sql
SELECT prime_genre, AVG(user_rating) as Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating DESC
LIMIT 10;
```
Output:
| prime_genre        | Avg_Rating           |
|--------------------|----------------------|
| Productivity       | 4.00561797752809    |
| Music              | 3.9782608695652173  |
| Photo & Video      | 3.8008595988538683  |
| Business           | 3.745614035087719   |
| Health & Fitness   | 3.7                  |
| Games              | 3.6850077679958573  |
| Weather            | 3.5972222222222223  |
| Shopping           | 3.540983606557377   |
| Reference          | 3.453125             |
| Travel             | 3.376543209876543   |

### Description Length and User Rating Correlation
Investigate if there is a correlation between the length of the app description and user ratings.
```sql
SELECT CASE
           WHEN LENGTH(b.app_desc) < 500 THEN 'Short'
           WHEN LENGTH(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
           ELSE 'Long'
       END as description_length_bucket,
       AVG(a.user_rating) as average_rating
FROM AppleStore as a
JOIN appleStore_description_combined as b ON a.id = b.id
GROUP BY description_length_bucket
ORDER BY average_rating DESC;
```
Output:
| Description Length Bucket | Average Rating         |
|---------------------------|------------------------|
| Long                      | 3.855946944988041     |
| Medium                    | 3.232809430255403     |
| Short                     | 2.533613445378151     |

### Top-rated Apps for Each Genre
Retrieve the top-rated apps for each genre based on user ratings.
```sql
SELECT prime_genre, track_name, user_rating
FROM (
          SELECT prime_genre, track_name, user_rating,
          RANK() OVER(PARTITION by prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) as rank
          FROM AppleStore) As a 
WHERE a.rank = 1;
```
Output:
| prime_genre        | track_name                                                      | user_rating |
|--------------------|-----------------------------------------------------------------|-------------|
| Book               | Color Therapy Adult Coloring Book for Adults                   | 5           |
| Business           | TurboScan™ Pro - document & receipt scanner: scan multiple pages and photos to PDF | 5           |
| Catalogs           | CPlus for Craigslist app - mobile classifieds                  | 5           |
| Education          | Elevate - Brain Training and Games                             | 5           |
| Entertainment      | Bruh-Button                                                     | 5           |
| Finance            | Credit Karma: Free Credit Scores, Reports & Alerts             | 5           |
| Food & Drink       | Domino's Pizza USA                                              | 5           |
| Games              | Head Soccer                                                     | 5           |
| Health & Fitness   | Yoga Studio                                                     | 5           |
| Lifestyle          | ipsy - Makeup, subscription and beauty tips                    | 5           |
| Medical            | Blink Health                                                    | 5           |
| Music              | Tenuto                                                          | 5           |
| Navigation         | parkOmator – for Apple Watch meter expiration timer, notifications & GPS navigator to car location | 5           |
| News               | The Guardian                                                    | 5           |
| Photo & Video      | Pic Collage - Picture Editor & Photo Collage Maker             | 5           |
| Productivity       | VPN Proxy Master - Unlimited WiFi security VPN                  | 5           |
| Reference          | Sky Guide: View Stars Night or Day                              | 5           |
| Shopping           | Zappos: shop shoes & clothes, fast free shipping               | 5           |
| Social Networking  | We Heart It - Fashion, wallpapers, quotes, tattoos              | 5           |
| Sports             | J23 - Jordan Release Dates and History                         | 5           |
| Travel             | Urlaubspiraten                                                  | 5           |
| Utilities          | Flashlight Ⓞ                                                    | 5           |
| Weather            | NOAA Hi-Def Radar Pro - Storm Warnings, Hurricane Tracker & Weather Forecast | 5           |

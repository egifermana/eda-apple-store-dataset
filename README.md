# Exploratory Data Analysis on Apple Store Dataset

## Overview
This repository contains an exploratory data analysis (EDA) on Apple Store Apps data using SQL. The analysis includes various SQL queries to gain insights into the dataset, such as checking missing values, exploring the distribution of app genres, reviewing app ratings, and more.

## Key Insights
1. Paid apps generally have better ratings than free apps
2. Apps supporting between 10-30 languages tend to have higher ratings
3. Finance and book apps have lower average ratings
4. Apps with longer descriptions tend to have better ratings
5. A new app should aim for an average rating above 3.5
6. Games and Entertainment genres face high competition.

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
SELECT prime_genre, COUNT(*) as num_apps
FROM AppleStore
GROUP BY prime_genre
ORDER BY num_apps DESC;
```

1. Most popular genre: Games is the most popular genre with 3862 apps, followed by Entertainment with 535 apps
2. Distribution: The number of apps varies greatly across genres, with Games having significantly more apps than most other genres
3. Less popular genres: Some genres have relatively few apps, such as Catalogs with only 10 apps
4. Potential for further analysis: This data could be used to further analyze app trends, user preferences, and market saturation in different genres.

Output:
| prime_genre        | num_apps |
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
SELECT MIN(user_rating) as min_rating,
       MAX(user_rating) as max_rating,
       AVG(user_rating) as avg_rating
FROM AppleStore;
```
1. The average rating across all apps is 3.53
2. The minimum possible rating is 0 and the maximum possible rating is 5.

Output:
| min_rating | max_rating | avg_rating              |
|-----------|-----------|------------------------|
| 0         | 5         | 3.526955675976101     |

### Distribution of App Prices
Explore the distribution of app prices in the `AppleStore` table.

```sql
SELECT
    (price / 2) * 2 as price_bin_start,
    ((price / 2) * 2) + 2 AS price_bin_end,
    COUNT(*) as num_apps
FROM AppleStore
GROUP BY price_bin_start
ORDER BY price_bin_start;
```
1. **Lower Price Ranges (up to $2)**: The majority of apps fall within the lower price range, specifically between $0 and $2, with 4056 apps
2. **Moderate Price Ranges ($2 to $9.99)**: There is a consistent distribution of apps in the moderate price ranges, with notable peaks between $2.99 to $3.99 (728 apps), $4.99 to $5.99 (394 apps), and $6.99 to $7.99 (166 apps)
3. **Higher Price Ranges ($10 and above)**: As the price increases, the number of apps decreases. There are still apps available in higher price ranges, but their numbers are significantly lower
4. **Observations on Specific Price Ranges**: There is a drop in the number of apps in the $7.99 to $9.99 range (33 apps), and there are fewer apps as the prices exceed $10, with the numbers decreasing even more steeply beyond $20
5. **Pricing Peaks**: Some specific price points, such as $9.99 (81 apps), $14.99 (21 apps), and $19.99 (13 apps), have a higher number of apps, suggesting that developers might find these price points attractive for certain types of applications
6. **Premium Pricing**: There are a few apps priced significantly higher, with prices like $74.99, $99.99, $249.99, and $299.99, each having only one app. These are likely premium or specialized applications.

Output:
| price_bin_start | price_bin_end | num_apps |
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
       END as app_type,
       AVG(user_rating) as avg_rating
FROM AppleStore
GROUP BY app_type;
```
1. **Paid apps have higher average rating**: Paid apps have an average rating of 3.72, while free apps have an average rating of 3.38
2. **Potential reasons**: There are several possible reasons for this difference. Paid apps may be of higher quality on average, or users may be more likely to rate paid apps that they have purchased.

Output:
| app_type | avg_rating              |
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
       AVG(user_rating) as avg_rating
FROM AppleStore
GROUP BY language_bucket
ORDER BY avg_rating DESC;
```
1. **Apps with 10-30 languages have the highest average rating (4.13), followed by apps with less than 10 languages (3.37), and then apps with more than 30 languages (3.78)**. This suggests that there may be a sweet spot for the number of languages an app should support in order to maximize its average rating
2. **Apps with more languages don't necessarily have higher ratings**. This could be because apps with more languages tend to cater to a wider audience, which could lead to a lower average rating as there is a greater chance of including users who are not satisfied with the app
3. **Potential for further analysis**: It would be interesting to investigate the reasons behind these differences in average rating. For example, are there specific language groups that tend to have higher or lower ratings? Do apps with more languages tend to be more complex, which could lead to lower ratings?

Output:
| language_bucket    | avg_rating            |
|-------------------- |-----------------------|
| 10-30 Languages    | 4.1305120910384066   |
| >30 Languages      | 3.7777777777777777   |
| <10 Languages      | 3.368327402135231    |

### Genres with Low Ratings
Identify genres with low average ratings in the `AppleStore` table.

```sql
SELECT prime_genre, AVG(user_rating) as avg_rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY avg_rating DESC
LIMIT 10;
```
1. **Top rated genre**: Productivity has the highest average rating with 4.0056
2. **Distribution**: Average rating varies across genres, with Productivity standing out
3. **Lower rated genres**: Some genres have lower average ratings, like Travel with 3.3765
4. **Potential for further analysis**: This data could be used to analyze user preferences for app quality across genres, investigate factors influencing ratings, and identify genres with potential for improvement.

Output:
| prime_genre        | avg_rating           |
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
       AVG(a.user_rating) as avg_rating
FROM AppleStore as a
JOIN appleStore_description_combined as b ON a.id = b.id
GROUP BY description_length_bucket
ORDER BY avg_rating DESC;
```
1. **Apps with longer descriptions have higher average ratings**. This could be because longer descriptions provide more information for users to base their ratings on, or because they are written by developers who are more invested in their apps
2. **There is a potential for further analysis**. It would be interesting to investigate the relationship between description length and rating in more detail. For example, you could look at whether this trend is more pronounced in certain genres, or whether longer descriptions simply provide more information for users to base their ratings on.


Output:
| description_length_bucket | avg_rating         |
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
1. **User Ratings: All Highly Rated Apps**. Every app listed has a user rating of 5, indicating a high level of user satisfaction across diverse genres, This suggests that users are generally finding apps that meet their needs and expectations.
2. **Variety of Genres Represented**: The output includes apps from 20 different genres, showcasing a wide range of interests and needs being met, This demonstrates the breadth of the app market and the potential to cater to diverse user preferences.
3. **Specific App Highlights**: Popular and Practical Apps: Productivity apps (VPN Proxy Master), financial apps (Credit Karma), and health and fitness apps (Yoga Studio) are among the highly rated options, suggesting their practical value to users, Entertainment and Lifestyle: Entertainment apps (Bruh-Button, Head Soccer) and lifestyle apps (ipsy, We Heart It) also have high ratings, reflecting their ability to engage and connect with users, Niche Categories: Even niche genres like Catalogs (CPlus for Craigslist) and Medical (Blink Health) have top-rated apps, indicating opportunities for success in specialized areas.

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

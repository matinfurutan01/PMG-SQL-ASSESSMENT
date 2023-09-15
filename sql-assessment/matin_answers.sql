#Query 1: Get the sum of impressions by day
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY date
ORDER BY date;

#Query 2: Get the top three revenue-generating states
SELECT state, SUM(revenue) AS state_revenue
FROM website_revenue
GROUP BY state
ORDER BY state_revenue DESC
LIMIT 3;

#The third best state was GA and generated 37577 in revenue.

#Query 3: Show total cost, impressions, clicks, and revenue of each campaign
SELECT name, SUM(cost) AS total_cost, SUM(impressions) AS total_impressions, SUM(clicks) AS total_clicks, SUM(revenue) AS total_revenue
FROM marketing_data LEFT JOIN website_revenue USING (campaign_id) JOIN campaign_info ON website_revenue.campaign_id = campaign_info.id
GROUP BY campaign_id
ORDER BY name;

#Query 4: Number of conversions of Campaign5 by state
SELECT state, SUM(conversions) AS state_conversions
FROM marketing_data LEFT JOIN website_revenue USING (campaign_id) JOIN campaign_info ON website_revenue.campaign_id = campaign_info.id
WHERE name = 'Campaign5'
GROUP BY state
ORDER BY state_conversions DESC;

# GA (georgia) generated the most conversions for Campaign5.

#Query 5: Most Efficient Campaign
SELECT name, SUM(cost) / SUM(conversions)  AS cost_per_conversion, SUM(revenue) / SUM(impressions) AS revenue_per_impression
FROM marketing_data LEFT JOIN website_revenue USING (campaign_id) JOIN campaign_info ON website_revenue.campaign_id = campaign_info.id
GROUP BY name
ORDER BY cost_per_conversion, revenue_per_impression DESC;

/* 
Depending on what metric we value the most our answer can vary on what we feel is the most efficient campaign, however, 
although the cost_per_conversion is highest in Campaign5 by 0.1, the revenue_per_impression is significantly better than
the other campaigns by a margin of 1.9. Given this, I believe Campaign5 is our most efficent campaign.
*/

#Bonus Query -- best days of week to run ads
SELECT DAYNAME(date) as Day_of_week, SUM(cost) / SUM(conversions) AS cost_per_conversion, SUM(conversions) as total_daily_conversions
FROM marketing_data
GROUP BY Day_of_week
ORDER BY cost_per_conversion;

/* Using cost_per_conversion and total_daily_conversions as our driving metric we find that Friday seems like
 the best day to run ads as it has the second lowest cost_per_conversion but significantly more total_daily_conversions *\







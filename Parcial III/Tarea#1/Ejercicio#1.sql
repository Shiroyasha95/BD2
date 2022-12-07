SELECT 
  name
  ,gender
  ,SUM(number) as sum_number
FROM `bigquery-public-data.usa_names.usa_1910_2013` 
GROUP BY name,gender
ORDER BY name DESC

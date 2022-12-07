SELECT 
  date
  ,state
  ,SUM(tests_total) as total_tests
  ,SUM(cases_positive_total) as total_casos_positivos
  ,SUM(tests_total)-SUM(tests_pending) as tests_realizados
FROM `bigquery-public-data.covid19_covidtracking.summary` 
GROUP BY date,state

WITH sales as (
  select
  Region
  ,Country
  ,SUM(Total_Revenue) as ventas_totales
  FROM `steel-utility-370701.Ejercicio4.sales_records`
  GROUP BY region, country
)
select 
  Region
  ,country
  ,ventas_totales
  ,RANK() OVER (PARTITION BY Region ORDER BY sales.ventas_totales DESC) AS rank
from sales 

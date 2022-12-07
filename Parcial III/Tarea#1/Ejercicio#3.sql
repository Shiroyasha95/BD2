WITH pageviews_total as (
  select
  date,
  SUM(totals.pageviews) as total_global
  ,COUNT(DISTINCT channelGrouping) as total_channels
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
  GROUP BY date
), pageviews as (
  select
  date
  ,channelGrouping
  ,SUM(totals.pageviews) as total_page_views
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
  GROUP BY date,channelGrouping
)
select 
  pv.date
  ,pv.channelGrouping
  ,pv.total_page_views
  ,pv.total_page_views/total.total_global as page_views_percent
  ,total.total_global/total.total_channels as avg_page_views
from pageviews as pv
left join pageviews_total as total on total.date = total.date

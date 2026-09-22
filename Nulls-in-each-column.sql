-- Count of nulls in each column

--SQL

select 
sum(case 
		when (coalesce(event_id,'') = '') then 1 
		else 0 end
  ) as event_id_null,
sum(case when coalesce(device_id,'') = '' then 1 else 0 end) as device_id_null,
sum(case when coalesce(temperature,'') = 0 then 1 else 0 end) as temperature_null,
sum(case when coalesce(humidity,'') = 0 then 1 else 0 end) as humidity_null,
sum(case when coalesce(Station_Code,'') = '' then 1 else 0 end) as Station_Code_null
from landing_zone

#python

from pyspark.sql.functions import col, sum, when

dfDevice.select(
    *[
        sum(when(col(c).isNull(), 1).otherwise(0)).alias(c)
        for c in dfDevice.columns
    ]
).show()

dfDevice.select(
    [
        sum(when(col(c).isNull(), 1).otherwise(0)).alias(c)
        for c in dfDevice.columns
    ]
).show()

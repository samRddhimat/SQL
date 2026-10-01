1. Find the total number of flights for each month.
select count(flightid), trip_month from (select distinct flightid, month(cast(jdate as date)) trip_month from iceberg.fda.flightdata group by flightid, month(cast(jdate as date)) ) x group by trip_month order by 2;
or 
select count(flightid), trip_month from (select distinct flightid, month(cast(jdate as date)) trip_month from iceberg.fda.flightdata group by flightid, month(cast(jdate as date)) ) x group by trip_month order by 2;



%spark.pyspark

from pyspark.sql.functions import sum, count, month, to_date, countDistinct
# from pyspark.sql.column import cast

dffda = spark.table("iceberg.fda.flightdata")

dffda \
.withColumn("jdate", to_date("jdate","yyyy-MM-dd")) \
.groupBy(month("jdate").alias("trip_month")) \
.agg(countDistinct("flightid").alias("total_flights")) \
.orderBy("trip_month") \
.show()


2.

SELECT
    ROW_NUMBER() OVER (ORDER BY x.trips DESC, x.passengerid)  AS sno,
    x.passengerid,
    x.trips as "number of flights", p.firstname, p.lastname
FROM (
    SELECT
        passengerid,
        COUNT(*) AS trips
    FROM iceberg.fda.flightdata
    GROUP BY passengerid
    HAVING COUNT(*) > 1
) x
inner join iceberg.fda.passengers p on p.passengerid = x.passengerid 
ORDER BY x.trips DESC, x.passengerid
LIMIT 100;


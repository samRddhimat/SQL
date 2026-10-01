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

3.



4. passengers who have been on more than 3 flights together.

SELECT
    a.passengerid AS passenger1,
    b.passengerid AS passenger2,
    COUNT(*) AS flights_together
FROM flightdata a
JOIN flightdata b
    ON a.flightid = b.flightid
   AND a.jdate = b.jdate
   AND a.passengerid < b.passengerid
GROUP BY
    a.passengerid,
    b.passengerid
HAVING COUNT(*) > 3
ORDER BY flights_together DESC;

4.a. array_agg - with destinations.

WITH pairs AS (
	 SELECT
		 a.passengerid AS passenger1,
		 b.passengerid AS passenger2,
		 a.flightid,
		 a.jdate,
		 a.dfrom,
		 a.dto
	 FROM iceberg.fda.flightdata a
	 JOIN iceberg.fda.flightdata b
		 ON a.flightid = b.flightid
		AND a.jdate = b.jdate
		AND a.passengerid < b.passengerid        
   --and cast(a.jdate as date) >= cast('2017-07-08' as date) --and cast(a.jdate as date) <= cast('2017-07-10' as date)
 ),
 pair_counts AS (
	 SELECT
		 passenger1,
		 passenger2,
		 COUNT(*) AS flights_together,
		 array_agg(
			 DISTINCT dfrom || '  ' || dto
		 ) AS routes
	 FROM pairs
	 GROUP BY passenger1, passenger2
 )
 SELECT *
 FROM pair_counts
 WHERE flights_together > 3
 ORDER BY flights_together DESC;
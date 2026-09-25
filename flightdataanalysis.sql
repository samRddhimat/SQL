1. Find the total number of flights for each month.
select count(flightid), trip_month from (select distinct flightid, month(cast(jdate as date)) trip_month from iceberg.fda.flightdata group by flightid, month(cast(jdate as date)) ) x group by trip_month order by 2;
or 
select count(flightid), trip_month from (select distinct flightid, month(cast(jdate as date)) trip_month from iceberg.fda.flightdata group by flightid, month(cast(jdate as date)) ) x group by trip_month order by 2;


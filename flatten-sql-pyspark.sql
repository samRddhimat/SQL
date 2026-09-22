
#pyspark

dfeskills = spark.table("iceberg.my_db.users")
dfeskills.select("id", "name", explode("skills").alias("skill")).show()

--sql

select *, skill from  iceberg.my_db.users cross join unnest(skills) as ut(skill) order by id;
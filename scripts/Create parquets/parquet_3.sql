-- Создание таблицы parquet_3, в которой хранятся все результаты для группы пассажиров, где кол-во = 3
CREATE TABLE IF NOT EXISTS parquet_3 AS 
WITH pas_3 AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count = 3
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
-- Создается обобщенное табличное выражение и результаты запроса хранятся под именем parquet3
	parquet3 AS
(
	SELECT DATE("data".tpep_pickup_datetime) as date,
		   CAST((COUNT(pas_3.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_3p,
		   CASE WHEN MAX(pas_3.total_amount) IS NULL THEN 0 ELSE MAX(pas_3.total_amount) END "max(trip)",
		   CASE WHEN MIN(pas_3.total_amount) IS NULL THEN 0 ELSE MIN(pas_3.total_amount) END "min(trip)"
	FROM "data"
	LEFT JOIN pas_3 ON "data".id = pas_3.id
	GROUP BY date
) 
SELECT *
FROM parquet3
ORDER BY date;

-- Сохранение результата parquet_3 в csv файл
COPY (select * from parquet_3) to 'D://Coursers of programming 2022/Software Engineer 2022/Project-Taxi/results/parquet_3.csv'
WITH DELIMITER ',' CSV HEADER;

SELECT *
FROM parquet_3
ORDER BY date;
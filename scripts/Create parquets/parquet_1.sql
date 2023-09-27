-- Создание таблицы parquet_1, в которой хранятся все результаты для группы пассажиров, где кол-во = 1
CREATE TABLE IF NOT EXISTS parquet_1 AS 
WITH pas_1 AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count = 1
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
-- Создается обобщенное табличное выражение и результаты запроса хранятся под именем parquet1
	parquet1 AS
(
	SELECT DATE("data".tpep_pickup_datetime) as date,
		   CAST((COUNT(pas_1.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_1p,
		   CASE WHEN MAX(pas_1.total_amount) IS NULL THEN 0 ELSE MAX(pas_1.total_amount) END "max(trip)",
		   CASE WHEN MIN(pas_1.total_amount) IS NULL THEN 0 ELSE MIN(pas_1.total_amount) END "min(trip)"
	FROM "data"
	LEFT JOIN pas_1 ON "data".id = pas_1.id
	GROUP BY date
) 
SELECT *
FROM parquet1
ORDER BY date;

-- Сохранение результата parquet_1 в csv файл
COPY (select * from parquet_1) to 'D://Coursers of programming 2022/Software Engineer 2022/Project-Taxi/results/parquet_1.csv'
WITH DELIMITER ',' CSV HEADER;

SELECT *
FROM parquet_1
ORDER BY date;
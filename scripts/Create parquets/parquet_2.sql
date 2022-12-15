-- Создание таблицы parquet_2, в которой хранятся все результаты для группы пассажиров, где кол-во = 2
CREATE TABLE IF NOT EXISTS parquet_2 AS 
WITH pas_2 AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count = 2
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
-- Создается обобщенное табличное выражение и результаты запроса хранятся под именем parquet2
	parquet2 AS
(
	SELECT DATE("data".tpep_pickup_datetime) as date,
		   CAST((COUNT(pas_2.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_2p,
		   CASE WHEN MAX(pas_2.total_amount) IS NULL THEN 0 ELSE MAX(pas_2.total_amount) END "max(trip)",
		   CASE WHEN MIN(pas_2.total_amount) IS NULL THEN 0 ELSE MIN(pas_2.total_amount) END "min(trip)"
	FROM "data"
	LEFT JOIN pas_2 ON "data".id = pas_2.id
	GROUP BY date
) 
SELECT *
FROM parquet2
ORDER BY date;

-- Сохранение результата parquet_2 в csv файл
COPY (select * from parquet_2) to 'D://Coursers of programming 2022/Software Engineer 2022/Project-Taxi/results/parquet_2.csv'
WITH DELIMITER ',' CSV HEADER;

SELECT *
FROM parquet_2
ORDER BY date;
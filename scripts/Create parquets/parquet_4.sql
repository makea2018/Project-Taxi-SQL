-- Создание таблицы parquet_4, в которой хранятся все результаты для группы пассажиров, где кол-во >= 4
CREATE TABLE IF NOT EXISTS parquet_4 AS 
WITH pas_4_plus AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count >= 4
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
-- Создается обобщенное табличное выражение и результаты запроса хранятся под именем parquet4_plus
	parquet4_plus AS
(
	SELECT DATE("data".tpep_pickup_datetime) as date,
		   CAST((COUNT(pas_4_plus.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_4p_plus,
		   CASE WHEN MAX(pas_4_plus.total_amount) IS NULL THEN 0 ELSE MAX(pas_4_plus.total_amount) END "max(trip)",
		   CASE WHEN MIN(pas_4_plus.total_amount) IS NULL THEN 0 ELSE MIN(pas_4_plus.total_amount) END "min(trip)"
	FROM "data"
	LEFT JOIN pas_4_plus ON "data".id = pas_4_plus.id
	GROUP BY date
) 
SELECT *
FROM parquet4_plus
ORDER BY date;

-- Сохранение результата parquet_4 в csv файл
COPY (select * from parquet_4) to 'D://Coursers of programming 2022/Software Engineer 2022/Project-Taxi/results/parquet_4.csv'
WITH DELIMITER ',' CSV HEADER;

SELECT *
FROM parquet_4
ORDER BY date;
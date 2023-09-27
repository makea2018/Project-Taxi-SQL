-- Создание таблицы full_parquet, в которой хранятся все результаты для всех групп пассажиров
CREATE TABLE IF NOT EXISTS full_parquet AS 
WITH pas_1 AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count = 1
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
	pas_2 AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count = 2
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
	pas_3 AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count = 3
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
	pas_4_plus AS
(
	SELECT *
	FROM "data"
	WHERE passenger_count >= 4
	AND DATE(tpep_pickup_datetime) = DATE(tpep_dropoff_datetime)
)
,
-- Создается обобщенное табличное выражение и все результаты запроса хранятся под именем parquet
	parquet AS
(
	SELECT DATE("data".tpep_pickup_datetime) as date,
-- 		   1 Пассажир
		   CAST((COUNT(pas_1.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_1p,
		   CASE WHEN MAX(pas_1.total_amount) IS NULL THEN 0 ELSE MAX(pas_1.total_amount) END "max(trip)_1p",
		   CASE WHEN MIN(pas_1.total_amount) IS NULL THEN 0 ELSE MIN(pas_1.total_amount) END "min(trip)_1p",
-- 		   ---------------------------------------
-- 		   2 Пассажира
		   CAST((COUNT(pas_2.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_2p,
		   CASE WHEN MAX(pas_2.total_amount) IS NULL THEN 0 ELSE MAX(pas_2.total_amount) END "max(trip)_2p",
		   CASE WHEN MIN(pas_2.total_amount) IS NULL THEN 0 ELSE MIN(pas_2.total_amount) END "min(trip)_2p",
-- 		   ---------------------------------------
-- 		   3 Пассажира
		   CAST((COUNT(pas_3.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_3p,
		   CASE WHEN MAX(pas_3.total_amount) IS NULL THEN 0 ELSE MAX(pas_3.total_amount) END "max(trip)_3p",
		   CASE WHEN MIN(pas_3.total_amount) IS NULL THEN 0 ELSE MIN(pas_3.total_amount) END "min(trip)_3p",
-- 		   ---------------------------------------
-- 		   4 Пассажира
		   CAST((COUNT(pas_4_plus.*)::FLOAT / COUNT(*)::FLOAT * 100.0) AS FLOAT) AS percentage_4p_plus,
		   CASE WHEN MAX(pas_4_plus.total_amount) IS NULL THEN 0 ELSE MAX(pas_4_plus.total_amount) END "max(trip)_4p_plus",
		   CASE WHEN MIN(pas_4_plus.total_amount) IS NULL THEN 0 ELSE MIN(pas_4_plus.total_amount) END "min(trip)_4p_plus"
	
	FROM "data"
	LEFT JOIN pas_1 ON "data".id = pas_1.id
	LEFT JOIN pas_2 ON "data".id = pas_2.id
	LEFT JOIN pas_3 ON "data".id = pas_3.id
	LEFT JOIN pas_4_plus ON "data".id = pas_4_plus.id
	GROUP BY date
) 

SELECT *
FROM parquet
ORDER BY date;

-- ----------------------------------------
-- Сохранение результата parquet в csv файл
COPY (select * from full_parquet) to 'D://Coursers of programming 2022/Software Engineer 2022/Project-Taxi/results/full_parquet.csv'
WITH DELIMITER ',' CSV HEADER;

SELECT *
FROM full_parquet
ORDER BY date;
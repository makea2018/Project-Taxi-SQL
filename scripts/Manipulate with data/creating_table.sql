-- Создается таблица в sql, в которой все названия столбцов = названиям столбцов .csv файла
CREATE TABLE IF NOT EXISTS "data"
(
	VendorID NUMERIC(2,1),
	tpep_pickup_datetime TIMESTAMP,
	tpep_dropoff_datetime TIMESTAMP,
	passenger_count NUMERIC(3,1),
	trip_distance NUMERIC(8,2),
	RatecodeID NUMERIC(3,1),
	store_and_fwd_flag VARCHAR(2),
	PULocationID INTEGER,
	DOLocationID INTEGER,
	payment_type NUMERIC(2,1),
	fare_amount NUMERIC(6,2),
	extra NUMERIC(6,2),
	mta_tax NUMERIC(6,2),
	tip_amount NUMERIC(6,2),
	tolls_amount NUMERIC(6,2),
	improvement_surcharge NUMERIC(6,2),
	total_amount NUMERIC(6,2),
	congestion_surcharge NUMERIC(6,2)
);
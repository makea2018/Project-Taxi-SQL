-- Скрипт для импорта данных в таблицу с csv формата
COPY "data"
-- Путь до файла .csv, откуда импортирую данные
FROM 'D://Coursers of programming 2022/Software Engineer 2022/data csv/yellow_tripdata_2020-01.csv'
DELIMITER ','
CSV HEADER;
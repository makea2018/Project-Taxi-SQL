-- Скрипт для обработки данных, по которым требуется построить паркетники

-- Скрипт для удаления всех null-строк из данных
-- Обоснование для удаления строк находится в файле "delete_null_rows.sql"
DELETE FROM "data"
WHERE vendorid IS NULL
OR passenger_count IS NULL
OR ratecodeID IS NULL
OR store_and_fwd_flag IS NULL
OR payment_type IS NULL;

-- Добавляется колонка id типа "SERIAL" в таблицу с данными, по которым строятся паркетники
ALTER TABLE IF EXISTS "data"
ADD column IF NOT EXISTS id SERIAL;

-- Меняется тип "NUMERIC" на "INTEGER", где необходимо
ALTER TABLE IF EXISTS "data"
ALTER COLUMN vendorid TYPE INTEGER USING vendorid::INTEGER,
ALTER COLUMN passenger_count TYPE INTEGER USING passenger_count::INTEGER,
ALTER COLUMN ratecodeid TYPE INTEGER USING ratecodeid::INTEGER;


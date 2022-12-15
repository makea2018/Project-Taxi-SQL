-- Для лучшего отображения процентов меняется тип "DOUBLE PRECISION" на "NUMERIC(4, 1)"
-- Для всех паркетников, если существуют

-- Паркетник_1
ALTER TABLE IF EXISTS parquet_1
ALTER COLUMN percentage_1p TYPE DOUBLE PRECISION USING percentage_1p::NUMERIC(4, 1);

-- Паркетник_2
ALTER TABLE IF EXISTS parquet_2
ALTER COLUMN percentage_2p TYPE DOUBLE PRECISION USING percentage_2p::NUMERIC(4, 1);

-- Паркетник_3
ALTER TABLE IF EXISTS parquet_3
ALTER COLUMN percentage_3p TYPE DOUBLE PRECISION USING percentage_3p::NUMERIC(4, 1);

-- Паркетник_4
ALTER TABLE IF EXISTS parquet_4
ALTER COLUMN percentage_4p_plus TYPE DOUBLE PRECISION USING percentage_4p_plus::NUMERIC(4, 1);

-- Полный паркетник
ALTER TABLE IF EXISTS full_parquet
ALTER COLUMN percentage_1p TYPE DOUBLE PRECISION USING percentage_1p::NUMERIC(4, 1),
ALTER COLUMN percentage_2p TYPE DOUBLE PRECISION USING percentage_2p::NUMERIC(4, 1),
ALTER COLUMN percentage_3p TYPE DOUBLE PRECISION USING percentage_3p::NUMERIC(4, 1),
ALTER COLUMN percentage_4p_plus TYPE DOUBLE PRECISION USING percentage_4p_plus::NUMERIC(4, 1);
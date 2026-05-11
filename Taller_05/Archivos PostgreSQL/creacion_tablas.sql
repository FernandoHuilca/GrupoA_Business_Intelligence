-- Creación de tablas en la base de datos

-- Tabla raw_desnutrition_infantil
CREATE TABLE raw_desnutricion_infantil (
    child_id VARCHAR(10),
    gender CHAR(1),
    age_months INT,
    weight_kg NUMERIC(10,2),
    height_cm NUMERIC(10,2),
    nutritional_status VARCHAR(10),
    region VARCHAR(20),
    institution VARCHAR(20),
    date_measured DATE
);

-- Tabla dim_child
CREATE TABLE dim_child (
	child_key SERIAL PRIMARY KEY,
	child_id VARCHAR(10),
	gender CHAR(1)
);

-- Tabla dim_status
CREATE TABLE dim_status(
	status_key SERIAL PRIMARY KEY,
	nutritional_status VARCHAR(10)
);

-- Tabla de dim_location
CREATE TABLE dim_location (
	location_key SERIAL PRIMARY KEY,
	region VARCHAR(50),
	institution VARCHAR(100)
);


-- Tabla fact_desnutricion
create table fact_desnutricion (
  	record_key SERIAL PRIMARY KEY,
  	child_key int,
  	status_key int,
  	location_key int,
  	date_key date,
	age_months int,
	weight_kg numeric(10,2),
	height_cm numeric(10,2)
)






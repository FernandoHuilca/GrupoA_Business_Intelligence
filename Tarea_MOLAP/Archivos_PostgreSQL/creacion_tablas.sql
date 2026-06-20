-- Creación de tablas en la base de datos

-- Tabla raw_salud
CREATE TABLE raw_salud (
    visit_id INT,
    visit_date DATE,
    patient_id INT,
    patient_age INT,
    patient_gender VARCHAR(1),
    city VARCHAR(50),
    hospital_department VARCHAR(50),
    doctor_id INT,
    specialty VARCHAR(50),
    diagnostic_group VARCHAR(50),
    procedure_type VARCHAR(50),
    insurance_type VARCHAR(30),
    is_emergency INT,
    length_of_stay_days INT,
    cost_medicine NUMERIC(10,2),
    cost_procedure NUMERIC(10,2),
    total_cost NUMERIC(10,2),
    outcome VARCHAR(30)
);

-- Creación de la tabla: dim_fecha
CREATE TABLE dim_fecha (
    fecha_key DATE PRIMARY KEY,
    anio INT,
    mes INT,
    dia INT
);

-- Creación de la tabla: dim_paciente
CREATE TABLE dim_paciente (
	paciente_key SERIAL PRIMARY KEY,
	patient_id INT,
	patient_age INT,
	patient_gender VARCHAR(1)
);

-- Creación de la tabla: dim_departamento_hospital
CREATE TABLE dim_departamento_hospital (
    departamento_key SERIAL PRIMARY KEY,
    city VARCHAR(50),
    hospital_department VARCHAR(50)
);

--Creación de la tabla: dim_doctor
CREATE TABLE dim_doctor (
	doctor_key SERIAL PRIMARY KEY,
	doctor_id INT,
	specialty VARCHAR(150)
);

-- Creación de la tabla: dim_diagnostico
CREATE TABLE dim_diagnostico (
    diagnostico_key SERIAL PRIMARY KEY,
    diagnosis_group VARCHAR(50)
);

-- Creación de la tabla: dim_procedimiento
CREATE TABLE dim_procedimiento (
    procedimiento_key SERIAL PRIMARY KEY,
    procedure_type VARCHAR(50)
);

-- Creación de la tabla: dim_tipo_seguro
CREATE TABLE dim_tipo_seguro (
    tipo_seguro_key SERIAL PRIMARY KEY,
    insurance_type VARCHAR(30)
);

-- Creación de la tabla: dim_resultado
CREATE TABLE dim_resultado (
    resultado_key SERIAL PRIMARY KEY,
    outcome VARCHAR(30)
);

-- Creación de la tabla: fact_atencion_medica
CREATE TABLE fact_atencion_medica (
	atencion_medica_key SERIAL PRIMARY KEY,
	visit_id INT,
	
	-- metricas
	is_emergency INT,
	length_of_stay_days INT,
	cost_medicine NUMERIC(10,2),
	cost_procedure NUMERIC(10,2),
	total_cost NUMERIC(10,2),

	-- claves foraneas
	fecha_key DATE NOT NULL REFERENCES dim_fecha(fecha_key),
	paciente_key INT NOT NULL REFERENCES dim_paciente(paciente_key),
	departamento_key INT NOT NULL REFERENCES dim_departamento_hospital(departamento_key),
	doctor_key INT NOT NULL REFERENCES dim_doctor(doctor_key),
	diagnostico_key INT NOT NULL REFERENCES dim_diagnostico(diagnostico_key),
	procedimiento_key INT NOT NULL REFERENCES dim_procedimiento(procedimiento_key),
	tipo_seguro_key INT NOT NULL REFERENCES dim_tipo_seguro(tipo_seguro_key),
	resultado_key INT NOT NULL REFERENCES dim_resultado(resultado_key)
);

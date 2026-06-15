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
    diagnosis_group VARCHAR(50),
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


-- Creación de la tabla: dim_paciente


-- Creación de la tabla: dim_departamento_hospital


--Creación de la tabla: dim_medico


-- Creación de la tabla: dim_diagnostico


-- Creación de la tabla: dim_procedimiento


-- Creación de la tabla: dim_tipo_seguro


-- Creación de la tabla: dim_resultado
CREATE TABLE dim_resultado {
    resultado_key serial primary key,
    outcome VARCHAR(30)
};

-- Creación de la tabla: fact_atencion_medica

-- Vista materializada
CREATE MATERIALIZED VIEW mv_atenciones_medicas AS
SELECT
    fam.visit_id,
    df.anio AS "año",
    df.mes,
    df.dia,
    dp.patient_age AS "edad_paciente",
    dp.patient_gender AS "genero_paciente",
    ddh.city AS "ciudad",
    ddh.hospital_department AS "departamento_hospital",
    dm.doctor_id AS "doctor_id",
    dm.specialty AS "especialidad",
    dd.diagnosis_group AS "diagnostico",
    dpr.procedure_type AS "procedimiento",
    dts.insurance_type AS "tipo_seguro",
    fam.is_emergency AS "es_emergencia",
    fam.length_of_stay_days AS "dias_estancia",
    fam.cost_medicine AS "costo_medicina",
    fam.cost_procedure AS "costo_procedimiento",
    fam.total_cost AS "costo_total",
    dr.outcome AS "resultado"
FROM fact_atencion_medica fam
JOIN dim_fecha df 
ON fam.fecha_key = df.fecha_key
JOIN dim_paciente dp 
ON fam.paciente_key = dp.paciente_key
JOIN dim_departamento_hospital ddh 
ON fam.departamento_key = ddh.departamento_key
JOIN dim_doctor dm 
ON fam.doctor_key = dm.doctor_key
JOIN dim_diagnostico dd 
ON fam.diagnostico_key = dd.diagnostico_key
JOIN dim_procedimiento dpr 
ON fam.procedimiento_key = dpr.procedimiento_key
JOIN dim_tipo_seguro dts 
ON fam.tipo_seguro_key = dts.tipo_seguro_key
JOIN dim_resultado dr 
ON fam.resultado_key = dr.resultado_key;
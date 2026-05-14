-- Consultas SQL ocupadas para responder a las preguntas

-- 1. ¿Cuál es el tipo de desnutrición más común por región?
SELECT dim_location.region, dim_status.nutritional_status, COUNT(*) AS total_casos
FROM fact_measurement
JOIN dim_status
ON fact_measurement.status_key = dim_status.status_key
JOIN dim_location
ON fact_measurement.location_key = dim_location.location_key
GROUP BY dim_location.region, dim_status.nutritional_status
ORDER BY dim_location.region, total_casos DESC;

-- 2. ¿Cómo varía la desnutrición por edad y género?
SELECT fm.age_months, dc.gender, ds.nutritional_status, COUNT(*) AS total_cases
FROM fact_measurement fm
JOIN dim_status ds
ON fm.status_key = ds.status_key
JOIN dim_child dc
ON fm.child_key = dc.child_key
GROUP BY fm.age_months, dc.gender, ds.nutritional_status
ORDER BY fm.age_months, dc.gender, total_cases;

-- 3. ¿Qué instituciones atienden más casos?
SELECT dl.institution, COUNT(*) AS total_cases
FROM fact_measurement fm
JOIN dim_location dl
ON fm.location_key = dl.location_key
GROUP BY dl.institution
ORDER BY total_cases DESC;










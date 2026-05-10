-- Consultas SQL ocupadas para responder a las preguntas

-- 2. ¿Cómo varía la desnutrición por edad y género?
SELECT dc.age_months, dc.gender, ds.nutritional_status, COUNT(*) AS total_cases
FROM fact_measurement fm
JOIN dim_status ds
ON fm.status_key = ds.status_key
JOIN dim_child dc
ON fm.child_key = dc.child_key
GROUP BY dc.age_months, dc.gender, ds.nutritional_status
ORDER BY dc.age_months, dc.gender, total_cases;











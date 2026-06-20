-- 1. ¿Cuál es el costo total de atención por especialidad,ciudad y mes?
SELECT especialidad, ciudad, mes, SUM(costo_total) as costo_total
FROM mv_atenciones_medicas
GROUP BY especialidad, ciudad, mes
ORDER BY especialidad, ciudad, mes;

-- 2. ¿Qué ciudad tuvo más emergencias por mes y género?
WITH ranking_emergencias AS (
    SELECT
        mes,
        genero_paciente,
        ciudad,
        COUNT(*) AS total_emergencias,
        ROW_NUMBER() OVER (
            PARTITION BY mes, genero_paciente
            ORDER BY COUNT(*) DESC
        ) AS ranking
    FROM mv_atenciones_medicas
    WHERE es_emergencia = 1
    GROUP BY
        mes,
        genero_paciente,
        ciudad
)
SELECT
    mes,
    genero_paciente,
    ciudad,
    total_emergencias
FROM ranking_emergencias
WHERE ranking = 1
ORDER BY
    total_emergencias DESC;

-- 3. ¿Por diagnóstico, tipo de seguro, cuál es el costo promedio por visita y en qué ciudad es más alto?
SELECT diagnostico, tipo_seguro, ciudad, ROUND(AVG(costo_total), 2) AS costo_promedio
FROM mv_atenciones_medicas
GROUP BY diagnostico, tipo_seguro, ciudad
ORDER BY diagnostico, tipo_seguro, costo_promedio DESC;
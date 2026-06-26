# <center>**Escuela Politécnica Nacional**</center>
## <center>**Bussiness Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña
### **Paralelo:**
GR2SW
### **Fecha de entrega:**
30 de junio de 2026

------------
## **Índice de Contenidos**

[MOLAP](#molap)

[1. Proceso ETL](#1-proceso-etl)
* [1.1. Creación de la tabla "raw_salud"](#11-creación-de-la-tabla-raw_salud)
* [1.2. Transformación y carga de datos](#12-transformación-y-carga-de-datos)
  * [1.2.1. dim_fecha](#121-dim_fecha)
  * [1.2.2. dim_paciente](#122-dim_paciente)
  * [1.2.3. dim_departamento_hospital](#123-dim_departamento_hospital)
  * [1.2.4. dim_doctor](#124-dim_doctor)
  * [1.2.5. dim_diagnostico](#125-dim_diagnostico)
  * [1.2.6. dim_procedimiento](#126-dim_procedimiento)
  * [1.2.7. dim_tipo_seguro](#127-dim_tipo_seguro)
  * [1.2.8. dim_resultado](#128-dim_resultado)
  * [1.2.9. fact_atencion_medica](#129-fact_atencion_medica)

[2. Modelo estrella](#2-modelo-estrella)

[3. MOLAP: vista materializada](#3-molap-vista-materializada)

[Consultas MOLAP](#consultas-molap)
* [1. ¿Cuál es el costo total de atención por especialidad, ciudad y mes?](#1-cuál-es-el-costo-total-de-atención-por-especialidad-ciudad-y-mes)
* [2. ¿Qué ciudad tuvo más emergencias por mes y género?](#2-qué-ciudad-tuvo-más-emergencias-por-mes-y-género)
* [3. ¿Por diagnóstico, tipo de seguro, cuál es el costo promedio por visita y en qué ciudad es más alto?](#3-por-diagnóstico-tipo-de-seguro-cuál-es-el-costo-promedio-por-visita-y-en-qué-ciudad-es-más-alto)

[Referencias bibliográficas](#referencias-bibliográficas)  

[Declaración de porcentaje de uso de IA](#declaración-de-porcentaje-de-uso-de-ia)

------------
# <center>**Naive Bayes y Predecir valores**</center>
---

## 1. Naive Bayes



## 2. Predecir valores



## 3. Referencias bibliográficas

[1] P. Bhatia, Data Mining and Data Warehousing: Principles and Practical Techniques. Cambridge, U.K.: Cambridge University Press, 2019. doi: 10.1017/9781108635592.

## 4. Declaración de porcentaje de uso de IA

**ChatGPT:**
* Se utilizó como apoyo en el diseño del modelo estrella, principalmente para revisar en qué tabla debían ubicarse campos como "cost_medicine", "cost_procedure" e "is_emergency", y justificar si correspondían a la tabla de hechos o a una dimensión.
* Se utilizó como apoyo para la elaboración de sentencias SQL grandes, como la creación de la tabla `raw_salud` y de la vista materializada.
* Se usó para analizar un error en Pentaho durante la transformación "carga_raw_salud", relacionado con el mapeo de la columna "visit_id" del archivo CSV hacia la tabla creada en PostgreSQL, debido a un carácter invisible en el encabezado.
* Se utilizó para estructurar la consulta SQL correspondiente a la segunda pregunta analítica (**¿Qué ciudad tuvo más emergencias por mes y género?**), empleando funciones analíticas como `ROW_NUMBER()` para obtener la ciudad con el mayor número de emergencias en cada combinación de mes y género.

**Claude:**
* Se utilizó como apoyo para revisar mejores maneras de plantear las sentencias SQL utilizadas para responder las preguntas planteadas.
* Se utilizó para recordar el funcionamiento de algunos componentes de Pentaho, como Stream lookup.

# <center>**Escuela Politécnica Nacional**</center>
## <center>**Business Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña
### **Paralelo:**
GR2SW
### **Fecha de entrega:**
16 de junio de 2026

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
# <center>**Tarea MOLAP**</center>
---
## MOLAP

### 1. Proceso ETL

#### 1.1. Creación de la tabla "raw_salud"

- En primer lugar, se creó la base de datos `TareaMOLAP`.
- Se creó la tabla de los datos crudos tomando en cuenta cada columna del archivo "salud.csv" como un campo en la tabla con su respectivo tipo de dato.
- En la transformación "carga_raw_salud" se añadió un input `CSV file input` y se importó el archivo CSV "salud.csv" utilizando el delimitador punto y coma (;).
- Se añadió el componente `Select values` para seleccionar las columnas provenientes del archivo CSV. Además, en la pestaña "Meta-data", se corrigió el nombre de la columna "visit_id", dado que contenía un carácter invisible que impedía su correcto mapeo con la tabla creada en PostgreSQL.
- Luego, se añadió `Table output` para cargar los datos en `raw_salud`.
- Finalmente, se verificó que la transformación y carga de los datos se ejecutaron de manera exitosa.

| <img src="https://github.com/user-attachments/assets/210a2a71-2d36-45f3-a522-0abed85ad205" width="250"> | <img src="https://github.com/user-attachments/assets/96a1dca8-e192-4768-92e9-7bb041ad51a9" width="250"> | <img src="https://github.com/user-attachments/assets/c3a178c1-43cf-4990-b552-d451e9318448" width="250"> |
|---|---|---|
| Imagen 1. Carga de los datos desde el archivo CSV | Imagen 2. Selección de columnas usando Select values | Imagen 3. Corrección en el nombre de la columna “visit_id”  |
| <img src="https://github.com/user-attachments/assets/2e9dcf43-351a-4538-bec8-23d69826acfe" width="250"> | <img src="https://github.com/user-attachments/assets/f3b0460d-f7e7-4926-81a3-01038868c513" width="250"> | 
| Imagen 4. Carga de los datos a la tabla `raw_salud` | Imagen 5. Resultado final | 

#### 1.2. Transformación y carga de datos

##### 1.2.1. dim_fecha

*	Se creó la tabla `dim_fecha` en la base de datos "TareaMOLAP" dentro de PostgreSQL.
*	En la transformación “carga_dim_fecha” se añadió un input `Table input` para obtener la columna “visit_date” de la `tabla raw_salud`.
*	Se usó la transformación `Select values` para escoger la columna necesaria: visit_date.
*	Mediante el componente `Calculator`, se obtuvieron los valores correspondientes a “anio”, “mes”y “dia” para cada fecha almacenada en el campo “visit_date”.
*	Se utilizó `Unique rows (HashSet)` para remover las fechas repetidas y conservar únicamente un registro por cada fecha.
*	Finalmente, se añadió `Table output ` para cargar los datos en `dim_fecha`.
*	La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| <img src="https://github.com/user-attachments/assets/331b3faf-5def-4c78-bbc5-cc1e6dd45354" width="250"> | <img src="https://github.com/user-attachments/assets/a918c214-54b6-4c4e-bde6-3bb596c3bee0" width="250"> | <img src="https://github.com/user-attachments/assets/c1c8545c-6b6d-49fe-a3cd-b2607f1e3dbd" width="250"> |
|---|---|---|
| Imagen 6. Carga de la columna `visit_date` desde PostgreSQL | Imagen 7. Selección de la columna usando Select values | Imagen 8. Cálculo del año, mes y día para cada fecha con Calculator |
| <img src="https://github.com/user-attachments/assets/e9b3e675-f7e0-4f00-b90f-66896adb87b5" width="250"> | <img src="https://github.com/user-attachments/assets/c8126951-b5ce-4bbe-97ef-c2cc7ae004d8" width="250"> | <img src="https://github.com/user-attachments/assets/a3d35ee9-cb9b-4b7a-9264-851f2bca0926" width="250"> |
| Imagen 9. Eliminación de duplicados con UniqueRows(HashSet)` | Imagen 10. Carga de los datos a la tabla `dim_fecha` | Imagen 11. Resultado final |

##### 1.2.2. dim_paciente

*	Se creó la tabla `dim_paciente` en la base de datos "TareaMOLAP" dentro de PostgreSQL.
*	En la transformación “carga_dim_paciente” se añadió un input `Table input` para obtener las columnas de la tabla `raw_salud`.
*	Se usó la transformación `Select values` para escoger las columnas necesarias.
*	Se utilizó `Unique rows (HashSet)` para remover valores repetidos y conservar los registros únicos.
*	Finalmente, se añadió `Table output ` para cargar los datos en `dim_paciente`.
*	La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/fdc56beb-336b-4e50-9006-97df74f41305" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/9f1f1781-ac39-4d15-a4a7-c00ae4740464" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/6405307b-82b8-4085-bb7f-7614bcb8b8a4" /> |
|---|---|---|
| Imagen 12. Carga de las columnas desde PostgreSQL | Imagen 13. Selección de columnas usando Select values | Imagen 14. Eliminación de duplicados con UniqueRows(HashSet) |
| <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/c1773dbc-a3fb-46d0-8aba-eee0fd3479aa" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/4ac591d2-8af2-4191-b676-9e29cedcb218" /> | |
| Imagen 15. Carga de los datos a la tabla `dim_paciente` | Imagen 16. Resultado final | |

##### 1.2.3. dim_departamento_hospital

* Se creó la tabla `dim_departamento_hospital` en la base de datos "TareaMOLAP" dentro de PostgreSQL.
* En la transformación "carga_dim_departamento_hospital" se añadió un input `Table input` para obtener la columna "city" y "hospital_department" de los datos crudos.
* Se usó la transformación `String operations` para eliminar cualquier espacio en blanco que haya en los datos de las columnas extraídas.
* Luego, se utilizó el elemento de `Sort rows` para ordenar los campos de "city" y "hospital_department" de forma ascendente.
* Posteriormente mediante `Unique Rows` se removieron los datos repetidos, dejando únicamente las combinaciones únicas.
* Finalmente, se añadió `Table output ` para cargar los datos en `dim_departamento_hospital`.
* La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| <img width="200" alt="image" src="https://github.com/user-attachments/assets/6cdbadce-f131-4018-8508-dfcf0d9d1a98" /> | <img width="400" alt="image" src="https://github.com/user-attachments/assets/ad20bce6-8061-4c5d-8cb1-269178f4716c" /> | <img width="400" alt="image" src="https://github.com/user-attachments/assets/43f08a80-eb46-474f-b989-406f0cee9ed7" /> |
|:---:|:---:|:---:|
| Imagen 17. Carga de las columnas `city` y `hospital_department` desde PostgreSQL | Imagen 18. Eliminación de espacios en blanco con String operations | Imagen 19. Ordenamiento ascendente de las columnas |
| <img width="200" alt="image" src="https://github.com/user-attachments/assets/06e8c293-e4fb-4505-87d0-455f3f2a7e8f" /> | <img width="400" alt="Captura de pantalla 2026-06-17 191955" src="https://github.com/user-attachments/assets/9ec708f5-5724-432f-abf1-df77aa4ee751" /> | |
| Imagen 20. Carga de los datos a la tabla `dim_departamento_hospital` | Imagen 21. Resultado final | |

##### 1.2.4. dim_doctor

*	Se creó la tabla `dim_doctor` en la base de datos "TareaMOLAP" dentro de PostgreSQL.
*	En la transformación “carga_dim_doctor” se añadió un input `Table input` para obtener las columnas de la tabla `raw_salud`.
*	Se usó la transformación `Select values` para escoger las columnas necesarias.
*	Se utilizó `Unique rows (HashSet)` para remover valores repetidos y conservar los registros únicos.
*	Finalmente, se añadió `Table output ` para cargar los datos en `dim_doctor`.
*	La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/45e39624-2deb-449b-9395-22e80c39075a" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/d49ece52-80da-4a76-a001-3082f8d02f8a" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/3ae6b08f-d6ed-4d37-8bda-e039bdde50cc" /> |
|:---:|:---:|:---:|
| Imagen 22. Carga de las columnas relacionadas con `dim_doctor` desde PostgreSQL | Imagen 23. Selección de columnas usando Select values | Imagen 24. Eliminación de duplicados con UniqueRows(HashSet) |
| <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/908d19d7-66d7-4be0-850f-028d91d55f96" /> | <img width="792" height="523" alt="image" src="https://github.com/user-attachments/assets/120a741e-bd43-4ada-a54b-7da8539799dd" />| |
| Imagen 25. Carga de los datos a la tabla `dim_doctor` | Imagen 26. Resultado final | |

##### 1.2.5. dim_diagnostico

* Se creó la tabla `dim_diagnostico` en la base de datos "TareaMOLAP" dentro de PostgreSQL.
* En la transformación "carga_dim_diagnostico" se inició añadiendo un input `Table input` para obtener la columna "diagnosis_group" de la tabla `raw_salud `.
* Se añadió el paso `Select values` para escoger las columnas necesarias: diagnosis_group.
* Se ejecutó ` UniqueRows(HashSet)` para remover registros duplicados.
* Finalmente se añadió `Table output` para cargar los datos en `dim_diagnostico`.
* La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.


| <img src="https://github.com/user-attachments/assets/ba312239-e057-4924-bf19-5e6308fe2483" width="250"> | <img src="https://github.com/user-attachments/assets/758bacd4-e605-4a40-9ce7-5c2d88334ecf" width="250"> | <img src="https://github.com/user-attachments/assets/e18f1d1d-7e24-4825-a05e-0ea2c68d0eb0" width="250"> |
|---|---|---|
| Imagen 27. Carga de la columna `diagnosis_group` desde PostgreSQL | Imagen 28. Selección de la columna usando Select values | Imagen 29. Eliminación de duplicados con UniqueRows(HashSet) |
| <img src="https://github.com/user-attachments/assets/3e65f6be-07b0-4ae3-b1c4-e7872a9c45fc" width="250"> | <img src="https://github.com/user-attachments/assets/d1a5a073-545d-40f2-815c-b6b09bf733bc" width="250"> | 
| Imagen 30. Carga de los datos a la tabla `dim_diagnostico` | Imagen 31. Resultado final | 

##### 1.2.6. dim_procedimiento

* Se creó la tabla `dim_procedimiento` en la base de datos "TareaMOLAP" dentro de PostgreSQL.
* En la transformación "carga_dim_procedimiento" se añadió un input `Table input` para obtener la columna "procedure_type" de los datos crudos.
* Se usó la transformación `String operations` para eliminar cualquier espacio en blanco que haya en los datos de las columnas extraídas.
* Luego, se utilizó el elemento de `Sort rows` para ordenar la tabla de forma ascendente.
* Posteriormente mediante `Unique Rows` se removieron los datos repetidos, dejando únicamente las combinaciones únicas.
* Finalmente, se añadió `Table output ` para cargar los datos en `dim_procedimiento`.
* La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.


| <img width="400" alt="Captura de pantalla 2026-06-17 191536" src="https://github.com/user-attachments/assets/679d305f-3cca-4341-aa91-f5d06f8cb042" /> | <img width="400" alt="Captura de pantalla 2026-06-17 232407" src="https://github.com/user-attachments/assets/077b4792-65f3-4371-bbbf-653f869740da" /> | <img width="400" alt="image" src="https://github.com/user-attachments/assets/97914b5c-0fae-43a3-8a91-1c9aa3725346" /> |
|---|---|---|
| Imagen 32. Carga de la columna `procedure_type` desde PostgreSQL | Imagen 33. Eliminación de espacios en blanco con String operations | Imagen 34. Ordenamiento ascendente de la columna |
| <img width="400" alt="image" src="https://github.com/user-attachments/assets/5a390b37-6b3b-48fa-86b1-8e9ca357ae90" /> | <img width="400" alt="Captura de pantalla 2026-06-17 192357" src="https://github.com/user-attachments/assets/4e883455-f8e2-4491-b739-34e3c40bc228" /> |  |
| Imagen 35. Carga de los datos a la tabla `dim_procedimiento` | Imagen 36. Resultado final| |

##### 1.2.7. dim_tipo_seguro

* Se creó la tabla `dim_tipo_seguro` en la base de datos "TareaMOLAP" dentro de PostgreSQL.
* En la transformación "carga_dim_diagnostico" se añadió un input `Table input` para obtener el campo "insurance_type" de la tabla `raw_salud `.
* Se añadió el componente `Select values` para escoger las columnas necesarias: insurance_type.
* Se utilizó ` UniqueRows(HashSet)` para remover registros duplicados.
* Finalmente se añadió `Table output` para cargar los datos en `dim_tipo_seguro`.
* La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| <img src="https://github.com/user-attachments/assets/eadc1984-143f-4ff3-a86e-d27b4d0448b4" width="250"> | <img src="https://github.com/user-attachments/assets/f33e37d9-8e9b-48fd-b531-c3b6900b8e70" width="250"> | <img src="https://github.com/user-attachments/assets/e0dfcb23-78e5-44f2-bb2b-bf7c1651b71b" width="250"> |
|---|---|---|
| Imagen 37. Carga de la columna `insurance_type` desde PostgreSQL | Imagen 38. Selección de la columna usando Select values | Imagen 39. Eliminación de duplicados con UniqueRows(HashSet) |
| <img src="https://github.com/user-attachments/assets/956abee0-a810-4bfa-95dc-5c6c4921ee42" width="250"> | <img src="https://github.com/user-attachments/assets/cca22acb-d68b-41fa-b7f9-8547443cdc8e" width="250"> | 
| Imagen 40. Carga de los datos a la tabla `dim_tipo_seguro` | Imagen 41. Resultado final | 

##### 1.2.8. dim_resultado
* Se creó la tabla `dim_resultado` en la base de datos en PostgreSQL.
* En la transformación `carga_dim_resultado` se añadió un componente `Table Input` para obtener la columna `outcome` desde la tabla `raw_salud`.
* Se incorporó el componente `Select Values` para seleccionar únicamente la columna `outcome`.
* Se utilizó `UniqueRows (HashSet)` para eliminar registros duplicados y garantizar la unicidad de los datos.
* Finalmente, se añadió un componente `Table Output` para cargar los datos en la tabla `dim_resultado`.
* La ejecución del proceso fue exitosa en Pentaho y se verificó la correcta inserción de los registros en PostgreSQL.

| <img src="https://github.com/user-attachments/assets/6a64705a-ef6b-4ad9-816d-50686972311f" width="250"> | <img src="https://github.com/user-attachments/assets/caa8c6c4-b23d-4338-bd25-dcf412e4ca00" width="250"> | <img src="https://github.com/user-attachments/assets/d3031d63-b950-4c38-917e-9b655d1e7c41" width="250"> |
|---|---|---|
| Imagen 42. Carga de la columna `outcome` desde PostgreSQL | Imagen 43. Selección de la columna usando Select values| Imagen 44. Eliminación de duplicados con UniqueRows(HashSet) |
| <img src="https://github.com/user-attachments/assets/cf4563a0-b265-44db-9432-d5bd8cc17c0b" width="250"> | <img src="https://github.com/user-attachments/assets/57b93a53-67e1-4223-b83f-15face6895e7" width="250"> | 
| Imagen 45. Carga de los datos a la tabla dim_resultado | Imagen 46. Resultado final | 

##### 1.2.9. fact_atencion_medica

- Se creó la tabla `fact_atencion_medica` en la base de datos `TareaMOLAP` dentro de PostgreSQL.
   - Se estableció su primary key `atencion_medica_key` siendo un valor entero autoincrementable.
   - A pesar de no tener una influencia directa, también se incluyó el atributo `visit_id`.
   - Se establecieron las métricas definidas en el modelo estrella (`is_emergency`, `length_of_stay_days`, `cost_medicine`, `cost_procedure` y `total_cost`)
   - Finalmente, se añadieron las claves foráneas correspondientes a cada dimensión (`fecha_key`, `paciente_key`, `departamento_key`, `doctor_key`, `diagnostico_key`, `procedimiento_key`, `tipo_seguro_key`, `resultado_key`).
- En la transformación `carga_fact_atencion_medica` se añadió un input `Table input` para obtener los datos necesarios de la tabla `raw_salud`.
   - Luego, se usó el Lookup `Stream lookup` por cada tabla de dimensiones para establecer la coincidencia entre el campo de la tabla `raw_salud` y el campo clave (La primary key) de cada dimensión, con el fin de obtener los valores correspondientes a cada clave foránea.
   - Después se usó el transformation `Select values` para escoger únicamente los campos necesarios para la tabla de hechos.
   - Finalmente, se añadió `Table output` para cargar los datos en `fact_atencion_medica` en la base de datos `TareaMOLAP`.

| <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/154cf675-d5ce-4015-8859-52190fd35c02" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/8e0bec41-e936-4073-9858-53b95a6f976b" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/6c348000-33d6-4bd6-849d-1876c1e63a33" /> |
| --- | --- | --- |
| Imagen 47. Creación tabla `fact_atencion_medica` | Imagen 48. Proceso ETL completo para tabla de hechos y con salida exitosa junto con `Table input` para obtener los datos necesarios de la tabla `raw_salud`.| Imagen 49. Ejemplo de uso de `Stream lookup` en dim_fecha para establecer la coincidencia entre el campo de la tabla `raw_salud` y el campo clave |
| <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/6b87b610-9507-4db6-8683-d28a886d7915" /> | <img width="250" height="250" alt="image" src="https://github.com/user-attachments/assets/3017b73e-8588-4073-9eee-9411be717e33" /> | |
| Imagen 50. Transformación `Select values` que escoge los campos necesarios para la tabla de hechos | Imagen 51. Output `Table output` que carga los datos en `fact_atencion_medica` |

### 2. Modelo estrella

Como resultado del proceso ETL se construyó el modelo estrella para organizar la información de las atenciones médicas. Este modelo está conformado por la tabla de hechos `fact_atencion_medica`, donde se almacenan las medidas principales, y dimensiones que permiten analizar los datos por fecha, paciente, ubicación, departamento, médico, diagnóstico, procedimiento, tipo de seguro y resultado.

<img width="745" height="622" src="https://github.com/user-attachments/assets/0bb7c29a-2f53-4bb4-b341-360442300a6b" />

Imagen 52. Modelo estrella resultante del proceso ETL

### 3. MOLAP (Vista materializada) 

Antes de realizar las consultas MOLAP, se creó una vista materializada `mv_atenciones_medicas` con los campos necesarios de las tablas de dimensiones y de la tabla de hechos que permitan responder las preguntas propuestas. Para ello, se utilizó la siguiente sentencia SQL:

<img width="500" src="https://github.com/user-attachments/assets/aa883357-8f79-442e-b1bd-f2ed82798491" />

Imagen 53. Creación de la vista materializada `mv_atenciones_medicas`

Se comprobó que la vista materializada se haya creado correctamente mediante la visualización de sus datos y la verificación del número de registros almacenados. Como resultado, se obtuvo un total de 100 filas, cantidad que coincide con los registros cargados desde el archivo CSV y con los presentes en la tabla de hechos.

<img width="500" src="https://github.com/user-attachments/assets/b215bd2c-8e70-4c3a-8894-db67dd5bf039" />

Imagen 54. Visualización de registros en la vista materializada `mv_atenciones_medicas`

## Consultas MOLAP   

### 1. ¿Cuál es el costo total de atención por especialidad, ciudad y mes?

Se realizó una consulta sobre la vista materializada `mv_atenciones_medicas`, agrupando los registros por especialidad médica, ciudad y mes de atención. De esta manera, se aplicó la función SUM al campo costo_total para obtener el costo total acumulado de las atenciones en cada combinación.

<img width="500" src="https://github.com/user-attachments/assets/308a4c62-9163-451a-8b5d-f3dbfa078e05" />

Imagen 55. Consulta SQL para obtener el costo total de atención por especialidad, ciudad y mes

A continuación, se presentan los resultados obtenidos:

<img width="500" height="500" alt="image" src="https://github.com/user-attachments/assets/ffd13260-9124-4838-b636-00792444e064" />

Imagen 56. Resultados de la consulta del costo total de atención por especialidad, ciudad y mes - parte 1

<img width="500" height="500" alt="image" src="https://github.com/user-attachments/assets/d1ae3cd0-97a9-439b-a5ec-ed2d09f02828" />

Imagen 57. Resultados de la consulta del costo total de atención por especialidad, ciudad y mes - parte 2

<img width="512" height="87" alt="image" src="https://github.com/user-attachments/assets/97a81669-94a6-4a16-9254-5488899775eb" />

Imagen 58. Resultados de la consulta del costo total de atención por especialidad, ciudad y mes - parte 3

### 2. ¿Qué ciudad tuvo más emergencias por mes y género?

La siguiente consulta permite identificar la ciudad con el mayor número de emergencias para cada combinación de mes y género del paciente. Para ello, se filtran únicamente los registros correspondientes a emergencias (`es_emergencia = 1`), se agrupan por mes, género y ciudad, y posteriormente se utiliza la función analítica `ROW_NUMBER()` para asignar un ranking en función de la cantidad de emergencias registradas. Finalmente, se selecciona únicamente la ciudad con la mayor cantidad de emergencias para cada grupo.

<img width="451" height="488" alt="image" src="https://github.com/user-attachments/assets/7aac4eb1-6623-426a-8707-c887a9eaa318" />

Imagen 59. Consulta SQL para obtener la ciudad que tuvo más emergencias por mes y género


La ejecución de la consulta permitió identificar la ciudad con mayor número de atenciones de emergencia para cada combinación de mes y género. El resultado más relevante corresponde al **mes 2**, donde la ciudad de **Quito** registró el mayor número de emergencias para pacientes de género **masculino (M)**, alcanzando un total de **5 atenciones**, siendo este el valor más alto obtenido en todo el análisis.

En el **mes 1**, la ciudad de **Guayaquil** concentró el mayor número de emergencias para pacientes de género **femenino (F)** con **3 casos**, mientras que **Loja** presentó el mayor número de emergencias para el género **masculino (M)** con **2 casos**. Por su parte, en el **mes 3**, las ciudades con mayor cantidad de emergencias fueron **Quito** para el género **femenino (F)** y **Ambato** para el género **masculino (M)**, registrando **1 caso** cada una.

Estos resultados permiten identificar los patrones geográficos y temporales de las atenciones de emergencia, destacando a **Quito** como la ciudad con el mayor número de emergencias registradas durante el período analizado.
Estos resultados permiten identificar la ciudad con mayor incidencia de emergencias según el mes y el género del paciente, facilitando el análisis de patrones geográficos y temporales para la toma de decisiones en el ámbito hospitalario.

<img width="484" height="174" alt="image" src="https://github.com/user-attachments/assets/7edb8e75-5ee0-4c3d-967a-3c3c8c497d83" />

Imagen 60. Resultados de la consulta de la ciudad con más emergencias por mes y género

### 3. ¿Por diagnóstico, tipo de seguro, cuál es el costo promedio por visita y en qué ciudad es más alto?

La consulta se realizó sobre la vista materializada `mv_atenciones_medicas`. Primero se seleccionaron (`SELECT`) los campos necesarios que fueron `diagnostico`, `tipo_seguro`, `ciudad` y el `costo_total`.

Luego, se agruparon los registros (`GROUP BY()`) por diagnóstico, tipo de seguro y ciudad. De esta manera, se juntaron en una sola fila las que tenían la misma tríada de valores diagnóstico-seguro-ciudad. Esto provocó que el `costo_total` se sumara en un solo valor. Este valor sumado de `costo_total` se le aplicó lo establecido en el `SELECT`, lo cual consistió en que se dividió por el número de registros que tenían esa misma combinación para obtener el costo promedio por visita (`AVG()` y redondeado a 2 decimales con `ROUND()` renombrándolo como `costo_promedio`).

Finalmente, se ordenaron los resultados de forma descendente según el diagnóstico, tipo de seguro y costo promedio (`ORDER BY DESC`). Esto permitió ordenar alfabéticamente por diagnóstico, teniendo como segundo criterio el tipo de seguro si es que había dos o más diagnósticos iguales, y como tercer criterio el costo promedio de forma descendente para cada combinación de diagnóstico y tipo de seguro.

De esta manera, al ordenar por diagnóstico y luego por seguro, y dentro de cada grupo por costo de mayor a menor, entonces la primera ciudad que aparecerá para cada combinación diagnóstico-seguro será la que tendrá el costo promedio más alto.

<img width="892" height="112" alt="image" src="https://github.com/user-attachments/assets/4e0fd2ee-940d-4f42-8688-e2e081c04a69" />

Imagen 61. Consulta SQL para identificar el costo promedio por visita y la ciudad con mayor valor según diagnóstico y tipo de seguro

A continuación, se presentan los resultados obtenidos:

<img width="500" height="500" alt="image" src="https://github.com/user-attachments/assets/1b0db8ac-01ce-4c11-84c7-1cde943c8820" />

Imagen 62. Resultados de la consulta del costo promedio más alto por visita, diagnóstico, tipo de seguro y ciudad - parte 1

<img width="500" height="500" alt="image" src="https://github.com/user-attachments/assets/546ddf45-5c18-4210-94d6-f6af0fa0dffe" />

Imagen 63. Resultados de la consulta del costo promedio más alto por visita, diagnóstico, tipo de seguro y ciudad - parte 2

<img width="615" height="337" alt="image" src="https://github.com/user-attachments/assets/97d82890-473b-444c-87fb-2afb7fd89788" />

Imagen 64. Resultados de la consulta del costo promedio más alto por visita, diagnóstico, tipo de seguro y ciudad - parte 3

## Referencias bibliográficas

[1] P. Bhatia, Data Mining and Data Warehousing: Principles and Practical Techniques. Cambridge, U.K.: Cambridge University Press, 2019. doi: 10.1017/9781108635592.

## Declaración de porcentaje de uso de IA
**ChatGPT:**
* Se utilizó como apoyo en el diseño del modelo estrella, principalmente para revisar en qué tabla debían ubicarse campos como "cost_medicine", "cost_procedure" e "is_emergency", y justificar si correspondían a la tabla de hechos o a una dimensión.
* Se utilizó como apoyo para la elaboración de sentencias SQL grandes, como la creación de la tabla `raw_salud` y de la vista materializada.
* Se usó para analizar un error en Pentaho durante la transformación "carga_raw_salud", relacionado con el mapeo de la columna "visit_id" del archivo CSV hacia la tabla creada en PostgreSQL, debido a un carácter invisible en el encabezado.
* Se utilizó para estructurar la consulta SQL correspondiente a la segunda pregunta analítica (**¿Qué ciudad tuvo más emergencias por mes y género?**), empleando funciones analíticas como `ROW_NUMBER()` para obtener la ciudad con el mayor número de emergencias en cada combinación de mes y género.

**Claude:**
* Se utilizó como apoyo para revisar mejores maneras de plantear las sentencias SQL utilizadas para responder las preguntas planteadas.
* Se utilizó para recordar el funcionamiento de algunos componentes de Pentaho, como Stream lookup.

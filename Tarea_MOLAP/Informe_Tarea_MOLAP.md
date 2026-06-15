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

1. [Pentaho y PostgreSQL](#pentaho-y-postgresql)
   - [1. Creación de la tabla "raw_desnutricion_infantil" en PostgreSQL](#1-creación-de-la-tabla-raw_desnutricion_infantil-en-postgresql)
   - [2. Creación de tablas de dimensiones y tabla de hechos](#2-creación-de-tablas-de-dimensiones-y-tabla-de-hechos)
   - [3. Carga de los datos desde Pentaho al Staging de PostgreSQL](#3-carga-de-los-datos-desde-pentaho-al-staging-de-postgresql)
   - [4. Transformación y carga de los datos crudos](#4-transformación-y-carga-de-los-datos-crudos-desde-el-staging-a-las-tablas-de-dimensiones-y-tabla-de-hechos)
     - [4.1. dim_child](#41-dim_child)
     - [4.2. dim_status](#42-dim_status)
     - [4.3. dim_location](#43-dim_location)
     - [4.4. dim_date](#44-dim_date)
     - [4.5. fact_measurement](#45-fact_measurement)
   - [5. Creación y ejecución de un job](#5-creación-y-ejecución-de-un-job)
2. [Modelo estrella en Power Pivot](#modelo-estrella-en-power-pivot)
3. [Preguntas contestadas en SQL](#preguntas-contestadas-en-sql)
   - [1. ¿Cuál es el tipo de desnutrición más común por región?](#1-cuál-es-el-tipo-de-desnutrición-más-común-por-región)
   - [2. ¿Cómo varía la desnutrición por edad y género?](#2-cómo-varía-la-desnutrición-por-edad-y-género)
   - [3. ¿Qué instituciones atienden más casos?](#3-qué-instituciones-atienden-más-casos)
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

| <img src="https://github.com/user-attachments/assets/210a2a71-2d36-45f3-a522-0abed85ad205" width="250"> | <img src="https://github.com/user-attachments/assets/96a1dca8-e192-4768-92e9-7bb041ad51a9" width="250"> | <img src="https://github.com/user-attachments/assets/2e9dcf43-351a-4538-bec8-23d69826acfe" width="250">|
|---|---|---|
| Imagen 1. Carga de la columna `outcome` desde PostgreSQL | Imagen 2. Selección de la columna usando Select values| Imagen 3. Eliminación de duplicados con UniqueRows(HashSet) |
| <img src="https://github.com/user-attachments/assets/c3a178c1-43cf-4990-b552-d451e9318448" width="250"> | <img src="https://github.com/user-attachments/assets/f3b0460d-f7e7-4926-81a3-01038868c513" width="250"> | 
| Imagen 4. Carga de los datos a la tabla dim_resultado | Imagen 5. Resultado final | 

#### 1.2. Transformación y carga de datos

##### 1.2.1. dim_fecha

| <img src="https://github.com/user-attachments/assets/331b3faf-5def-4c78-bbc5-cc1e6dd45354" width="250"> | <img src="https://github.com/user-attachments/assets/a918c214-54b6-4c4e-bde6-3bb596c3bee0" width="250"> | <img src="https://github.com/user-attachments/assets/c1c8545c-6b6d-49fe-a3cd-b2607f1e3dbd" width="250"> |
|---|---|---|
| Imagen 1. Carga de la columna `outcome` desde PostgreSQL | Imagen 2. Selección de la columna usando Select values| Imagen 3. Eliminación de duplicados con UniqueRows(HashSet) |
| <img src="https://github.com/user-attachments/assets/e9b3e675-f7e0-4f00-b90f-66896adb87b5" width="250"> | <img src="https://github.com/user-attachments/assets/c8126951-b5ce-4bbe-97ef-c2cc7ae004d8" width="250"> | <img src="https://github.com/user-attachments/assets/a3d35ee9-cb9b-4b7a-9264-851f2bca0926" width="250"> |
 
| Imagen 4. Carga de los datos a la tabla dim_resultado | Imagen 5. Resultado final | Imagen 6. |

##### 1.2.2. dim_resultado
Las siguientes imágenes muestran el proceso de construcción y carga de la dimensión dim_resultado dentro del flujo ETL. En primer lugar, se realiza la extracción de la columna outcome desde la base de datos PostgreSQL (Imagen 1), seguida de la selección específica de dicho atributo mediante el componente Select Values (Imagen 2). Posteriormente, se eliminan los registros duplicados utilizando el paso UniqueRows (HashSet) para garantizar la unicidad de los valores (Imagen 3). Una vez depurados los datos, estos se cargan en la tabla dim_resultado del almacén de datos (Imagen 4). Finalmente, se presenta el resultado obtenido tras la ejecución del proceso, evidenciando la correcta creación y almacenamiento de los registros en la dimensión (Imagen 5).

| <img src="https://github.com/user-attachments/assets/6a64705a-ef6b-4ad9-816d-50686972311f" width="250"> | <img src="https://github.com/user-attachments/assets/caa8c6c4-b23d-4338-bd25-dcf412e4ca00" width="250"> | <img src="https://github.com/user-attachments/assets/d3031d63-b950-4c38-917e-9b655d1e7c41" width="250"> |
|---|---|---|
| Imagen 1. Carga de la columna `outcome` desde PostgreSQL | Imagen 2. Selección de la columna usando Select values| Imagen 3. Eliminación de duplicados con UniqueRows(HashSet) |
| <img src="https://github.com/user-attachments/assets/cf4563a0-b265-44db-9432-d5bd8cc17c0b" width="250"> | <img src="https://github.com/user-attachments/assets/57b93a53-67e1-4223-b83f-15face6895e7" width="250"> | 
| Imagen 4. Carga de los datos a la tabla dim_resultado | Imagen 5. Resultado final | 

### 2. Modelo estrella

### 3. MOLAP (Vista materializada) 

## Consultas MOLAP

### 1. ¿Cuál es el costo total de atención por especialidad,ciudad y mes?

### 2. ¿Qué ciudad tuvo más emergencias por mes y género?

### 3. ¿Por diagnóstico, tipo de seguro,  cuál es el costo promedio por visita y en qué ciudad es más alto?

## Referencias bibliográficas


## Declaración de porcentaje de uso de IA

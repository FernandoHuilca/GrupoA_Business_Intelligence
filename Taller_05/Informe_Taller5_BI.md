# <center>**Escuela Politécnica Nacional**</center>
## <center>**Business Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña

------------

# <center>**Práctica 5: Creación Data warehouse**</center>

## **Índice de contenidos**
1. [Initial Load](#initial-load)
2. [Extracción](#extracción)
3. [Transformación](#transformación)
    * [Estandarización columna 'categoria'](#estandarización-columna-categoria)
    * [Estandarización de la columna 'unidad_medida'](#estandarización-de-la-columna-unidad_medida)
    * [Eliminación de símbolos y formato de precios](#eliminación-de-símbolos-innecesarios-y-cambio-de-formato-de-la-columna-precio_unitario)
4. [Carga](#carga)
5. [Resultados](#resultados)

---

## Modelo estrella en Power Pivot



## Pentaho y PostgreSQL


### 1. Creación de la tabla "raw_desnutricion_infantil" en PostgreSQL

Primero se creó la base de datos "practica_5". Luego, se creó la tabla de los datos crudos tomando en cuenta cada columna del archivo "desnutricion_infantil.csv" como un campo en la tabla con su respectivo tipo de dato.

<img width="886" height="444" alt="image" src="https://github.com/user-attachments/assets/58580ad0-a171-44a9-81fe-44d8712c8455" />
<br>
<img width="886" height="303" alt="image" src="https://github.com/user-attachments/assets/0e44e84b-6bd5-47ef-bbf0-c825b3114e99" />


### 2. Creación de tablas de dimensiones y tabla de hechos

Luego del análisis de cómo agrupar los datos, se crearon las tablas de dimensiones "dim_child", "dim_status", "dim_health_center", "dim_date" y la tabla de hechos "fact_measurement".

<img width="769" height="538" alt="image" src="https://github.com/user-attachments/assets/655b050f-21e7-40ac-b510-9174797a7e12" />


### 3. Carga de los datos desde Pentaho al Staging de PostgreSQL 

En una nueva transformación en Pentaho llamda "Load staging_raw", se añadió el input "CSV file input" para obtener los datos del archivo "desnutricion_infantil.csv".

<img width="886" height="631" alt="image" src="https://github.com/user-attachments/assets/85d557be-13d2-458e-93df-680767a79284" /> 
<br>

Después, se creó una conexión a la base de datos "practica_5". 

<img width="546" height="414" alt="image" src="https://github.com/user-attachments/assets/ccb2c5ef-c19b-40b7-b3c2-e161f40f7dbd" />
<br>

Luego, se añadió el output "Table output" para cargar los datos en la tabla "raw_desnutricion_infantil" creada previamente en PostgreSQL.

<img width="886" height="744" alt="image" src="https://github.com/user-attachments/assets/30f736bc-a572-4eb8-ba59-2c529f59ec31" />
<br>

Al ejecutar, se observó una salida exitosa en Pentaho junto con la verificación de los datos en PostgreSQL.

<img width="886" height="306" alt="image" src="https://github.com/user-attachments/assets/587353d4-493a-4db7-9056-066f5b88c58b" />
<br>
<img width="886" height="536" alt="image" src="https://github.com/user-attachments/assets/d650e4f5-6a2c-4406-8428-5e8f1ca59139" />


### 4. Transformación y carga de los datos crudos desde el Staging a las tablas de dimensiones y tabla de hechos

#### 1. dim_child

- En una nueva transformación llamada "Load dim_child", se añadió el input "Table input" para obtener los datos de la tabla "raw_desnutricion_infantil". 

<img width="886" height="481" alt="image" src="https://github.com/user-attachments/assets/8581c0de-4949-476b-b7a3-f52f1affad5d" />
<br>

- Después, se añadió el transformation "Select values" para seleccionar las columnas "child_id", "gender" y "age_months" que eran necesarias para la tabla "dim_child".

<img width="886" height="235" alt="image" src="https://github.com/user-attachments/assets/79935127-d23b-43bc-8f70-e78870ff6ab4" />
<br>

- Además, se añadió el transformation "Unique rows" para eliminar los registros duplicados.

<img width="886" height="302" alt="image" src="https://github.com/user-attachments/assets/884d1018-e273-404e-9dc6-2ddc10b03de8" />
<br>

- Luego, se añadió el output "Table output" para cargar los datos en la tabla de dimensiones "dim_child".

<img width="886" height="782" alt="image" src="https://github.com/user-attachments/assets/18d81ad2-2226-4611-b5f9-c207c9dc418a" />
<br>

- Nuevamente, al ejecutar se observó una salida exitosa en Pentaho junto con la verificación de los datos en PostgreSQL.

<img width="761" height="393" alt="image" src="https://github.com/user-attachments/assets/20adde7c-ece6-4ad6-b610-bd63e17ca7c2" />
<br>
<img width="700" height="694" alt="image" src="https://github.com/user-attachments/assets/10b9b9cd-c880-4ad0-97a0-a4658ce38751" />


## Preguntas contestadas en SQL



### 1. ¿Cuál es el tipo de desnutrición más común por región?



### 2. ¿Cómo varía la desnutrición por edad y género?`



### 3. ¿Qué instituciones atienden más casos?















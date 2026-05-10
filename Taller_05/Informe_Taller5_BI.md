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

## Pentaho y PostgreSQL

### 1. Creación de la tabla "raw_desnutricion_infantil" en PostgreSQL

Primero se creó la base de datos "practica_5". Luego, se creó la tabla de los datos crudos tomando en cuenta cada columna del archivo "desnutricion_infantil.csv" como un campo en la tabla con su respectivo tipo de dato.

<img width="886" height="444" alt="image" src="https://github.com/user-attachments/assets/58580ad0-a171-44a9-81fe-44d8712c8455" />
<br>
<img width="886" height="303" alt="image" src="https://github.com/user-attachments/assets/0e44e84b-6bd5-47ef-bbf0-c825b3114e99" />
<br>

### 2. Creación de tablas de dimensiones y tabla de hechos

Luego del análisis de cómo agrupar los datos, se crearon las tablas de dimensiones "dim_child", "dim_status", "dim_health_center", "dim_date" y la tabla de hechos "fact_measurement".

<img width="387" height="183" alt="image" src="https://github.com/user-attachments/assets/49a582cf-b7ce-42c7-8951-a393faed0459" />
<br>
<img width="338" height="105" alt="image" src="https://github.com/user-attachments/assets/0b8db23e-35a0-40fd-aeb5-e66dfee42ad6" />
<br>

### 3. Carga de los datos desde Pentaho al Staging de PostgreSQL 

En una nueva transformación en Pentaho llamada "Load staging_raw", se añadió el input "CSV file input" para obtener los datos del archivo "desnutricion_infantil.csv".

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

#### 4.1. dim_child

- En una nueva transformación llamada "Load dim_child", se añadió el input "Table input" para obtener los datos de la tabla "raw_desnutricion_infantil". 

<img width="1443" height="732" alt="image" src="https://github.com/user-attachments/assets/66653e62-43c7-465d-8473-9d8bb9d8ae29" />
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
<img width="560" height="428" alt="image" src="https://github.com/user-attachments/assets/6b365118-9b47-4f70-8b2a-159e1a65b9b0" />

#### 4.2. dim_status

- En la transformación llamada “Load dim_status”, se utilizó el componente “Table Input” para obtener los datos de la columna "nutritional_status" de la tabla "raw_desnutricion_infantil" y cargarlos en la tabla "dim_status".

<img width="797" height="612" alt="image" src="https://github.com/user-attachments/assets/d1857ab2-3468-4821-9d8c-0350cbfce20f" />
<br>

- Después, se agregó el componente “Select Values” para seleccionar la columna "nutritional_status", dado que era la necesaria para la tabla "dim_status".

<img width="855" height="235" alt="image" src="https://github.com/user-attachments/assets/09ad6fae-2b1d-45cb-95e3-424834e6d749" />
<br>

- Luego, se añadió el componente "Sort rows" para ordenar los registros en orden ascendente según la columna "nutritional_status", con la finalidad de poder eliminar duplicados. 
<img width="1047" height="332" alt="image" src="https://github.com/user-attachments/assets/3b215255-54bf-4739-874c-2d4583fa28f2" />
<br>

- Como siguiente paso, se agregó el componente “Unique Rows” para eliminar los registros duplicados utilizando la columna "nutritional_status".

<img width="847" height="267" alt="image" src="https://github.com/user-attachments/assets/9b8d868a-0beb-41cb-ba15-725bc985c131" />
<br>

- Por último, se añadió el componente "Table output" para cargar los datos extraídos en la tabla de dimensiones "dim_status".

<img width="696" height="432" alt="image" src="https://github.com/user-attachments/assets/133dba78-ad1d-4fd2-bc47-b6a039c9d988" />
<br>

- Al ejecutar se observó una salida exitosa en Pentaho junto con la verificación de los datos en PostgreSQL.

<img width="625" height="357" alt="image" src="https://github.com/user-attachments/assets/075cea6a-3586-45c8-9bd1-c9897d5865f6" />
<br>
<img width="296" height="217" alt="image" src="https://github.com/user-attachments/assets/9839a75f-b504-4b8d-8741-f37bd8cace3e" />

### 5. Creación y ejecución de un job

En Pentaho, se creó un job para ejecutar secuencialmente todas las transformaciones realizadas, desde la carga de datos crudos al staging hasta las transformaciones y cargas de registros en las tablas de dimensiones y la tabla de hechos, con el fin de construir automáticamente el modelo estrella en PostgreSQL.

(falta la imagen)

## Modelo estrella en Power Pivot








## Preguntas contestadas en SQL

### 1. ¿Cuál es el tipo de desnutrición más común por región?

Por región, el tipo de desnutrición más común es:

| Región | Tipo de desnutrición más común (casos) |
|----------|-----------------------------|
| Amazonía | Crónica y Global (57 casos) |
| Costa | Global (69 casos) |
| Sierra | Global (59 casos) |

- Primero, se seleccionaron las columnas de región y tipo de desnutrición, junto con la cantidad de casos de la combinación región-diagnóstico.

- Luego, usando como base a la tabla de hechos (facts_measurement), se hizo un JOIN para conectar con la tabla de centros de salud (dim_health_center) y con la tabla estados nutricionales (dim_status) a través de sus primary keys.

- Se aplicó un GROUP BY por región y tipo de desnutrición para tener un solo grupo cada fila que comparta una misma ubicación y diagnóstico.

- Adicionalmente, se usó un ORDER BY para organizar alfabéticamente por región y luego por total descendente por la cantidad de casos.

<img width="962" height="510" alt="image" src="https://github.com/user-attachments/assets/3c90244b-0322-424b-ae8b-245f853d3947" />


### 2. ¿Cómo varía la desnutrición por edad y género?

<img width="712" height="657" alt="image" src="https://github.com/user-attachments/assets/52cea673-d3f8-455c-a651-e55f81334cde" />
<br>

Del resultado de la consulta SQL y gráficas realizadas en Excel con ese resultado, se obtuvieron las siguientes observaciones:

- Se registraron 500 casos en total, de los cuales 262 corresponden al género femenino y 238 al género masculino, mostrando una distribución relativamente equilibrada entre ambos géneros.

- La desnutrición global fue el tipo más frecuente con 185 casos, seguida de la desnutrición crónica con 159 casos y la desnutrición aguda con 156 casos.

- En el género femenino y masculino predominan los casos de desnutrición global con 92 registros y 93 casos respectivamente.
- 
<img width="1002" height="300" alt="image" src="https://github.com/user-attachments/assets/78e41eb3-6cb0-4f42-b717-b89b37e8591b" />
<br>

- Existen edades donde se presentan mayores cantidades de casos. Por ejemplo, en el género masculino a los 42 meses se registraron 11 casos en total, principalmente de desnutrición crónica.

<img width="1267" height="532" alt="image" src="https://github.com/user-attachments/assets/600a3980-f3c6-4b06-94ed-83636ca9146a" />
<br>

- En el género femenino destacan edades como 11, 12 y 55 meses, donde se registran entre 9 y 10 casos totales de desnutrición.

<img width="1268" height="533" alt="image" src="https://github.com/user-attachments/assets/ad085416-b2cd-4e82-a830-a20384bd3b25" />
<br>

- La desnutrición crónica presenta una presencia constante en distintas edades y géneros, lo que evidencia que este tipo de desnutrición afecta de manera recurrente a la población infantil analizada.

- Los resultados muestran que los tres tipos de desnutrición están presentes en casi todas las edades estudiadas, indicando que el problema nutricional afecta a una gran cantidad de niños y niñas.

### 3. ¿Qué instituciones atienden más casos?















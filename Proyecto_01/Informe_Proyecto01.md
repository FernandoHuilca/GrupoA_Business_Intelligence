# <center>**Escuela Politécnica Nacional**</center>
## <center>**Proyecto 01 Business Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña

------------
## **Índice de Contenidos**

1. [El problema y la solución](#1-el-problema-y-la-solución)
2. [Justificación del diseño](#2-justificación-del-diseño)
3. [Proceso ETL](#3-proceso-etl)
	 - 3.1. Creación de la tabla "raw_personas_desaparecidas"
	 - 3.2. Transformacion y carga de datos
		 - 3.2.1. dim_ubicacion_desaparicion
4. [Análisis de insights clave obtenidos (OLAP)](#4-análisis-de-insights-clave-obtenidos-olap)
5. [Recomendaciones al negocio](#5-recomendaciones-al-negocio)
------------

# <center>**Análisis sobre desaparaciones en Ecuador 2017 a 2025**</center>

---


## 1. El problema y la solución

<!-- Escribe aquí el contenido -->

## 2. Justificación del diseño

<!-- Escribe aquí el contenido -->

## 3. Proceso ETL

### 3.1. Creación de la tabla "raw_personas_desaparecidas" en PostgreSQL

* Se creó la base de datos "Proyecto01".
* Se creó la tabla de los datos crudos tomando en cuenta cada columna del archivo "mdi_personasdesaparecidas_pm_2017_2025.xlsx" como un campo en la tabla con su respectivo tipo de dato.

Se transformó el archivo .xlsx a formato .csv para facilitar su manipulación en Pentaho Data Integration.

Primero, se seleccionó el componente CSV File Input y se importó el archivo CSV correspondiente a los datos de personas desaparecidas, utilizando el delimitador punto y coma (;).

<img width="870" height="456" alt="image" src="https://github.com/user-attachments/assets/7628d59d-604a-48e1-84d9-b6fcb2c111db" />

Como segundo paso, se utilizó un componente Value Mapper para reemplazar el valor NO_APLICA por la fecha 1900/01/01 en el campo fecha_conocimiento.

<img width="599" height="280" alt="image" src="https://github.com/user-attachments/assets/810c3337-ba80-4c5f-98b0-9a7929831ccf" />

Posteriormente, se utilizó otro componente Value Mapper para reemplazar el valor SIN_DATO por -1 en el campo edad.

<img width="598" height="276" alt="image" src="https://github.com/user-attachments/assets/52b1089f-b912-4ed2-be23-0d4290c337f5" />

A continuación, se utilizó nuevamente un componente Value Mapper en el campo fecha_localizacion, aplicando el mismo criterio utilizado previamente en el campo fecha_conocimiento.

<img width="592" height="270" alt="image" src="https://github.com/user-attachments/assets/81aa7679-70e6-4d58-aa0a-c472baa53d8b" />

Después, se utilizó un componente Value Mapper para reemplazar el valor NO_APLICA por -1 en el campo dias_solucion.

<img width="593" height="271" alt="image" src="https://github.com/user-attachments/assets/920d1254-b938-471b-af10-3440310d17ab" />

De igual manera, se utilizó otro componente Value Mapper para reemplazar un valor atípico o inconsistente en el campo dias_solucion por -1.

<img width="594" height="268" alt="image" src="https://github.com/user-attachments/assets/62aeab4a-aac0-44a0-95a2-2141ed6cae6b" />

Posteriormente, se utilizó el componente Select Values, específicamente en el apartado de Meta-data, para realizar el casteo de los campos a sus tipos de datos correspondientes.

<img width="686" height="359" alt="image" src="https://github.com/user-attachments/assets/9887703d-01a2-4659-8daa-0aae40371d7d" />

Finalmente, se utilizó el componente Table Output para insertar los datos transformados en la base de datos PostgreSQL.

<img width="888" height="418" alt="image" src="https://github.com/user-attachments/assets/03cbe6c8-e976-4835-a898-c2ca17da494a" />

Finalmente, se verificó que la transformación y carga de los datos se ejecutaron correctamente de manera exitosa.

<img width="722" height="394" alt="image" src="https://github.com/user-attachments/assets/0178a4e6-3bff-4b28-96c3-37a0a69eba3f" />


### 3.2. Transformacion y carga de datos
#### 3.2.1 dim_ubicacion_desaparicion

* Se creó la tabla "dim_ubicacion_desaparicion" en la base de datos "Proyecto01" dentro de PostgreSQL.
* En la transformación "Load_dim_ubicacion_desaparicion" se añadió un input `Table input` para obtener los datos de la tabla `raw_personas_desaparecidas`.
* Se añadió el paso `Select values` para escoger las columnas necesarias: canton, provincia, subcircuito, circuito, distrito y zona.
* Se aplicó `Sort rows` porque `Unique rows` sólo elimina duplicados consecutivos.
* Se ejecutó `Unique rows` para remover registros duplicados.
* Finalmente se añadió `Table output` para cargar los datos en `dim_ubicacion_desaparicion`.
* La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| Paso 1 | Paso 2 | Paso 3 |
|---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/dc3acdb1-3d3c-4100-88fd-cabf7eb26f47" alt="transformacion" width="360" /> | <img src="https://github.com/user-attachments/assets/46aea794-86f2-4df1-85dd-9a0df91ab830" alt="salida" width="360" /> | <img src="https://github.com/user-attachments/assets/392399b0-300c-42f5-b1bc-f2c4a731259c" alt="verificacion" width="360" /> |

#### 3.2.2 dim_ubicacion_localizacion

* Se creó la tabla "dim_ubicacion_localizacion" en la base de datos "Proyecto01" dentro de PostgreSQL.
* En la transformación "Load_dim_ubicacion_localizacion" se añadió un input `Table input` para obtener los datos de la tabla `raw_personas_desaparecidas`.
* Se añadió el paso `Select values` para escoger las columnas necesarias: provincia_localizacion.
* Se aplicó `Sort rows` porque `Unique rows` sólo elimina duplicados consecutivos.
* Se ejecutó `Unique rows` para remover registros duplicados.
* Finalmente se añadió `Table output` para cargar los datos en `dim_ubicacion_localizacion`.
* La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| Paso 1 | Paso 2 | Paso 3 |
|---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/9468f8e4-ad6c-447e-be28-add1d51e7590" alt="transformacion" width="360" /> | <img src="https://github.com/user-attachments/assets/43b94a32-f4fe-4bf2-990a-444424a42a15" alt="salida" width="360" /> | <img src="https://github.com/user-attachments/assets/87819eff-a8d3-4aee-8a28-80b35c2d6c8d" alt="verificacion" width="360" /> |


#### 3.2.3 fact_desaparacion

- Se creó la tabla `fact_desaparacion` en la base de datos `Proyecto01` dentro de PostgreSQL. 
	- Se definieron las foreign keys hacia cada una de las dimensiones (dim_estado, dim_motivo, dim_ubicacion_desaparicion, dim_ubicacion_localizacion, cada una de las fechas de dim_fecha y dim_persona) junto con las medidas edad y dias_solucion.

- Luego, en la transformación `carga_fact_desapariciones`, a diferencia de anteriores prácticas donde existía un ID único por registro, aquí las dimensiones se identificaron por la combinación de varias columnas. 
	- Por esta razón, se extrajeron todas las columnas necesarias desde `raw_personas_desaparecidas` mediante un `Table input` para poder hacer el match en los lookup.

- Se usaron múltiples `Stream lookup`, cada uno con su respectivo `Table input` consultando la tabla de dimensión correspondiente. 
	- En cada lookup se relacionaron los campos naturales de la tabla raw con los de la dimensión para obtener su clave subrogada.
 
- Después, como las cuatro fechas (desaparición, denuncia, conocimiento, localización) apuntaban a la misma tabla dim_fecha, entonces se entendió que se trataba de una dimensión de rol múltiple. 
	- Por tanto, se implementaron cuatro `Stream lookup` independientes contra dim_fecha, renombrando cada clave devuelta según su rol.

- Se agregó scripting `Modified JavaScript value` para limpiar las medidas dias_solucion (NO_APLICA por -1) y edad (valores vacíos a null).

- Con un `Select values` se filtraron los campos finales que fueron las claves subrogadas de cada dimensión y las medidas.

- Por último, usando `Table output` se cargaron los datos transformados en la tabla fact_desaparacion, mapeando cada campo del flujo con su correspondiente columna en la base de datos.

	- La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| Paso 1 | Paso 2 | Paso 3 |
|---:|:---:|:---:|
|  |  |  |

## 4. Análisis de insights clave obtenidos (OLAP)

<!-- Escribe aquí el contenido -->

## 5. Recomendaciones al negocio

<!-- Escribe aquí el contenido -->



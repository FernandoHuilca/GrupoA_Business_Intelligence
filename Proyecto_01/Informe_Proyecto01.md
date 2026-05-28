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



## 4. Análisis de insights clave obtenidos (OLAP)

<!-- Escribe aquí el contenido -->

## 5. Recomendaciones al negocio

<!-- Escribe aquí el contenido -->



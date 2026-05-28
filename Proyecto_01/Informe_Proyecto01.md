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
	 * [3.1. Creación de la tabla "raw_personas_desaparecidas" en PostgreSQL](#31-creación-de-la-tabla-raw_personas_desaparecidas-en-postgresql)
	 * [3.2. Transformacion y carga de datos](#32-transformacion-y-carga-de-datos)
		 * [3.2.1. dim_ubicacion_desaparicion](#321-dim_ubicacion_desaparicion)
		 * [3.2.2. dim_ubicacion_localizacion](#322-dim_ubicacion_localizacion)
4. [Análisis de insights clave obtenidos (OLAP)](#4-análisis-de-insights-clave-obtenidos-olap)
5. [Recomendaciones al negocio](#5-recomendaciones-al-negocio)
------------

# <center>**Análisis sobre desaparaciones en Ecuador 2017 a 2025**</center>

---


## 1. El problema y la solución

### 1.1. Problema

En Ecuador, los casos de personas reportadas como desaparecidas constituyen una problemática social y de seguridad que requiere seguimiento y análisis oportuno. Para este proyecto se trabajó con el conjunto de datos histórico del Ministerio del Interior, correspondiente al periodo 2017-2025, sobre personas reportadas como desaparecidas por presunta desaparición involuntaria.

Aunque los datos contienen información relevante sobre fechas, ubicación, edad, sexo, motivo de desaparición, situación actual y tiempo de solución, su análisis en el formato original (archivo con extensión .xlsx) resulta limitado. Al estar en una estructura plana, no permite identificar fácilmente patrones temporales, demográficos o de resolución de casos. Por esta razón, se planteó la necesidad de organizar la información en un modelo analítico que facilite la obtención de **insights** y el **apoyo a la toma de decisiones**.	

### 1.2 Solución

Para abordar esta necesidad, se desarrolló una solución de inteligencia de negocios basada en un **proceso ETL** y un **modelo multidimensional tipo estrella**. Los datos fueron extraídos, transformados y cargados mediante Pentaho Data Integration hacia una base de datos PostgreSQL.

Posteriormente, la información se organizó en una tabla de hechos y varias dimensiones. La tabla de hechos concentra los registros principales de desaparición, mientras que las dimensiones permiten filtrar y agrupar la información según las necesidades del análisis, como tiempo, ubicación, características de la persona, motivo de desaparición y estado actual.

Finalmente, los datos transformados fueron conectados a Power BI para construir un reporte interactivo que facilite la identificación de patrones, la interpretación de la información y el apoyo a la toma de decisiones relacionadas con los casos de personas desaparecidas.

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
#### 3.2.1. dim_ubicacion_desaparicion

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

#### 3.2.2. dim_ubicacion_localizacion

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

#### 3.2.3. dim_persona

* Se creó la tabla "dim_persona" en la base de datos "Proyecto01" dentro de PostgreSQL.
* En la trasformación "carga_dim_persona" se inicio añadiendo un input `Table input` para obtener los datos de la tabla `raw_personas_desaparecidas`.
* Se añadió el paso `Slect values` para escoger las columnas necesarias: sexo, nacionalidad, rango_edad, etnia.
* Se aplicó `Sort rows` porque `Unique rows` sólo elimina duplicados consecutivos.
* Se ejecutó `Unique rows` para remover registros duplicados.
* Finalmente se añadió `Table output` para cargar los datos en `dim_persona`.
* La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| Paso 1 | Paso 2 | Paso 3 |
|---:|:---:|:---:|
|  <img width="928" height="279" alt="image" src="https://github.com/user-attachments/assets/a8855a2f-a6c0-4ce6-9286-753050fe408a" /> | <img width="866" height="553" alt="image" src="https://github.com/user-attachments/assets/f6a94046-057d-4f6e-a914-924e25dc798f" /> | <img width="972" height="474" alt="Captura de pantalla 2026-05-27 234310" src="https://github.com/user-attachments/assets/149cf76d-8ad2-435f-9066-f61ac9d83c59" /> |

#### 3.2.4. dim_estado

* Se creó la tabla dim_estado en la base de datos Proyecto01 dentro de PostgreSQL.
* En la transformación carga_dim_estado se inició añadiendo un input `Table Input` para obtener los datos desde la tabla `raw_personas_desaparecidas`.
* Se añadió el paso `Select Values` para escoger las columnas necesarias relacionadas con el estado de la desaparición, como: situacion_actual, estado_desaparecido.
* Posteriormente, se aplicó el componente `Unique Rows (Hash)` para eliminar registros duplicados y conservar únicamente combinaciones únicas.
* Finalmente, se añadió el componente `Table Output` para cargar los datos en la tabla `dim_estado`.
* La ejecución mostró una salida exitosa en Pentaho y posteriormente se verificaron los datos cargados correctamente en PostgreSQL.

| Paso 1 | Paso 2 |
|---|---|
| <img src="https://github.com/user-attachments/assets/0e8b9c46-6f21-4622-9da7-b1f81744b961" width="450" /> | <img src="https://github.com/user-attachments/assets/ae581336-7f19-4222-8200-644955e5fffc" width="450" /> |

| Paso 3 | Paso 4 |
|---|---|
| <img src="https://github.com/user-attachments/assets/089d0ab2-d710-494b-9696-8a3128e03946" width="450" /> | <img src="https://github.com/user-attachments/assets/55700459-927f-46e9-b7d6-819e40e48e95" width="450" /> |

#### Transformación

<img width="652" height="285" alt="Captura de pantalla 2026-05-27 205644" src="https://github.com/user-attachments/assets/ff5eda60-210a-4530-80b2-1b3f6e90f239" />

#### 3.2.5. dim_motivo

* Se creó la tabla dim_motivo en la base de datos Proyecto01 dentro de PostgreSQL.
* En la transformación carga_dim_motivo se inició añadiendo un input `Table Input` para obtener los datos desde la tabla `raw_personas_desaparecidas`.
* Se añadió el paso `Select Values` para escoger las columnas necesarias relacionadas con el motivo de la desaparición, como: motivo_desaparicion, motivacion_desaparicion_observada.
* Posteriormente, se aplicó el componente `Unique Rows (Hash)` para eliminar registros duplicados y conservar únicamente combinaciones únicas.
* Finalmente, se añadió el componente `Table Output` para cargar los datos en la tabla `dim_motivo`.
* La ejecución mostró una salida exitosa en Pentaho y posteriormente se verificaron los datos cargados correctamente en PostgreSQL.

| Paso 1 | Paso 2 |
|---|---|
| <img src="https://github.com/user-attachments/assets/dcb7c2d7-b931-4ef6-8e1f-913943eb480c" width="450" /> | <img src="https://github.com/user-attachments/assets/00e15d4a-78ed-46a7-8e2b-f94d53cda8a6" width="450" /> |

| Paso 3 | Paso 4 |
|---|---|
| <img src="https://github.com/user-attachments/assets/60c8b03c-fc84-451c-a334-42031d10e5b4" width="450" /> | <img src="https://github.com/user-attachments/assets/c2d0a2fd-f1c5-4a01-b071-a3f64f3b652d" width="450" /> |

#### Transformación

<img width="671" height="328" alt="image" src="https://github.com/user-attachments/assets/b549ee04-4c87-4ee6-9823-e2ffec9c1dc6" />

#### 3.2.6. dim_fecha

- Se creó la tabla “dim_fecha” en la base de datos "Proyecto01" dentro de PostgreSQL.
- En la transformación “carga_dim_fecha” se añadió un input `Table input` para obtener las columnas “fecha_desaparicion”, “fecha_denuncia”, “fecha_conocimiento” y “fecha_localizacion” de la tabla `raw_personas_desaparecidas`.
- Se usó la transformación `Row normaliser`para convertir las cuatro columnas de fecha en una sola columna. Para ello, se creó el campo “tipo_fecha”, que identifica de qué columna proviene cada fecha, y el campo “fecha_key”, donde se agrupan todas las fechas.
- Se añadió la transformación `Select values` para escoger las columnas necesarias: fecha_key, especificando el tipo de dato y el formato.
- Mediante el componente `Calculator`, se obtuvieron los valores correspondientes a “anio”, “mes”y “dia” para cada fecha almacenada en el campo “fecha_key”.
- Se añadió `Sort rows` para ordenar los registros de forma ascendente según el campo “fecha_key”.
- Se utilizó `Unique rows` para remover las fechas repetidas y conservar únicamente un registro por cada fecha.
- Finalmente, se añadió `Table input` para cargar los datos en `dim_fecha`.
- La ejecución mostró salida exitosa en Pentaho y se verificaron los datos en PostgreSQL.

| Paso 1 | Paso 2 | Paso 3 |
|:---:|:---:|:---:|
| <img width="360" alt="Paso 1" src="https://github.com/user-attachments/assets/74280ce6-5833-42bb-8be7-ff309e271007" /> | <img width="360" alt="Paso 2" src="https://github.com/user-attachments/assets/9941e0ca-d237-44c9-8f29-3526c3253b14" /> | <img width="360" alt="Paso 3" src="https://github.com/user-attachments/assets/6d6c5946-dfa9-47ec-a74e-b04bf63228d6" /> |

#### 3.2.7. fact_desaparacion

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
| <img alt="Tabla en base de datos" width="360" src="https://github.com/user-attachments/assets/24689048-79bb-44a4-a997-321ef1c7ad6f" /> | <img alt="Resultado de transformacion" width="360" src="https://github.com/user-attachments/assets/59e2b050-a99d-4b67-943c-05d796660a21" /> | <img alt="Tabla llena con datos" width="360" src="https://github.com/user-attachments/assets/2cd3ef3f-0ff8-413c-be05-56598ff36943" /> |

#### 3.2.8. etl_job_desaparacion

- Se creó el job `etl_job_desaparicion.kjb` para automatizar todas las transformaciones en el orden correcto.
	
	- Primero se cargó `carga_raw_desaparecidos.ktr` para obtener los datos del CSV a la tabla `raw_personas_desaparecidas`.

	- Luego se cargaron las dimensiones para colocar los datos en las tablas dim_estado, dim_motivo, dim_persona, dim_fecha, dim_ubicacion_desaparicion y dim_ubicacion_localizacion.

	- Finalmente, se cargó `carga_fact_desapariciones.ktr` para llenar la tabla `fact_desaparacion` usando las claves de las dimensiones ya cargadas.

<img width="360" alt="job etl para cargar la tabla raw, dim y fact" src="https://github.com/user-attachments/assets/033a25c2-cdb1-4bf2-8d7e-ac63829ac083" />


## 4. Análisis de insights clave obtenidos (OLAP)

<!-- Escribe aquí el contenido -->

### 4.1. ¿Existe una correlación directa entre el tiempo que tarda un familiar en denunciar y la situacion_actual de la persona si es fallecido?

- En Power BI, se creó una columna calculada en `fact_desaparacion` llamada `dias_denuncia` para medir los días transcurridos entre la desaparición y la denuncia:

	```
	dias_denuncia = DATEDIFF(fact_desaparacion[fecha_desaparicion_key], fact_desaparacion[fecha_denuncia_key], DAY)
	```

- Luego, se creó una columna de agrupación con el nombre de `Rango_Denuncia` para categorizar los días en intervalos significativos (0 días, 1-3, 4-7, 8-15, 16-30, +31).

	```
	Rango_Denuncia = 
	SWITCH(
	    TRUE(),
	    fact_desaparacion[dias_denuncia] = 0, "a) 0 días",
	    fact_desaparacion[dias_denuncia] <= 3, "b) 1-3 días",
	    fact_desaparacion[dias_denuncia] <= 7, "c) 4-7 días",
	    fact_desaparacion[dias_denuncia] <= 15, "d) 8-15 días",
	    fact_desaparacion[dias_denuncia] <= 30, "e) 16-30 días",
	    "f) 31+ días"
	)
	```

- Después, se definieron tres medidas DAX (Data Analysis Expressions - Lenguaje de fórmulas oficial de Power BI) sobre `fact_desaparacion`:

	- `Total_Casos`: conteo total de registros de la tabla `fact_desaparacion`.
	
		```
		Total_Casos = COUNTROWS(fact_desaparacion)
		```

	- `Total_Fallecidos`: conteo de registros en `fact_desaparacion` con el atributo situacion_actual = "FALLECIDO" de dim_estado usando la relación.

		```
		Total_Fallecidos = 
		CALCULATE(
		    COUNTROWS(fact_desaparacion),
		    dim_estado[situacion_actual] = "FALLECIDO"
		)
		```

	- `Tasa_Letalidad`: división de `Total_Fallecidos` entre `Total_Casos`, formateada como porcentaje.

		```
		Tasa_Letalidad = DIVIDE([Total_Fallecidos], [Total_Casos], 0)
		```

- Para la visualización, se usó un gráfico combinado de columnas y líneas, ordenando ascendentemente por `Rango_Denuncia`:

	- Eje X: Rango_Denuncia.

	- Columnas: Total_Casos.

	- Línea: Tasa_Letalidad.

- Se observó que la tasa de letalidad subía de 1,41% (0 días) a 3,69% (1-3 días). 
	
	- Luego se mantuvo entre los valores del 3,5% al 4,5% para todos los demás rangos. Esto descartó una correlación lineal entre la demora en denunciar y la probabilidad de fallecimiento. 
	
- Se concluyó que el factor determinante del estado del desaparecido no se trató de la velocidad de la denuncia. Podría estar más asociado a otros factores como las circunstancias que rodearon la desaparición.

<img width="720" alt="dashboard power bi de tiempo de denuncia y la situacion_actual de la persona (fallecido)"  src="https://github.com/user-attachments/assets/7cd2f52b-d828-4fe3-be1f-1a536ca9a182" />



## 5. Recomendaciones al negocio

<!-- Escribe aquí el contenido -->


- Como el 57.33% de las denuncias se realizan entre 1 y 3 día, se deben implementar protocolos de búsqueda inmediata. Se debe destinar  recursos y personal de manera prioritaria durante las primeras 72 horas luego de la denuncia.

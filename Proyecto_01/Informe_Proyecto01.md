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

Para organizar, estructurar y transformar el conjunto de datos crudos sobre personas desaparecidas provisto por el Ministerio del Interior de la República del Ecuador (periodo 2017-2025), se determinó la implementación de un **Modelo Estrella**. Este enfoque multidimensional optimiza el rendimiento de las consultas y facilita la construcción de tableros de control (dashboards) interactivos, permitiendo descomponer una problemática social compleja en ejes de análisis sumamente claros.

A continuación, se detalla y justifica la arquitectura del modelo, segmentada en su Tabla de Hechos y sus respectivas Tablas de Dimensiones.

### 1. Tabla de Hechos (`fact_desaparicion`)

En primera instancia, se identificó la granularidad del modelo: cada registro representa una denuncia o alerta individual de desaparición. A partir de las preguntas de negocio planteadas, se determinó que la tabla de hechos centralizará las métricas numéricas y cuantitativas del fenómeno, además de las llaves foráneas (FK) que conectan con las dimensiones.

Los hechos numéricos definidos son:
* **`edad`:** Variable cuantitativa que almacena la edad cronológica de la víctima al momento del suceso. Su permanencia en la tabla de hechos es fundamental para calcular métricas agregadas como el promedio de edad de los desaparecidos según su perfil o territorio.
* **`dias_solucion`:** Métrica operativa crítica que registra el tiempo transcurrido (en días) desde la fecha de desaparición hasta el cambio de condición del ciudadano (localización).

<img width="253" height="531" alt="image" src="https://github.com/user-attachments/assets/8ab50f15-9c39-458b-bf51-839280ac9cb6" />


### 2. Tablas de Dimensiones

#### Dimensión de Tiempo (`dim_fecha`)
El conjunto de datos original cuenta con múltiples variables temporales: `fecha_desaparicion`, `fecha_denuncia`, `fecha_conocimiento` y `fecha_localizacion`. En lugar de fragmentar el modelo en múltiples tablas de tiempo, se optó por unificar la estructura cronológica en una sola dimensión física. 

Esta dimensión actuará bajo el concepto de **Dimensiones con Múltiples Roles (*Role-Playing Dimensions*)**. La tabla de hechos se conectará a ella mediante cuatro llaves foráneas independientes, permitiendo analizar de manera unificada el comportamiento estacional de la desaparición frente a la velocidad de la denuncia y la resolución.

<img width="572" height="549" alt="image" src="https://github.com/user-attachments/assets/fd5ea4fa-050b-48dd-8582-05291227b4c0" />

#### Dimensión de Estado (`dim_estado`)
Esta dimensión condensa los atributos cualitativos que describen la situación administrativa y la condición física de la persona dentro del proceso de investigación. Agrupa las siguientes variables:
* **`situación_actual`:** Categorías macro del desenlace del caso (`DESAPARECIDO`, `ENCONTRADO`, `FALLECIDO`).
* **`estado_desaparecido`:** Detalle del estado legal o de la naturaleza del evento (`EN INVESTIGACIÓN`, `DESAPARICIÓN VOLUNTARIA`, `DESAPARICIÓN INVOLUNTARIA`, `EXTRAVÍO`).

<img width="373" height="529" alt="image" src="https://github.com/user-attachments/assets/e3526e27-0ce4-4900-be94-2cb2c03f7bb5" />

#### Dimensión de Motivo (`dim_motivo`)
Diseñada para profundizar en la naturaleza del suceso y los factores detonantes. Centraliza dos columnas descriptivas: `motivo_desaparicion` y `motivacion_desaparicion_observada`. Su separación en una dimensión independiente facilita la clasificación de las causas subyacentes (delincuencia, violencia de género, problemas intrafamiliares o crisis de salud mental).

<img width="311" height="426" alt="image" src="https://github.com/user-attachments/assets/d34f6fa1-9ee2-42f3-88bf-979c076372d9" />

#### Dimensión de Persona (`dim_persona`)
Funciona como una dimensión de perfiles demográficos (*Junk Dimension*), agrupando los atributos de `sexo`, `nacionalidad`, `rango_edad` y `etnia`. Dado que el dataset no expone identidades directas (nombres o cédulas) por motivos de confidencialidad, esta dimensión almacena las combinaciones **únicas** de características físicas y sociales. Esto mitiga la redundancia masiva de texto y permite identificar con precisión los grupos poblacionales con mayor índice de vulnerabilidad en el país.

<img width="292" height="450" alt="image" src="https://github.com/user-attachments/assets/4fd241de-5c5e-4980-a05b-8e25a213aed9" />

#### Dimensión de Ubicación de Localización (`dim_ubicacion_localizacion`)
Para efectos del análisis del cierre de los casos, se consideró únicamente el atributo de `provincia_localizacion`. Al tratarse de un análisis macro del destino de las personas halladas, se descartaron los campos de latitud y longitud de localización, pues no son datos que se consideraron relevantes para la estructura de este modelo.

<img width="480" height="661" alt="image" src="https://github.com/user-attachments/assets/fda091b4-c8b8-4e73-a311-8c8ca1f2d467" />

#### Dimensión de Ubicación de Desaparición (`dim_ubicacion_desaparicion`)
Representa una de las dimensiones con mayor número de columnas agrupadas del modelo. Durante la fase de diseño se evaluó la posibilidad de aplicar un modelo en *Copo de Nieve* para normalizar la jerarquía territorial de macro a micro (Zona -> Provincia -> Cantón -> Distrito -> Circuito -> Subcircuito) con el fin de reducir espacio en disco. 

Sin embargo, se decidió **colocar toda la jerarquía en una sola dimensión** siguiendo las mejores prácticas de modelado dimensional investigadas. Esto se realizó principalmente para mantener el modelo estrella y obtener los beneficios que ofrece, principalmente en cuanto al rendimiento para evitar consultas complejas en la base de datos.

Además, se descartaron explícitamente las columnas de coordenadas geográficas (`latitud_desaparicion`, `longitud_desaparicion`) y los códigos internos de cantones y provincias, dado que no aportan valor numérico aditivo ni descriptivo de acuerdo con lo planteado para este informe.

<img width="730" height="452" alt="Captura de pantalla 2026-05-28 172139" src="https://github.com/user-attachments/assets/a8bbc254-f059-4562-9074-a0308ba7ddaf" />

### Conclusión del Diseño

A través de esta arquitectura compuesta por **una tabla de hechos y seis tablas de dimensiones**, el modelo estrella propuesto garantiza una estructura altamente normalizada y eficiente. El diseño no solo mitiga los problemas de redundancia del archivo de Excel original, sino que proporciona el entorno óptimo para extraer la información importante relacionada con los datos geográficos, patrones demográficos de riesgo y tiempos de respuesta institucional en el Ecuador.

**Esquema estrella:**

<img width="1236" height="799" alt="image" src="https://github.com/user-attachments/assets/1d33b5a6-adb5-44f6-a6ff-386a2929ba1f" />


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


### 4.2. ¿Existen meses o épocas del año donde los picos de desapariciones aumentan para rangos de edad específicos?

- Para facilitar la lectura, los meses se presentan con su nombre y no con el número de la consulta SQL.

| Rango de edad | Enero | Febrero | Marzo | Abril | Mayo | Junio | Julio | Agosto | Septiembre | Octubre | Noviembre | Diciembre | Mes con mayor pico | Mes con menor pico |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---|---|
| Adolescentes | 3774 | 3190 | 3348 | 2859 | 3025 | 3129 | 3306 | 3145 | 2956 | 3207 | 3143 | 2998 | Enero | Abril |
| Adulto | 2629 | 2481 | 2617 | 2338 | 2439 | 2438 | 2560 | 2520 | 2491 | 2541 | 2352 | 2580 | Enero | Abril |
| Adulto mayor | 246 | 234 | 246 | 255 | 219 | 238 | 253 | 256 | 243 | 267 | 231 | 293 | Diciembre | Mayo |
| Niños(as) | 394 | 390 | 417 | 392 | 317 | 395 | 398 | 399 | 394 | 389 | 388 | 355 | Marzo | Mayo |

- En términos generales, los grupos con mayor número de casos son **Adolescentes** y **Adulto**, muy por encima de **Niños(as)** y **Adulto mayor**.
- El comportamiento mensual no muestra un único pico que se repita en todos los rangos de edad. Sin embargo, sí se observan meses de mayor concentración por grupo:
	- **Adolescentes:** el valor más alto aparece en **enero** y se mantiene elevado en **marzo**, **julio** y **octubre**.
	- **Adolescentes:** el valor más bajo se registra en **abril**.
	- **Adulto:** el mayor volumen también se concentra en **enero**, seguido por valores altos en **marzo** y **diciembre**.
	- **Adulto:** el valor más bajo se registra en **abril**.
	- **Adulto mayor:** el pico más alto ocurre en **diciembre**, con un repunte adicional en **octubre**.
	- **Adulto mayor:** el valor más bajo se registra en **mayo**.
	- **Niños(as):** el máximo se registra en **marzo**, con niveles también altos en **julio**, **agosto** y **junio**.
	- **Niños(as):** el valor más bajo se registra en **mayo**.
- Con base en estos resultados, se concluye que **sí existen meses con incrementos por rango de edad**, pero no se trata de una estacionalidad uniforme para toda la población. Más bien, cada grupo presenta sus propios meses críticos, por lo que el análisis debe enfocarse de forma segmentada.

### 4.3 ¿Cómo ha evolucionado la cantidad de personas reportadas como desaparecidas entre 2017 y 2025 en Ecuador, y qué provincias concentran los mayores niveles de casos durante este periodo?

Para responder esta pregunta en Power BI, se utilizaron las dimensiones `dim_fecha` y `dim_ubicacion_desaparicion`, junto con la tabla de hechos `fact_desaparacion`.

A partir de la fecha de desaparición registrada en la tabla de hechos, se relacionó cada caso con el campo anio de dim_fecha, permitiendo agrupar los registros por año.

<img width="1294" height="616" alt="image" src="https://github.com/user-attachments/assets/40320b21-19a3-43b8-9d53-9afb55a43377" />

Para la visualización, se construyó un gráfico de columnas con la siguiente configuración:
Eje X: dim_fecha[anio]
Eje Y: Total de desaparecidos (recuento[desaparicion_key])

<img width="771" height="456" alt="image" src="https://github.com/user-attachments/assets/c315e965-b219-4d2f-834c-5f257fe6e7f1" />

Por otro lado, se utilizó un mapa para identificar las provincias con mayor número de reportes de personas desaparecidas.

<img width="634" height="641" alt="image" src="https://github.com/user-attachments/assets/5c3c8c8c-147e-4b08-bd95-6a67eca5d1c9" />

| Provincia | Número de desaparecidos |
| --------- | ----------------------: |
| Pichincha |                  18.493 |
| Guayas    |                  17.643 |
| Manabí    |                   3.754 |
| Azuay     |                   3.568 |
| El Oro    |                   3.292 |

Con base en los resultados, se obtuvieron los siguientes hallazgos:
- Entre 2017 y 2019 se registraron los niveles más altos de personas reportadas como desaparecidas en Ecuador.
- En 2020 se observa una disminución marcada en los reportes, año que coincide con el periodo de pandemia y restricciones de movilidad en el país.
- Desde 2021 hasta 2025, los casos vuelven a incrementarse respecto a 2020, pero no alcanzan los valores registrados antes de la pandemia.
- A nivel territorial, los casos no se distribuyen de manera uniforme, puesto que Pichincha y Guayas concentran la mayor cantidad de reportes, con 18.493 y 17.643 casos, respectivamente.
- Existe una diferencia considerable entre Pichincha y Guayas frente al resto de provincias, ya que Manabí, Azuay y El Oro registran menos de 4.000 casos cada una. Esto indica que la evolución nacional de los casos está fuertemente influenciada por las provincias con mayor concentración de reportes.

### 4.4 ¿Cuántos casos han sido resueltos y cuántos permanecen sin resolución? Además, dentro de los casos resueltos, ¿cuántos corresponden a personas encontradas fallecidas?
- Para responder a esta pregunta es necesario realizar una categorización de la dimensión de estado para clasificar cada elemento entre ``Caso Resuelto`` y ``Caso no resuelto``.
- En el editor de Power Query, se seleccionó la tabla "dim_estado" y se añadieron dos columnas condicionales para estructurar la jerarquía analítica.
	-	Columna "Macro_Estado": Si situacion_actual es igual a ENCONTRADO o FALLECIDO, se asigna el valor "Casos Resueltos"; de lo contrario, "Casos No 		Resueltos".
 	-	Columna "Detalle_Estado": Mapeo descriptivo para identificar el desenlace vital (Encontrados con vida, Fallecidos / Hallados sin vida o Siguen 			desaparecidos).

 Para la configuración del gráfico se realizó lo siguiente:
  -	Se arrastró al lienzo un Gráfico de Anillos (Donut Chart).
  	-	Campos: Se colocó Macro_Estado y Detalle_Estado en la sección de Leyenda para habilitar la función nativa de desglose
   	-	Valores: Se asignó el campo desaparicion_key de la tabla de hechos configurado en Recuento.

A partir del análisis multidimensional de los 75,680 registros oficiales (periodo 2017-2025), se extrajeron las siguientes conclusiones estratégicas para el informe:

- Alta Efectividad de Localización: El Estado ecuatoriano registra una Tasa de Resolución Global del 96.61%, lo que equivale a 73,113 casos cerrados. Esto demuestra una alta capacidad operativa de las unidades especializadas para dar con el paradero de las víctimas y concluir los protocolos de búsqueda.
- Índice de Letalidad en Casos Cerrados: Del total de casos resueltos, el 96.45% (70,518 personas) fue localizado con vida. Sin embargo, el 3.55% (2,595 personas) fue hallado fallecido, marcando el índice de letalidad del fenómeno y transformando la desaparición en una investigación de materia penal ordinaria.
- Casos Abiertos: Únicamente el 3.39% (2,567 casos) permanece categorizado como "Casos No Resueltos". Esta cifra representa la carga activa de personas que continúan siendo buscadas activamente por las autoridades del orden a nivel nacional.

Casos resueltos vs No resueltos:

<img width="617" height="585" alt="image" src="https://github.com/user-attachments/assets/fea9cbbc-4eac-4d8f-982b-cfd019418be2" />

Casos resueltos (Encontrados con o sin vida):

<img width="663" height="581" alt="image" src="https://github.com/user-attachments/assets/25cd9780-2761-4ea1-881f-a642b87374d9" />


### 4.5 ¿Cuáles son los motivos_desaparicion más frecuentes según el rango_edad? 
Para responder esta pregunta en Power BI, se utilizó la tabla de hechos `fact_desaparacion` junto con la dimensión `dim_persona` y `dim_motivo`.  
El análisis se enfocó en identificar cuáles son los motivos de desaparición más frecuentes para cada grupo etario.

A partir de los registros de desaparición, se relacionó el motivo de desaparición con el rango de edad correspondiente, permitiendo segmentar los casos entre adolescentes, adultos, adultos mayores, niños(as) y registros sin dato.

Para la visualización, se construyó un gráfico de columnas apiladas con la siguiente configuración:

- **Eje X:** `motivo_desaparicion`
- **Eje Y:** Recuento de `desaparicion_key`
- **Leyenda:** `rango_edad`

<img width="678" height="389" alt="image" src="https://github.com/user-attachments/assets/bed93ef1-3e57-4ae7-b59e-58846940d2e7" />

Con base en los resultados obtenidos, se identificaron los siguientes hallazgos:

- Las causas familiares representan el motivo de desaparición más frecuente en todos los rangos de edad, especialmente en el grupo de adolescentes, donde se concentra la mayor cantidad de casos.
- En segundo lugar se encuentran las causas sociales, nuevamente con una alta participación de adolescentes y adultos.
- Los grupos de adultos también presentan una participación importante en motivos relacionados con causas personales, violencia y extraviados.
- En contraste, los adultos mayores registran una cantidad considerablemente menor de desapariciones en comparación con adolescentes y adultos en casi todas las categorías.
- Los casos relacionados con violencia, extraviado, fallecido y no aplica muestran una distribución más equilibrada entre adolescentes y adultos, aunque siguen predominando los adolescentes.
- Los registros asociados a categorías como causas económicas, posible vinculación a delito, cerrado por fiscalía y discriminación presentan una incidencia baja dentro del total general de desapariciones.
- El gráfico evidencia que el fenómeno de desaparición afecta principalmente a población joven, especialmente adolescentes, lo que sugiere una relación importante entre conflictos familiares/sociales y los reportes de desaparición en Ecuador.
- Asimismo, se observa que los adultos mayores tienen una participación reducida en comparación con otros grupos etarios, indicando que las desapariciones en este segmento ocurren con menor frecuencia y posiblemente responden a contextos distintos a los observados en adolescentes.


## 5. Recomendaciones al negocio

- Como el 57.33% de las denuncias se realizan entre 1 y 3 día, se deben implementar protocolos de búsqueda inmediata. Se debe destinar  recursos y personal de manera prioritaria durante las primeras 72 horas luego de la denuncia.

- Se recomienda priorizar el análisis y seguimiento en Pichincha y Guayas, dado que concentran la mayor cantidad de reportes de desaparecidos y tienen un peso importante en la tendencia nacional. Esto permitiría enfocar mejor los recursos de prevención, búsqueda y respuesta institucional en las provincias donde el problema se presenta con mayor intensidad.

- En cuanto al dataset, al analizar la columna `estado_desaparecido`, se identificó una inconsistencia lógica y semántica que dificulta la interpretación de los datos. Categorías como "DESAPARICIÓN VOLUNTARIA" o "EXTRAVÍO" aparecen como un "estado" actual, cuando se entienden como un motivo incial para el suceso. Se recomienda que el Ministerio del Interior renombre atributos de este tipo por otros más descriptivos o documenten el significado y contexto de cada campo para tener un mejor entendimiendo de estos.

- Existe una irregularidad entre los datos del lugar del suceso y los datos del hallazgo. Mientras que la ubicación de la desaparición está bien estructurada de forma macro a micro (provincia, cantón, distrito, circuito, subcircuito), la ubicación de la localización se limita a la columna `provincia_localizacion`. Si bien el dataset provee coordenadas geográficas de latitud y longitud de localización, estas no son explícitas ni comprensibles a simple vista para el usuario final del dashboard. Se recomienda expandir y completar estos datos para que cuenten con una estructura homogenea entre todo el dataset.

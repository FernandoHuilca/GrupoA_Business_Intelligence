# Informe de Práctica: Inteligencia de Negocios
**Facultad de Ingeniería de Sistemas**

## 1. Introducción
[cite_start]En esta práctica se utilizó Pentaho Data Integration (PDI), una herramienta de la suite de Pentaho escrita en Java[cite: 1, 8]. [cite_start]Se empleó Spoon, que es la interfaz gráfica de usuario (GUI) diseñada para facilitar los procesos de ETL (Extracción, Transformación, Transporte y Carga de datos)[cite: 1, 9, 10, 11].

## 2. Objetivos
* [cite_start]Configurar el entorno de desarrollo para procesos ETL[cite: 5].
* [cite_start]Implementar una "staging area" para la ingesta de datos externos[cite: 6].
* Realizar transformaciones avanzadas sobre formatos de datos modernos (JSON).

## 3. Herramientas Utilizadas
* [cite_start]**Pentaho Community Edition (Spoon):** Diseñador gráfico de transformaciones y trabajos[cite: 9].
* [cite_start]**Java JDK:** Motor de ejecución necesario para el funcionamiento de la suite[cite: 22].
* **Formato JSON:** Origen de datos para el experimento de integración.

## 4. Desarrollo del Experimento
### 4.1 Ejemplo01_Json_Calculator
Se diseñó una transformación (.ktr) que consta de los siguientes pasos:

#### 4.1.1. Extracción (JSON Input)
Se cargó un archivo `carrito.json` que contiene datos jerárquicos. Para su lectura, se configuró el "Loop Path" mediante la ruta `$.[*]`, permitiendo iterar sobre cada objeto del arreglo para extraer campos específicos como producto, precio y cantidad.

#### 4.1.2. Transformación (Calculator)
Se aplicó un procesamiento matemático para generar valor agregado a los datos originales. Se utilizó la operación `A * B` para calcular el campo `Subtotal`, multiplicando el precio unitario por la cantidad de unidades.

#### 4.1.3. Carga (Excel Writer)
Los datos procesados y enriquecidos se exportaron a un formato compatible con herramientas de análisis de oficina (Excel), facilitando su posterior visualización.

### 4.4. Ejemplo 04: XML_Add sequence

#### 4.4.1. Extracción (Get data from XML)
Se cargó el archivo `plant_catalog.xml` que contiene datos en una estructura jerárquica en formato XML.

![](images/EJ04/EJ04_IMG01.png)

Para su lectura, se configuró el componente "Loop XPath" utilizando la ruta `/CATALOG/PLANT`, permitiendo iterar sobre cada elemento PLANT del catálogo y e extraer campos específicos como COMMON (nombre común), ZONE (zona) y PRICE (precio).

 ![](images/EJ04/EJ04_IMG02.png)

Se obtuvieron los datos utilizando el botón `GetFields` y se completó el campo Name.

 ![](images/EJ04/EJ04_IMG03.png)

Se previsualizaron las filas para verificar que se estén leyendo correctamente los datos del archivo .xml.

 ![](images/EJ04/EJ04_IMG04.png)

#### 4.4.2. Transformación (Add Sequence)
Se utilizó el componente Add Sequence para generar un número secuencial de forma automática y añadirlo como una nueva columna a cada registro. En el campo Name of value se definió el nombre `id_planta`, para identificar de manera única a cada elemento extraído.

  ![](images/EJ04/EJ04_IMG05.png)

#### 4.4.3. Carga (XML Output)
Se utilizó el componente XML Output para almacenar los datos transformados en un nuevo archivo en formato XML. Se configuró el nombre del archivo de salida como `output_plant_catalog.xml`.

 ![](images/EJ04/EJ04_IMG06.png)

 
Se especificó el Parent XML element como `catalog` y el Row XML element como `plant`, esto para definir la estructura jerárquica del archivo de salida.

 ![](images/EJ04/EJ04_IMG07.png)

Se organizó el orden de los campos en el formato de salida. En caso de no especificar el Element name, el sistema utiliza por defecto el nombre del campo como etiqueta XML.

 ![](images/EJ04/EJ04_IMG08.png)

 
#### 4.4.4. Resultados
La ejecución fue exitosa.

 ![](images/EJ04/EJ04_IMG09.png)

En la siguiente imagen se puede visualizar el archivo de entrada (sección izquierda) y el archivo de salida (sección derecha), donde ahora se incluye un identificador único para cada planta.

 ![](images/EJ04/EJ04_IMG10.png)

## 5. Resultados
La ejecución fue exitosa, logrando transformar datos crudos de una API simulada en información financiera calculada automáticamente. [cite_start]Este proceso demuestra cómo PDI facilita la construcción y mantenimiento de Data Warehouses[cite: 12].

## 6. Conclusiones
* [cite_start]La arquitectura de Pentaho permite manejar diversos orígenes de datos de forma eficiente a través de su interfaz Spoon[cite: 11].
* El uso de rutas JSON (JSON Path) es fundamental para la correcta interpretación de estructuras de datos complejas en procesos de BI.
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
Se diseñó una transformación (.ktr) que consta de los siguientes pasos:

### 4.1. Extracción (JSON Input)
Se cargó un archivo `carrito.json` que contiene datos jerárquicos. Para su lectura, se configuró el "Loop Path" mediante la ruta `$.[*]`, permitiendo iterar sobre cada objeto del arreglo para extraer campos específicos como producto, precio y cantidad.

### 4.2. Transformación (Calculator)
Se aplicó un procesamiento matemático para generar valor agregado a los datos originales. Se utilizó la operación `A * B` para calcular el campo `Subtotal`, multiplicando el precio unitario por la cantidad de unidades.

### 4.3. Carga (Excel Writer)
Los datos procesados y enriquecidos se exportaron a un formato compatible con herramientas de análisis de oficina (Excel), facilitando su posterior visualización.

## 5. Resultados
La ejecución fue exitosa, logrando transformar datos crudos de una API simulada en información financiera calculada automáticamente. [cite_start]Este proceso demuestra cómo PDI facilita la construcción y mantenimiento de Data Warehouses[cite: 12].

## 6. Conclusiones
* [cite_start]La arquitectura de Pentaho permite manejar diversos orígenes de datos de forma eficiente a través de su interfaz Spoon[cite: 11].
* El uso de rutas JSON (JSON Path) es fundamental para la correcta interpretación de estructuras de datos complejas en procesos de BI.
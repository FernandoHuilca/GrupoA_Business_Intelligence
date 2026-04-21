# <center>**Escuela Politécnica Nacional**</center>
## <center>**Business Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña

------------

## 1. Ejemplo01_Json_Calculator
Se diseñó una transformación (.ktr) que consta de los siguientes pasos:

### 1.1. Extracción (JSON Input)
Se cargó un archivo `carrito.json` que contiene datos jerárquicos. Para su lectura, se configuró el "Loop Path" mediante la ruta `$.[*]`, permitiendo iterar sobre cada objeto del arreglo para extraer campos específicos como producto, precio y cantidad.

### 1.2. Transformación (Calculator)
Se aplicó un procesamiento matemático para generar valor agregado a los datos originales. Se utilizó la operación `A * B` para calcular el campo `Subtotal`, multiplicando el precio unitario por la cantidad de unidades.

### 1.3. Carga (Excel Writer)
Los datos procesados y enriquecidos se exportaron a un formato compatible con herramientas de análisis de oficina (Excel), facilitando su posterior visualización.

---

## 3. Ejemplo 03: Data Grid, Select Values y Concat Fields

### 3.1. Extracción (Data Grid)

Se seleccionó el input "Data Grid" (Tabla simulada que se crea manualmente en Pentaho).

 - Se hizo doble clic en el ícono del input.
 
 - En la pestaña "Meta" se crearon las columnas anio, mes y numero_pedido con el "Type" Integer. 
 
 ![](/Taller_01/images/EJ03/EJ03_IMG01.png)
    
  - En la pestaña "Data" se ingresaron los registros con valores numéricos para cada columna. Por ejemplo:

  ![](/Taller_01/images/EJ03/EJ03_IMG02.png)

### 3.2. Transformación usando Select Values

Se seleccionó el transform "Select Values" para corregir el formato de los números. 
 
 - Se hizo doble clic en el ícono del transform.
 
 - En la pestaña "Meta-data" se pulsó en "Get fields to change" para cargar las columnas del input.
 
 - Se cambió el "Type" de las columnas a "String" y se colocó en "Format" a la estructura deseada para cada columna. Por ejemplo:
 
 ![](/Taller_01/images/EJ03/EJ03_IMG03.png)

### 3.3. Transformación usando Concat Fields

Se seleccionó el transform "Concat Fields" para concatenar las columnas y crear el ID único.

  - Se hizo doble clic en el ícono del transform.
    
  - Se puso en "Target Field Name" el nombre del nuevo campo, por ejemplo "ID_Factura".

  - En "Separator" se colocó el carácter que se desea usar para separar los valores, por ejemplo "-".
  
  ![](/Taller_01/images/EJ03/EJ03_IMG04.png)

### 3.4. Carga (Microsoft Excel Writer)

Para un formato de salida más legible, se seleccionó el output "Microsoft Excel Writer" con el nombre y la ruta deseada para guardar el resultado.

 ![](/Taller_01/images/EJ03/EJ03_IMG05.png)

### 3.5. Resultados

 Ejecución exitosa.

 ![](/Taller_01/images/EJ03/EJ03_IMG06.png)

 Archivo generado satisfactoriamente.

 ![](/Taller_01/images/EJ03/EJ03_IMG07.png)

---

## 4. Ejemplo 04: XML_Add sequence

### 4.1. Extracción (Get data from XML)
Se cargó el archivo `plant_catalog.xml` que contiene datos en una estructura jerárquica en formato XML.

![](images/EJ04/EJ04_IMG01.png)

Para su lectura, se configuró el componente "Loop XPath" utilizando la ruta `/CATALOG/PLANT`, permitiendo iterar sobre cada elemento PLANT del catálogo y e extraer campos específicos como COMMON (nombre común), ZONE (zona) y PRICE (precio).

 ![](images/EJ04/EJ04_IMG02.png)

Se obtuvieron los datos utilizando el botón `GetFields` y se completó el campo Name.

 ![](images/EJ04/EJ04_IMG03.png)

Se previsualizaron las filas para verificar que se estén leyendo correctamente los datos del archivo .xml.

 ![](images/EJ04/EJ04_IMG04.png)

### 4.2. Transformación (Add Sequence)
Se utilizó el componente Add Sequence para generar un número secuencial de forma automática y añadirlo como una nueva columna a cada registro. En el campo Name of value se definió el nombre `id_planta`, para identificar de manera única a cada elemento extraído.

  ![](images/EJ04/EJ04_IMG05.png)

### 4.3. Carga (XML Output)
Se utilizó el componente XML Output para almacenar los datos transformados en un nuevo archivo en formato XML. Se configuró el nombre del archivo de salida como `output_plant_catalog.xml`.

 ![](images/EJ04/EJ04_IMG06.png)
 
Se especificó el Parent XML element como `catalog` y el Row XML element como `plant`, esto para definir la estructura jerárquica del archivo de salida.

 ![](images/EJ04/EJ04_IMG07.png)

Se organizó el orden de los campos en el formato de salida. En caso de no especificar el Element name, el sistema utiliza por defecto el nombre del campo como etiqueta XML.

 ![](images/EJ04/EJ04_IMG08.png)
 
### 4.4. Resultados
La ejecución fue exitosa.

 ![](images/EJ04/EJ04_IMG09.png)

En la siguiente imagen se puede visualizar el archivo de entrada (sección izquierda) y el archivo de salida (sección derecha), donde ahora se incluye un identificador único para cada planta.

 ![](images/EJ04/EJ04_IMG10.png)

## 5. Ejemplo 05: CSV_Sort rows

### 5.1. Extracción (Get data from CSV)
Primero, se cargó el archivo con extensión .csv, denominado Input FactSale.csv. Para su lectura, se configuró el componente "Delimiter" con el valor coma (,), dado que este carácter se utiliza en el archivo para separar los datos en columnas. Además, se marcó la casilla "Header row present?", puesto que el archivo contiene una fila inicial con los nombres de las columnas.

![](images/EJ05/EJ05_IMG01.png)

Luego, se obtuvieron los nombres de las columnas con el botón `GetFields`.

 ![](images/EJ05/EJ05_IMG02.png)

Después, se previsualizaron las filas para verificar que se estén leyendo correctamente los datos del archivo cargado.

 ![](images/EJ05/EJ05_IMG03.png)

### 5.2. Transformación (Sort rows)
Se utilizó el componente Sort Rows con la finalidad de ordenar los registros de venta por las columnas `Invoice Date Key` y `Total Including Tax`. Se agregaron ambas columnas en el componente y en el campo "Ascending" se seleccionó "N" en los dos casos para lograr un orden descendente que muestre primero las fechas más recientes y, dentro de ellas, los valores de venta más altos.


  ![](images/EJ05/EJ05_IMG04.png)

### 5.3. Carga (Microsoft Excel writer)
Se utilizó el componente Microsoft Excel writer para almacenar los datos transformados en un nuevo archivo con extensión .xls. Se configuró el nombre del archivo de salida como `Output FactSale.xls` y se especificó la ruta donde debe almacenarse.

 ![](images/EJ05/EJ05_IMG05.png)

Además, en la pestaña `Content`, se estableció el formato `m/d/yy` para los campos `Invoice Date Key` y `Delivery Date Key`.
 
 ![](images/EJ05/EJ05_IMG06.png)

### 5.4. Resultados

En la siguiente imagen se muestra el archivo de entrada (lado izquierdo) y el archivo de salida (lado derecho), donde ahora los registros de venta están ordenados en forma descendente según la fecha de emisión de la factura y el valor total incluido impuestos.

 ![](images/EJ05/EJ05_IMG07.png)
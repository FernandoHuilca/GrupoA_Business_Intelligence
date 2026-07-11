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
10 de julio de 2026

------------
## **Índice de Contenidos**

[1. Naive Bayes](#1-naive-bayes)
* [1.1. Carga del conjunto de datos](#11-carga-del-conjunto-de-datos)
* [1.2. Configuración del clasificador](#12-configuración-del-clasificador)
* [1.3. Ejecución y resultados del modelo](#13-ejecución-y-resultados-del-modelo)
* [1.4. Implementación del modelo en Python](#14-implementación-del-modelo-en-python)
* [1.5. Ejecución del modelo en Python usando Google Colab](#15-ejecución-del-modelo-en-python-usando-google-colab)

[2. Predecir valores](#2-predecir-valores)
* [2.1. Creación del archivo de prueba](#21-creación-del-archivo-de-prueba)
* [2.2. Carga del conjunto de entrenamiento](#22-carga-del-conjunto-de-entrenamiento)
* [2.3. Construcción del clasificador](#23-construcción-del-clasificador)
* [2.4. Carga del conjunto de prueba](#24-carga-del-conjunto-de-prueba)
* [2.5. Predicción y comparación de resultados](#25-predicción-y-comparación-de-resultados)

[3. Referencias bibliográficas](#3-referencias-bibliográficas)

[4. Declaración de porcentaje de uso de IA](#4-declaración-de-porcentaje-de-uso-de-ia)

------------
# <center>**Association Mining in Weka**</center>
---

## 1. Applying the Apriori Algorithm in Weka on a Real World Dataset

### 1.1. Implementación paso a paso

### 1.2. Análisis de resultados

## 2. Applying the Apriori Algorithm in Weka on a Real World Larger Dataset

### 2.1. Implementación paso a paso

Para empezar con el ejercicio se creó un dataset en Microsoft Excel con los datos proporcionado en el ejercicio. Luego, el archivo se guardó en formato `CSV UTF-8` con el nombre de `DailyItem2 Dataset`.

<img width="738" height="240" alt="image" src="https://github.com/user-attachments/assets/fd43f60b-34e4-4343-a4ed-ad030d73a6fd" />
<img width="185" height="32" alt="image" src="https://github.com/user-attachments/assets/07b408bf-e262-4581-9933-d9cc23927826" />

Luego se cargó el archivo `CSV` creado se debe cargar en Weka.
<img width="1253" height="942" alt="Captura de pantalla 2026-07-08 165717" src="https://github.com/user-attachments/assets/b043e254-d6dd-4eb9-a0ba-c6ce5745f44b" />

Con el archivo cargado, se debe tomar en cuenta que Weka considera todas las columnas como númericas, por lo que es necesario para la asociación utilizar una transformación que convierta los datos númericos, para esto se utiliza la transformación de `NumericToNominal` para aplicarlo en el dataset.

<img width="1255" height="942" alt="image" src="https://github.com/user-attachments/assets/9006ca7e-54a1-48d2-9c89-a250138212b1" />

Luego se removió el campo de `Transacción`. Continuando en la pestaña de Associate se configura el algoritmo Apriori con los siguientes parámetros:
- LowerBoundMinSupport: 0.5
- metricType: Confidence
- minMetric: 0.75
<img width="561" height="802" alt="image" src="https://github.com/user-attachments/assets/e2bf8b34-6628-496d-9ee5-7cb52bb8bd20" />

Estos parámetros configurados se pueden notar al ejecutar el algoritmo:

<img width="1037" height="617" alt="image" src="https://github.com/user-attachments/assets/55c28840-0f95-4972-bb8f-145ffcfd6f95" />

Finalmente los resultados obtenidos son los siguientes:

<img width="786" height="270" alt="image" src="https://github.com/user-attachments/assets/1d0b7408-1b83-471c-811f-07f929dab03c" />

### 2.2. Análisis de resultados
En los resultados que se obtieron de la ejecución con Weka se tiene que Weka ordenó las 4 mejores reglas según su nivel de Confianza (conf). De la menor a la mayor regla se tienen:
- Regla 1: Cornflake $\Rightarrow$ Jam
  * Soporte: Ocurre en 3 transacciones (60% del total de los datos).
  * Confianza (1): 100%. Es la regla más sólida. Cada vez que alguien compró Cornflake (3 veces), las 3     veces llevó Jam.
- Regla 4: Jam $\Rightarrow$ Cornflake
  * Soporte: El antecedente (Jam) aparece 4 veces, y en 3 de ellas se compró Cornflake.
  * Confianza (0.75): 75%. Cumple exactamente con el mínimo exigido.
- Reglas 2 y 3: La relación Jam $\Leftrightarrow$ Bread
  * Tiene un Lift menor a 1 (0.94) indica una correlación negativa o independencia.
  * Indica que el Pan y la Mermelada son productos tan populares individualmente que la probabilidad de que aparezcan juntos en una canasta es alta, siendo que ninguno impulsa realmente la venta del otro.

## 3. Applying the Apriori Algorithm on a Numeric Dataset

### 3.1. Implementación paso a paso

Primero, se creó el dataset en Microsoft Excel con los 9 datos proporcionados en el ejercicio (Ignorando la columna `Name` porque la información real estaba reemplazada por asteriscos). Luego, el archivo se guardó en formato `CSV UTF-8` con el nombre `ejercicio_diez_ocho`.

<img width="965" height="451" alt="image" src="https://github.com/user-attachments/assets/d6b53feb-3f25-41af-8579-4d78d5b178d9" />

**Figura 1.** Guardado del dataset `ejercicio_diez_ocho` en formato CSV.

En Weka, se cargó el archivo filtrando por el formato CSV (Inicialmente solo buscaba por el formato .arff y al buscar por todo tipo de extensión no sucedía nada al momento de cargar el dataset). Al seleccionar el archivo, se dejó la configuración por defecto del cargador de archivos CSV de Weka.



**Figura 2.** Carga del dataset `ejercicio_diez_ocho` en Weka usando el cargador de archivos CSV.

Luego, se eliminó la columna `Roll_No` que era identificador. De esta manera se mantenían solamente los atributos que sí representaban características para la minería de asociación.



**Figura 3.** Eliminación de columnas `Roll_No` y `Name`.

Debido a que el dataset contenía valores numéricos (Siendo el tipo de dato que Apriori no puede usar) se procedió a usar el proceso de `discretizing` o discretizar. Así, se convirtieron los valores numéricos del dataset en categorías (O valores nominales). 

1. Para ello, se utilizó el filtro `Discretize` de Weka a través de la ruta weka/ -> filters/ -> unsupervised/ -> attribute/ -> Discretize/.

2. Al pulsar sobre el filtro `Discretize -B 10 M -1.0 -R first-last`, se abrió una ventana de configuración donde se estableció el número de bins (categorías) en 3 (Low, Medium y High) y se aplicó uno de los tipos de discretización el cuál fue `useEqualFrequency` (Bins con igual cantidad de muestras. Se usó en lugar de Equal interval). Por último se pulsó el botón `OK` y el botón `Apply` a lado del filtro seleccionado para aplicarlo.



**Figura 4.** Uso de filtro `Discretize` con 3 bins y del tipo `useEqualFrequency`.

El resultado fue que cada columna numérica pasó a ser una categoría divididas en 3 bins con rangos automáticos. En MST, por ejemplo, 1 es Low con el rango de (-inf - 11.5], 2 es Medium con el rango de (-11.5 - 16.5] y 3 es High con el rango de (16.5 - inf).



**Figura 5.** Comparación de los valores originales y los valores discretizados en la columna MST.

Finalmente, se ejecutó la minería de asociación con el algoritmo Apriori. Para ello, en la pestaña `Associate`, en `Associator` se seleccionó Apriori en la ruta weka/ -> associations/ -> Apriori/. Luego, se pulsó en el botón `Start` para ejecutar el algoritmo y obtener las reglas de asociación.



**Figura 6.** Resultados de la ejecución del algoritmo Apriori en el dataset discretizado.

### 3.2. Análisis de resultados

Como el dataset usado fue de 9 registros, no fue una muestra representativa. Por tanto, los patrones obtenidos se los puede considerar como una coincidencia en lugar de un resultado real.

- Las 6 primeras reglas son relativas a estudiantes con MST (Mid-Semester Test, nota parcial) bajo con confianza de 1 (100%) y lift de 3 (Muy fuerte). 

  - Todas estas reglas declaran lo mismo desde distintas perspectivas por ser los mismos 3 estudiantes con Lab bajo (<=15.5), ENDSEM bajo (<=17) y total bajo (<=52).

  - Por tanto, el mismo grupo de 3 estudiantes obtuvo todas sus calificaciones malas en cada una de las notas, haciendo que las reglas obtenidas sean intercambiables entre sí.



**Figura 7.** Reglas 1 a 6 obtenidas del algoritmo Apriori en el dataset discretizado.

- En las reglas de la 7 a la 10 sucede exactamente lo mismo, pero para estudiantes con MST medio (11.5 - 16.5) que igual tenían notas regulares en todo como Lab (15.5 - 17.5), ENDSEM (17-23) y total (52.62) con un nota B.



**Figura 8.** Reglas 7 a 10 obtenidas del algoritmo Apriori en el dataset discretizado.



## 4. Process of Performing Manual discretization

### 4.1. Implementación paso a paso
<img width="744" height="579" alt="image" src="https://github.com/user-attachments/assets/297e085c-7f9f-458d-af36-39c6f7e41a7f" />


<img width="617" height="499" alt="image" src="https://github.com/user-attachments/assets/848e9aa0-c41c-41d0-bcd2-1478422fd799" />


<img width="577" height="346" alt="image" src="https://github.com/user-attachments/assets/48c36277-f0d2-45d7-95f1-0d126e472c7a" />

<img width="501" height="310" alt="image" src="https://github.com/user-attachments/assets/e7fd07d3-1035-4487-87c2-1ee62e1df0da" />


<img width="508" height="292" alt="image" src="https://github.com/user-attachments/assets/bc4d199e-c954-4b74-bd0e-cab27043a21b" />

<img width="579" height="379" alt="image" src="https://github.com/user-attachments/assets/778265cd-83a5-4527-bd9c-42cafa8b116e" />

<img width="445" height="506" alt="image" src="https://github.com/user-attachments/assets/471779df-0e55-4cc5-aceb-b9718802dc08" />

<img width="1001" height="754" alt="image" src="https://github.com/user-attachments/assets/237786e8-5a4b-4916-9ec5-b8d072acdf7a" />

<img width="1005" height="866" alt="image" src="https://github.com/user-attachments/assets/14fedaa0-ad3c-4711-b312-1517d9f49206" />

<img width="486" height="326" alt="image" src="https://github.com/user-attachments/assets/8ddea841-651e-40e9-9a2a-2b807c459eae" />

<img width="1007" height="861" alt="image" src="https://github.com/user-attachments/assets/dab528f4-633a-43a0-8f89-8475b6069288" />

<img width="626" height="484" alt="image" src="https://github.com/user-attachments/assets/77f20105-3cd4-4984-adb4-3d469bf46281" />

<img width="1007" height="859" alt="image" src="https://github.com/user-attachments/assets/b1682980-aae0-4ebf-9f59-f2044191f55d" />

<img width="1005" height="862" alt="image" src="https://github.com/user-attachments/assets/53c05744-283b-4672-8247-eaab5bd19bdd" />

<img width="1001" height="863" alt="image" src="https://github.com/user-attachments/assets/80e06102-cefd-4f70-9f85-9ddb385aa687" />


### 4.2. Análisis de resultados
En el primer experimento, utilizando las categorías H, M y L, el algoritmo generó un gran número de reglas con alta precisión. Sin embargo, muchas de ellas involucran el valor M, debido a que representa el 60 % de los registros tras la discretización. Entre las reglas más relevantes destacan aquellas que relacionan un alto desempeño en el Quiz, MST y ENDSEM con la obtención de la calificación A, mientras que un bajo desempeño en ENDSEM se asocia frecuentemente con las calificaciones D y E.

Al activar la opción CAR = true, las reglas se enfocan únicamente en predecir la variable Grade, lo que facilita su interpretación. Las asociaciones más importantes indican que obtener valores altos en varias evaluaciones conduce a la calificación A, mientras que combinar valores bajos en las evaluaciones principales se relaciona con la calificación E.

Finalmente, al reemplazar M por ?, Weka ignora los valores medios durante la generación de reglas. Como resultado, desaparecen muchas asociaciones poco informativas y se obtienen reglas más claras, centradas en los casos extremos (H y L). En conjunto, este último enfoque produce reglas más útiles y fáciles de interpretar para identificar patrones de alto y bajo rendimiento académico.

## 3. Referencias bibliográficas

[1] P. Bhatia, Data Mining and Data Warehousing: Principles and Practical Techniques. Cambridge, U.K.: Cambridge University Press, 2019. doi: 10.1017/9781108635592.

## 4. Declaración de porcentaje de uso de IA

**ChatGPT:**
* Se utilizó para identificar que el archivo de prueba `test.arff` no podía almacenarse en la carpeta `data` de Weka. Inicialmente, el archivo se guardaba en dicha ubicación y la interfaz mostraba un mensaje de éxito; sin embargo, al intentar cargarlo en la pestaña `Preprocess` del módulo `Explorer`, este no aparecía debido a que en realidad nunca se había guardado. Por esta razón, se optó por guardarlo en una carpeta accesible, como `Downloads`.
* Se usó para resolver un inconveniente relacionado con la visualización de la predicción del registro de prueba en la sección `Classifier output`, tal como se mostraba en la guía de la práctica. Se determinó que era necesario seleccionar un formato de salida habilitar en la opción `Output predictions`. Por tal motivo, se eligió `PlainText`, lo que permitió visualizar correctamente la predicción generada por el clasificador.

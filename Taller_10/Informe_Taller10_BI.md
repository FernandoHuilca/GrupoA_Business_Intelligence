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

[1. Applying the Apriori Algorithm in Weka on a Real World Dataset](#1-applying-the-apriori-algorithm-in-weka-on-a-real-world-dataset)
* [1.1. Implementación paso a paso](#11-implementación-paso-a-paso)
* [1.2. Análisis de resultados](#12-análisis-de-resultados)

[2. Applying the Apriori Algorithm in Weka on a Real World Larger Dataset](#2-applying-the-apriori-algorithm-in-weka-on-a-real-world-larger-dataset)
* [2.1. Implementación paso a paso](#21-implementación-paso-a-paso)
* [2.2. Análisis de resultados](#22-análisis-de-resultados)

[3. Applying the Apriori Algorithm on a Numeric Dataset](#3-applying-the-apriori-algorithm-on-a-numeric-dataset)
* [3.1. Implementación paso a paso](#31-implementación-paso-a-paso)
* [3.2. Análisis de resultados](#32-análisis-de-resultados)

[4. Process of Performing Manual discretization](#4-process-of-performing-manual-discretization)
* [4.1. Implementación paso a paso](#41-implementación-paso-a-paso)
* [4.2. Análisis de resultados](#42-análisis-de-resultados)

[5. Referencias bibliográficas](#5-referencias-bibliográficas)

[6. Declaración de porcentaje de uso de IA](#6-declaración-de-porcentaje-de-uso-de-ia)

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

**Figura 1.** Creación del dataset `DailyItem2 Dataset`.

Luego se cargó en Weka el archivo `CSV` creado.
<img width="1253" height="942" alt="Captura de pantalla 2026-07-08 165717" src="https://github.com/user-attachments/assets/b043e254-d6dd-4eb9-a0ba-c6ce5745f44b" />

**Figura 2.** Carga del dataset `DailyItem2 Dataset` en Weka.

Con el archivo cargado, se debe tomar en cuenta que Weka considera todas las columnas como númericas, por lo que es necesario para la asociación utilizar una transformación que convierta los datos númericos, para esto se utiliza la transformación de `NumericToNominal` para aplicarlo en el dataset.

<img width="1255" height="942" alt="image" src="https://github.com/user-attachments/assets/9006ca7e-54a1-48d2-9c89-a250138212b1" />

**Figura 3.** Aplicación del filtro `NumericToNominal` en Weka.

Posteriormente se removió el campo de `Transacción` para luego, en la pestaña de Associate, configurar el algoritmo Apriori con los siguientes parámetros:
- LowerBoundMinSupport: 0.5
- metricType: Confidence
- minMetric: 0.75


<img width="561" height="802" alt="image" src="https://github.com/user-attachments/assets/e2bf8b34-6628-496d-9ee5-7cb52bb8bd20" />

**Figura 4.** Configuración del algoritmo Apriori en Weka.

Estos parámetros configurados se pueden notar al ejecutar el algoritmo:

<img width="1037" height="617" alt="image" src="https://github.com/user-attachments/assets/55c28840-0f95-4972-bb8f-145ffcfd6f95" />

**Figura 5.** Ejecución del algoritmo Apriori en Weka.

Finalmente los resultados obtenidos son los siguientes:

<img width="786" height="270" alt="image" src="https://github.com/user-attachments/assets/1d0b7408-1b83-471c-811f-07f929dab03c" />

**Figura 6.** Resultados obtenidos del algoritmo Apriori en Weka.

### 2.2. Análisis de resultados

En los resultados que se obtuvieron de la ejecución con Weka se tiene que Weka ordenó las 4 mejores reglas según su nivel de Confianza (conf). De la menor a la mayor regla se tienen:

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

<img width="1080" height="456" alt="image" src="https://github.com/user-attachments/assets/a5415675-13a8-4e2a-a95f-363314cebf15" />

**Figura 7.** Guardado del dataset `ejercicio_diez_ocho` en formato CSV.

En Weka, se cargó el archivo filtrando por el formato CSV (Inicialmente solo buscaba por el formato .arff y al buscar por todo tipo de extensión no sucedía nada al momento de cargar el dataset). Al seleccionar el archivo, se dejó la configuración por defecto del cargador de archivos CSV de Weka.

<img width="1095" height="495" alt="image" src="https://github.com/user-attachments/assets/4a6e15d2-1456-4e32-8753-00b47d43b36a" />

**Figura 8.** Carga del dataset `ejercicio_diez_ocho` en Weka usando el cargador de archivos CSV.

Luego, se eliminó la columna `Roll_No` que era identificador. De esta manera se mantenían solamente los atributos que sí representaban características para la minería de asociación.

<img width="1135" height="602" alt="image" src="https://github.com/user-attachments/assets/63f0d11f-5bcf-4be7-8cf9-c108303edd7e" />

**Figura 9.** Eliminación de columnas `Roll_No` y `Name`.

Debido a que el dataset contenía valores numéricos (Siendo el tipo de dato que Apriori no puede usar) se procedió a usar el proceso de `discretizing` o discretizar. Así, se convirtieron los valores numéricos del dataset en categorías (O valores nominales). 

1. Para ello, se utilizó el filtro `Discretize` de Weka a través de la ruta weka/ -> filters/ -> unsupervised/ -> attribute/ -> Discretize/.

2. Al pulsar sobre el filtro `Discretize -B 10 M -1.0 -R first-last`, se abrió una ventana de configuración donde se estableció el número de bins (categorías) en 3 (Low, Medium y High) y se aplicó uno de los tipos de discretización el cuál fue `useEqualFrequency` (Bins con igual cantidad de muestras. Se usó en lugar de Equal interval). Por último se pulsó el botón `OK` y el botón `Apply` a lado del filtro seleccionado para aplicarlo.

<img width="932" height="581" alt="image" src="https://github.com/user-attachments/assets/b0b6944b-64bc-4a5a-b80f-b07cc12d37fe" />

**Figura 10.** Uso de filtro `Discretize` con 3 bins y del tipo `useEqualFrequency`.

El resultado fue que cada columna numérica pasó a ser una categoría divididas en 3 bins con rangos automáticos. En MST, por ejemplo, 1 es Low con el rango de (-inf - 11.5], 2 es Medium con el rango de (-11.5 - 16.5] y 3 es High con el rango de (16.5 - inf).

<img width="1137" height="425" alt="image" src="https://github.com/user-attachments/assets/c9798fa6-0bc7-4598-8ffd-404f9b042e68" />

**Figura 11.** Comparación de los valores originales y los valores discretizados en la columna MST.

Finalmente, se ejecutó la minería de asociación con el algoritmo Apriori. Para ello, en la pestaña `Associate`, en `Associator` se seleccionó Apriori en la ruta weka/ -> associations/ -> Apriori/. Luego, se pulsó en el botón `Start` para ejecutar el algoritmo y obtener las reglas de asociación.

<img width="1135" height="642" alt="image" src="https://github.com/user-attachments/assets/90d4e3cf-953b-4b85-bf7e-08bddd23b506" />

**Figura 12.** Resultados de la ejecución del algoritmo Apriori en el dataset discretizado.

### 3.2. Análisis de resultados

Como el dataset usado fue de 9 registros, no fue una muestra representativa. Por tanto, los patrones obtenidos se los puede considerar como una coincidencia en lugar de un resultado real.

- Las 6 primeras reglas son relativas a estudiantes con MST (Mid-Semester Test, nota parcial) bajo con confianza de 1 (100%) y lift de 3 (Muy fuerte). 

  - Todas estas reglas declaran lo mismo desde distintas perspectivas por ser los mismos 3 estudiantes con Lab bajo (<=15.5), ENDSEM bajo (<=17) y total bajo (<=52).

  - Por tanto, el mismo grupo de 3 estudiantes obtuvo todas sus calificaciones malas en cada una de las notas, haciendo que las reglas obtenidas sean intercambiables entre sí.

<img width="1130" height="357" alt="image" src="https://github.com/user-attachments/assets/baf819ff-825f-4cc4-83af-c0a89679d703" />

**Figura 13.** Reglas 1 a 6 obtenidas del algoritmo Apriori en el dataset discretizado.

- En las reglas de la 7 a la 10 sucede exactamente lo mismo, pero para estudiantes con MST medio (11.5 - 16.5) que igual tenían notas regulares en todo como Lab (15.5 - 17.5), ENDSEM (17-23) y total (52.62) con un nota B.

<img width="1138" height="375" alt="image" src="https://github.com/user-attachments/assets/1d197288-dc42-48c9-ad37-0b0ba80a2928" />

**Figura 14.** Reglas 7 a 10 obtenidas del algoritmo Apriori en el dataset discretizado.

## 4. Process of Performing Manual discretization

### 4.1. Implementación paso a paso

En primer lugar, se creó un archivo de Microsoft Excel denominado student_performance, el cual contiene 60 registros generados aleatoriamente.

<img width="744" height="579" alt="image" src="https://github.com/user-attachments/assets/297e085c-7f9f-458d-af36-39c6f7e41a7f" />

**Figura 15.** Archivo de Excel Student Performance

Posteriormente, se eliminaron las columnas Roll No. y Name, ya que no aportan información relevante para el proceso de Association Mining.

<img width="617" height="499" alt="image" src="https://github.com/user-attachments/assets/848e9aa0-c41c-41d0-bcd2-1478422fd799" />

**Figura 16.** Student Performance sin las dos primeras columnas

A continuación, se ordenó el atributo MST. Dado que el conjunto de datos contiene 60 registros, se seleccionaron los primeros 12 registros y se reemplazó el valor de sus calificaciones en MST por la categoría H.

<img width="501" height="310" alt="image" src="https://github.com/user-attachments/assets/e7fd07d3-1035-4487-87c2-1ee62e1df0da" />

**Figura 17.** Primeros 12 registros del atributo MST cambiados a H

Posteriormente, se seleccionaron los registros comprendidos entre los números 49 y 60, y se reemplazó el valor del atributo MST por la categoría L.

<img width="508" height="292" alt="image" src="https://github.com/user-attachments/assets/bc4d199e-c954-4b74-bd0e-cab27043a21b" />

**Figura 18.** Últimos 12 registros del atributo MST cambiados a L

Finalmente, los 36 registros restantes fueron etiquetados con la categoría M en el atributo MST, representando los valores intermedios del conjunto de datos.

<img width="579" height="379" alt="image" src="https://github.com/user-attachments/assets/778265cd-83a5-4527-bd9c-42cafa8b116e" />

**Figura 19.** Registros intermedios del atributo MST cambiados a M

El proceso de discretización manual se aplicó posteriormente a cada uno de los atributos restantes, siguiendo el mismo procedimiento de clasificación en categorías. Esta transformación permitió convertir los valores numéricos en datos categóricos, dejando el conjunto de datos preparado para su procesamiento en Weka y la posterior obtención de reglas de asociación mediante técnicas de Association Mining.

<img width="445" height="506" alt="image" src="https://github.com/user-attachments/assets/471779df-0e55-4cc5-aceb-b9718802dc08" />

**Figura 20.** Proceso de discretización manual aplicado en todas las columnas

Se guardó el archivo de Excel en formato csv y se lo cargó en Weka.

<img width="1001" height="754" alt="image" src="https://github.com/user-attachments/assets/237786e8-5a4b-4916-9ec5-b8d072acdf7a" />

**Figura 21.** Carga del archivo de registros en Weka

A continuación, se aplicó el algoritmo Apriori desde la pestaña Associate de Weka utilizando el conjunto de datos previamente preparado. Tras la ejecución del algoritmo, se obtuvieron diversas reglas de asociación.

<img width="1005" height="866" alt="image" src="https://github.com/user-attachments/assets/14fedaa0-ad3c-4711-b312-1517d9f49206" />

**Figura 22.** Reglas identificadas con el algoritmo Apriori

Posteriormente, se configuró el algoritmo Apriori para obtener reglas de clasificación estableciendo el parámetro CAR (Class Association Rules) en True. 

<img width="486" height="326" alt="image" src="https://github.com/user-attachments/assets/8ddea841-651e-40e9-9a2a-2b807c459eae" />

**Figura 23.** Configuración de car en true

Con esta configuración, el algoritmo generó únicamente reglas cuyo consecuente corresponde al atributo Grade.

<img width="1007" height="861" alt="image" src="https://github.com/user-attachments/assets/dab528f4-633a-43a0-8f89-8475b6069288" />

**Figura 24.** Reglas identificadas con el algoritmo Apriori (car enabled)

Si no se desea considerar las reglas que incluyen valores M, es posible reprocesar el conjunto de datos reemplazando dicho valor por el símbolo ? en el archivo de Excel. Posteriormente, el archivo se guarda nuevamente en formato CSV y se carga en Weka. En esta herramienta, el símbolo ? representa un valor faltante (missing value); por lo tanto, cualquier registro que contenga este símbolo será ignorado durante la generación de las reglas de asociación.

<img width="626" height="484" alt="image" src="https://github.com/user-attachments/assets/77f20105-3cd4-4984-adb4-3d469bf46281" />

**Figura 25.** M reemplazado por ? en el archivo de excel

A continuación, se presentan las reglas de Association Mining obtenidas tras la ejecución del algoritmo Predictive Apriori en Weka.

<img width="1005" height="862" alt="image" src="https://github.com/user-attachments/assets/53c05744-283b-4672-8247-eaab5bd19bdd" />

**Figura 26.** Reglas identificadas con el algoritmo Apriori (considerando solo L y H)

De igual manera se estableció el parámetro Car en True.

<img width="1001" height="863" alt="image" src="https://github.com/user-attachments/assets/80e06102-cefd-4f70-9f85-9ddb385aa687" />

**Figura 27.** Reglas identificadas con el algoritmo Apriori (considerando solo L y H - car enabled)

### 4.2. Análisis de resultados

En el primer experimento, utilizando las categorías H, M y L, el algoritmo generó un gran número de reglas con alta precisión. Sin embargo, muchas de ellas involucran el valor M, debido a que representa el 60 % de los registros tras la discretización. Entre las reglas más relevantes destacan aquellas que relacionan un alto desempeño en el Quiz, MST y ENDSEM con la obtención de la calificación A, mientras que un bajo desempeño en ENDSEM se asocia frecuentemente con las calificaciones D y E.

Al activar la opción CAR = true, las reglas se enfocan únicamente en predecir la variable Grade, lo que facilita su interpretación. Las asociaciones más importantes indican que obtener valores altos en varias evaluaciones conduce a la calificación A, mientras que combinar valores bajos en las evaluaciones principales se relaciona con la calificación E.

Finalmente, al reemplazar M por ?, Weka ignora los valores medios durante la generación de reglas. Como resultado, desaparecen muchas asociaciones poco informativas y se obtienen reglas más claras, centradas en los casos extremos (H y L). En conjunto, este último enfoque produce reglas más útiles y fáciles de interpretar para identificar patrones de alto y bajo rendimiento académico.

## 5. Referencias bibliográficas

[1] P. Bhatia, Data Mining and Data Warehousing: Principles and Practical Techniques. Cambridge, U.K.: Cambridge University Press, 2019. doi: 10.1017/9781108635592.

## 6. Declaración de porcentaje de uso de IA

**Copilot:**
* Se utilizó para generar el índice de contenidos y para mejorar la redacción de algunas secciones del informe, así como para la revisión de la gramática y ortografía.

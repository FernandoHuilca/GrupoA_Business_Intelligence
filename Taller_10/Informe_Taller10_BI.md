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

Primero, se creó el dataset en Microsoft Excel con los datos proporcionados en el ejercicio. Luego, el archivo se guardó en formato `CSV UTF-8` con el nombre `DailyItem Dataset`, para que posteriormente pueda ser cargado en Weka.

<img width="965" height="451" alt="image" src="https://github.com/user-attachments/assets/d6b53feb-3f25-41af-8579-4d78d5b178d9" />

**Figura 1.** Guardado del dataset `DailyItem Dataset` en formato CSV.



### 3.2. Análisis de resultados

## 4. Process of Performing Manual discretization

### 4.1. Implementación paso a paso

### 4.2. Análisis de resultados

## 3. Referencias bibliográficas

[1] P. Bhatia, Data Mining and Data Warehousing: Principles and Practical Techniques. Cambridge, U.K.: Cambridge University Press, 2019. doi: 10.1017/9781108635592.

## 4. Declaración de porcentaje de uso de IA

**ChatGPT:**
* Se utilizó para identificar que el archivo de prueba `test.arff` no podía almacenarse en la carpeta `data` de Weka. Inicialmente, el archivo se guardaba en dicha ubicación y la interfaz mostraba un mensaje de éxito; sin embargo, al intentar cargarlo en la pestaña `Preprocess` del módulo `Explorer`, este no aparecía debido a que en realidad nunca se había guardado. Por esta razón, se optó por guardarlo en una carpeta accesible, como `Downloads`.
* Se usó para resolver un inconveniente relacionado con la visualización de la predicción del registro de prueba en la sección `Classifier output`, tal como se mostraba en la guía de la práctica. Se determinó que era necesario seleccionar un formato de salida habilitar en la opción `Output predictions`. Por tal motivo, se eligió `PlainText`, lo que permitió visualizar correctamente la predicción generada por el clasificador.

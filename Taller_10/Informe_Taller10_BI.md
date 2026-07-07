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

### 2.2. Análisis de resultados

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

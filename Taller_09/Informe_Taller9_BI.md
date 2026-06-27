# <center>**Escuela Politécnica Nacional**</center>
## <center>**Bussiness Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña
### **Paralelo:**
GR2SW
### **Fecha de entrega:**
30 de junio de 2026

------------
## **Índice de Contenidos**

[MOLAP](#molap)

[1. Proceso ETL](#1-proceso-etl)
* [1.1. Creación de la tabla "raw_salud"](#11-creación-de-la-tabla-raw_salud)
* [1.2. Transformación y carga de datos](#12-transformación-y-carga-de-datos)
  * [1.2.1. dim_fecha](#121-dim_fecha)
  * [1.2.2. dim_paciente](#122-dim_paciente)
  * [1.2.3. dim_departamento_hospital](#123-dim_departamento_hospital)
  * [1.2.4. dim_doctor](#124-dim_doctor)
  * [1.2.5. dim_diagnostico](#125-dim_diagnostico)
  * [1.2.6. dim_procedimiento](#126-dim_procedimiento)
  * [1.2.7. dim_tipo_seguro](#127-dim_tipo_seguro)
  * [1.2.8. dim_resultado](#128-dim_resultado)
  * [1.2.9. fact_atencion_medica](#129-fact_atencion_medica)

[2. Modelo estrella](#2-modelo-estrella)

[3. MOLAP: vista materializada](#3-molap-vista-materializada)

[Consultas MOLAP](#consultas-molap)
* [1. ¿Cuál es el costo total de atención por especialidad, ciudad y mes?](#1-cuál-es-el-costo-total-de-atención-por-especialidad-ciudad-y-mes)
* [2. ¿Qué ciudad tuvo más emergencias por mes y género?](#2-qué-ciudad-tuvo-más-emergencias-por-mes-y-género)
* [3. ¿Por diagnóstico, tipo de seguro, cuál es el costo promedio por visita y en qué ciudad es más alto?](#3-por-diagnóstico-tipo-de-seguro-cuál-es-el-costo-promedio-por-visita-y-en-qué-ciudad-es-más-alto)

[Referencias bibliográficas](#referencias-bibliográficas)  

[Declaración de porcentaje de uso de IA](#declaración-de-porcentaje-de-uso-de-ia)

------------
# <center>**Naive Bayes y Predecir valores**</center>
---

## 1. Naive Bayes

### 1.1. Carga del conjunto de datos

En primer lugar, en `Weka Explorer` se cargó el archivo `weather.nominal.arff`, el cual contiene un conjunto de datos relacionado con condiciones climáticas y la variable de clase `play`. Este dataset permite analizar, mediante clasificación, si bajo determinadas condiciones del clima es conveniente o no jugar. 

<img width="500" alt="image" src="https://github.com/user-attachments/assets/c4bede85-2a64-4b5d-99c1-701df1d50dfa" />

Imagen 1. Carga del archivo `weather.nominal.arff` desde la pestaña `Preprocess` de `Weka Explorer`.

### 1.2. Configuración del clasificador

Posteriormente, en la pestaña `Classify`, se seleccionó el clasificador `NaiveBayes`. En `More options` se conservaron los valores predeterminados y se eligió la opción `Use training set` para entrenar y evaluar el modelo con el conjunto de datos cargado.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/16947ce2-cf71-4afb-9dc2-d74f0798bb92" />

Imagen 2. Selección del clasificador `NaiveBayes` en la pestaña `Classify` de `Weka Explorer`, utilizando la opción `Use training set`.

### 1.3. Ejecución y resultados del modelo

Luego, se seleccionó el botón `Start` para ejecutar el clasificador. Weka construyó el modelo de Naive Bayes y mostró los siguientes resultados de la evaluación sobre el conjunto de entrenamiento.

| <img width="500" alt="image" src="https://github.com/user-attachments/assets/c432628c-9bc5-46ba-b410-263ddf254476" /> | <img width="500" alt="image" src="https://github.com/user-attachments/assets/ed730b40-1184-4004-a711-166acd2e8a08" /> |
|---|---|
| Imagen 3. Información general y modelo generado por el clasificador `NaiveBayes` en Weka. | Imagen 4. Resultados de evaluación del modelo `NaiveBayes`, con 13 de 14 instancias clasificadas correctamente. |

### 1.4. Implementación del modelo en Python

A partir de los datos obtenidos en `Classifier output`, se implementó un código en Python para reproducir el comportamiento del clasificador Naive Bayes y calcular la predicción de la variable `play`.

```Python
def naive_bayes_play(outlook, temperature, humidity, windy): 
    P_yes = 0.63 
    P_no = 0.38 
   
    total_yes = 12.0 
    total_no = 8.0 
 
    probs = { 
        'yes': { 
            'outlook': {'sunny': 3.0 / total_yes, 'overcast': 5.0 / total_yes, 'rainy': 4.0 / total_yes}, 
            'temperature': {'hot': 3.0 / total_yes, 'mild': 5.0 / total_yes, 'cool': 4.0 / total_yes}, 
            'humidity': {'high': 4.0 / 11.0, 'normal': 7.0 / 11.0}, 
            'windy': {'true': 4.0 / 11.0, 'false': 7.0 / 11.0}, 
        }, 
        'no': { 
            'outlook': {'sunny': 4.0 / total_no, 'overcast': 1.0 / total_no, 'rainy': 3.0 / total_no}, 
            'temperature': {'hot': 3.0 / total_no, 'mild': 3.0 / total_no, 'cool': 2.0 / total_no}, 
            'humidity': {'high': 5.0 / 7.0, 'normal': 2.0 / 7.0}, 
            'windy': {'true': 4.0 / 7.0, 'false': 3.0 / 7.0}, 
        } 
    } 
 
    def calc_prob(clase): 
        return ( 
            (P_yes if clase == 'yes' else P_no) * 
            probs[clase]['outlook'][outlook] * 
            probs[clase]['temperature'][temperature] * 
            probs[clase]['humidity'][humidity] * 
            probs[clase]['windy'][windy] 
        ) 
    
    prob_yes = calc_prob('yes') 
    prob_no = calc_prob('no') 
    
    total = prob_yes + prob_no 
    prob_yes /= total 
    prob_no /= total
    
    print(f"\n🔍 Resultados:") 
    print(f"Probabilidad de SÍ jugar: {prob_yes:.4f}") 
    print(f"Probabilidad de NO jugar: {prob_no:.4f}") 
    
    return 'yes' if prob_yes > prob_no else 'no' 

print("Ingrese los datos del clima:")

outlook = input("→ Outlook (sunny / overcast / rainy): ").strip().lower() 
temperature = input("→ Temperature (hot / mild / cool): ").strip().lower() 
humidity = input("→ Humidity (high / normal): ").strip().lower() 
windy = input("→ Windy (true / false): ").strip().lower()
 
prediccion = naive_bayes_play(outlook, temperature, humidity, windy) 
print(f"\n Predicción final: {'JUGAR' if prediccion == 'yes' else 'NO JUGAR'}") 
```
Tabla 1. Implementación en Python del clasificador Naive Bayes para predecir si se debe jugar según las condiciones climáticas ingresadas.

### 1.5. Ejecución del modelo en Python usando Google Colab

Finalmente, se probó el modelo con distintos valores de entrada hasta obtener los dos posibles resultados: **JUGAR** y **NO JUGAR**.

<img width="477" alt="image" src="https://github.com/user-attachments/assets/323a19f7-1aca-43cb-a3f0-45d442180a9e" />

Imagen 5. Ejecución del modelo en Python con una predicción final de **JUGAR**.

<img width="475" alt="image" src="https://github.com/user-attachments/assets/9077165f-babf-45d1-9cb5-b40819a75e5b" />

**Imagen 6.** Ejecución del modelo en Python con una predicción final de **NO JUGAR**.

## 2. Predecir valores

### 2.1. Creación del archivo de prueba

Primero, en la pestaña `Tools`, se seleccionó la opción `ArffViewer`, con el fin de abrir y modificar el conjunto de datos que será utilizado como instancia de prueba.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/1658f0a6-363e-44c7-ae8a-6ada832b12c8" />

Imagen 7. Selección de la opción `ArffViewer` desde el menú `Tools` de Weka.

En la ventana de `ARFF-Viewer`, se abrió el archivo `weather.nominal.arff`. 

<img width="500" alt="image" src="https://github.com/user-attachments/assets/9a1d8e70-161d-4f43-95a5-f136f825e364" />

Imagen 8. Apertura del archivo `weather.nominal.arff` desde la ventana `ARFF-Viewer`.

Después, desde la pestaña `Edit`, se utilizó la opción `Delete instances` para eliminar los registros del archivo, conservando únicamente uno como instancia de prueba para realizar la predicción.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/5a0c1796-a01a-4989-bf25-11395cb84931" />

Imagen 9. Eliminación de registros mediante la opción `Delete instances` de la pestaña `Edit`.

Como siguiente paso, se modificaron los valores del registro restante, asignando las condiciones climáticas que se utilizarán como instancia de prueba para la predicción. Además, se dejó en blanco el atributo de clase `play`, debido a que este es el valor que se desea predecir mediante el clasificador.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/c94d147a-f40e-4971-8369-67e86bc0f7c5" />

Imagen 10. Registro antes de modificar los valores para la prueba.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/008660d6-fa23-4526-9774-67cbad07bd65" />

Imagen 11. Registro modificado con nuevos valores y atributo `play` vacío para realizar la predicción en Weka.

Una vez modificado el registro, se guardó el archivo como `test.arff` en la carpeta `Downloads`.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/a1a76bfd-057f-45cf-abe2-d541b0cb442c" />

Imagen 12. Guardado del archivo de prueba `test.arff` en la carpeta `Downloads`.

### 2.2. Carga del conjunto de entrenamiento

Posteriormente, en la pestaña `Preprocess` del módulo `Explorer`, se abrió nuevamente el archivo `weather.nominal.arff`, puesto que será utilizado como conjunto de entrenamiento para construir el clasificador.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/30f6c435-57ee-45bc-ab07-d7bc45982a10" />

Imagen 13. Apertura del archivo `weather.nominal.arff` en `Weka Explorer`.

### 2.3. Construcción del clasificador

A continuación, en la pestaña `Classify`, se seleccionó `NaiveBayes` como clasificador y se usó la opción `Use training set` para generar el modelo con los datos de entrenamiento.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/4d30dfdf-6338-4982-9b63-8fd31f03de29" />

Imagen 14. Construcción del modelo `NaiveBayes` usando el archivo `weather.nominal.arff` como conjunto de entrenamiento.

### 2.4. Carga del conjunto de prueba

Después de esto, se seleccionó la opción `Supplied test set` y se cargó el archivo `test.arff` como conjunto de prueba.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/2021bce0-78ca-4892-9218-266280bbc4ac" />

Imagen 15. Carga del archivo de prueba `test.arff` mediante la opción `Supplied test set`.

Luego, se dio clic en `More options` y, en la ventana emergente, se seleccionó la opción `PlainText` en `Output predictions` para visualizar la predicción realizada sobre la instancia de prueba.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/b0dd353e-77d0-4d77-9faa-c3c11c4cc2fb" />

Imagen 16. Configuración de `Output predictions` en formato `PlainText` para mostrar la predicción del registro de prueba en la sección `Classifier output`.

### 2.5. Predicción y comparación de resultados

Finalmente, se aplicó el clasificador sobre la instancia de prueba cargada. Como resultado, Weka predijo el valor `yes` para el atributo de clase `play`, con una confianza del 56,8 %.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/af948e06-86b2-48a8-9982-5bd73cb49133" />

Imagen 17. Predicción del registro de prueba con el clasificador `NaiveBayes`.

Adicionalmente, se evaluó el mismo registro de prueba con el clasificador `J48`, correspondiente al árbol de decisión. En este caso, se obtuvo el mismo resultado para el atributo `play`, pero con una confianza del 100 %.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/b3106526-294a-4576-a61d-ec70cfcdb7f2" />

Imagen 18. Predicción del registro de prueba con el clasificador `J48`.

Al comparar ambos modelos, se observa que, para esta instancia específica, el árbol de decisión clasificó el registro con mayor seguridad que Naive Bayes.

## 3. Referencias bibliográficas

[1] P. Bhatia, Data Mining and Data Warehousing: Principles and Practical Techniques. Cambridge, U.K.: Cambridge University Press, 2019. doi: 10.1017/9781108635592.

## 4. Declaración de porcentaje de uso de IA

**ChatGPT:**
* Se utilizó para identificar que el archivo de prueba `test.arff` no podía almacenarse en la carpeta `data` de Weka. Inicialmente, el archivo se guardaba en dicha ubicación y la interfaz mostraba un mensaje de éxito; sin embargo, al intentar cargarlo en la pestaña `Preprocess` del módulo `Explorer`, este no aparecía debido a que en realidad nunca se había guardado. Por esta razón, se optó por guardarlo en una carpeta accesible, como `Downloads`.
* Se usó para resolver un inconveniente relacionado con la visualización de la predicción del registro de prueba en la sección `Classifier output`, tal como se mostraba en la guía de la práctica. Se determinó que era necesario seleccionar un formato de salida habilitar en la opción `Output predictions`. Por tal motivo, se eligió `PlainText`, lo que permitió visualizar correctamente la predicción generada por el clasificador.

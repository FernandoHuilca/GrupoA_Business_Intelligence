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

Se cargó el archivo "weather.nominal.arf"en Weka Explorer.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/c4bede85-2a64-4b5d-99c1-701df1d50dfa" />

En la pestaña "Classify" se seleccionó el clasificador "NaiveBayes", en "More Options" se dejaron los valores por defecto y se seleccionó la opción Use Training Set.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/16947ce2-cf71-4afb-9dc2-d74f0798bb92" />

Se seleccionó "Start", obteniendo los siguientes resultados.

<img width="500" alt="image" src="https://github.com/user-attachments/assets/c432628c-9bc5-46ba-b410-263ddf254476" />

<img width="500" alt="image" src="https://github.com/user-attachments/assets/ed730b40-1184-4004-a711-166acd2e8a08" />

Se utilizó el siguiente código en Python según los datos obtenidos en "Classifier output".

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

Luego, se probó la ejecución del código hasta obtener los 2 resultados posibles.

<img width="477" alt="image" src="https://github.com/user-attachments/assets/323a19f7-1aca-43cb-a3f0-45d442180a9e" />

<img width="475" alt="image" src="https://github.com/user-attachments/assets/9077165f-babf-45d1-9cb5-b40819a75e5b" />

## 2. Predecir valores



<img width="500" alt="image" src="https://github.com/user-attachments/assets/1658f0a6-363e-44c7-ae8a-6ada832b12c8" />

<img width="500" alt="image" src="https://github.com/user-attachments/assets/9a1d8e70-161d-4f43-95a5-f136f825e364" />

<img width="500" alt="image" src="https://github.com/user-attachments/assets/5a0c1796-a01a-4989-bf25-11395cb84931" />

<img width="500" alt="image" src="https://github.com/user-attachments/assets/c94d147a-f40e-4971-8369-67e86bc0f7c5" />

<img width="500" alt="image" src="https://github.com/user-attachments/assets/51406f7a-cd31-4a01-a10a-2a4b994ac0b5" />

Después de modificar los valores del registro, se guardó el archivo como "test.arff".

<img width="500" alt="image" src="https://github.com/user-attachments/assets/a1a76bfd-057f-45cf-abe2-d541b0cb442c" />

Se abrió el archivo "weather.nominal.arff" en la pestaña "Preprocess" del módulo "Explorer".

<img width="500" alt="image" src="https://github.com/user-attachments/assets/30f6c435-57ee-45bc-ab07-d7bc45982a10" />

A continuación, se debe seleccionar la pestaña Classify y elegir el clasificador NaiveBayes. 
Clic en el botón Start, lo que permitirá construir el clasificador. 

<img width="500" alt="image" src="https://github.com/user-attachments/assets/4d30dfdf-6338-4982-9b63-8fd31f03de29" />



## 3. Referencias bibliográficas

[1] P. Bhatia, Data Mining and Data Warehousing: Principles and Practical Techniques. Cambridge, U.K.: Cambridge University Press, 2019. doi: 10.1017/9781108635592.

## 4. Declaración de porcentaje de uso de IA

**ChatGPT:**
* Se utilizó como apoyo en el diseño del modelo estrella, principalmente para revisar en qué tabla debían ubicarse campos como "cost_medicine", "cost_procedure" e "is_emergency", y justificar si correspondían a la tabla de hechos o a una dimensión.
* Se utilizó como apoyo para la elaboración de sentencias SQL grandes, como la creación de la tabla `raw_salud` y de la vista materializada.
* Se usó para analizar un error en Pentaho durante la transformación "carga_raw_salud", relacionado con el mapeo de la columna "visit_id" del archivo CSV hacia la tabla creada en PostgreSQL, debido a un carácter invisible en el encabezado.
* Se utilizó para estructurar la consulta SQL correspondiente a la segunda pregunta analítica (**¿Qué ciudad tuvo más emergencias por mes y género?**), empleando funciones analíticas como `ROW_NUMBER()` para obtener la ciudad con el mayor número de emergencias en cada combinación de mes y género.

**Claude:**
* Se utilizó como apoyo para revisar mejores maneras de plantear las sentencias SQL utilizadas para responder las preguntas planteadas.
* Se utilizó para recordar el funcionamiento de algunos componentes de Pentaho, como Stream lookup.

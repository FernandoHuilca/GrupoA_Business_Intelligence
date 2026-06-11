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
16 de junio de 2026

------------
## **Índice de Contenidos**

1. [Pentaho y PostgreSQL](#pentaho-y-postgresql)
   - [1. Creación de la tabla "raw_desnutricion_infantil" en PostgreSQL](#1-creación-de-la-tabla-raw_desnutricion_infantil-en-postgresql)
   - [2. Creación de tablas de dimensiones y tabla de hechos](#2-creación-de-tablas-de-dimensiones-y-tabla-de-hechos)
   - [3. Carga de los datos desde Pentaho al Staging de PostgreSQL](#3-carga-de-los-datos-desde-pentaho-al-staging-de-postgresql)
   - [4. Transformación y carga de los datos crudos](#4-transformación-y-carga-de-los-datos-crudos-desde-el-staging-a-las-tablas-de-dimensiones-y-tabla-de-hechos)
     - [4.1. dim_child](#41-dim_child)
     - [4.2. dim_status](#42-dim_status)
     - [4.3. dim_location](#43-dim_location)
     - [4.4. dim_date](#44-dim_date)
     - [4.5. fact_measurement](#45-fact_measurement)
   - [5. Creación y ejecución de un job](#5-creación-y-ejecución-de-un-job)
2. [Modelo estrella en Power Pivot](#modelo-estrella-en-power-pivot)
3. [Preguntas contestadas en SQL](#preguntas-contestadas-en-sql)
   - [1. ¿Cuál es el tipo de desnutrición más común por región?](#1-cuál-es-el-tipo-de-desnutrición-más-común-por-región)
   - [2. ¿Cómo varía la desnutrición por edad y género?](#2-cómo-varía-la-desnutrición-por-edad-y-género)
   - [3. ¿Qué instituciones atienden más casos?](#3-qué-instituciones-atienden-más-casos)
------------
# <center>**Tarea MOLAP**</center>
---
## MOLAP

### 1. Modelo estrella

#### 1.1. Inserción de datos en tablas de dimensiones

#### 1.2. Inserción de datos en la tabla de hechos

### 2. Vista multidimensional

### 3. MOLAP (Vista materializada) 

## Consultas MOLAP

### 1. ¿Cuál es el costo total de atención por especialidad,ciudad y mes?

### 2. ¿Qué ciudad tuvo más emergencias por mes y género?

### 3. ¿Por diagnóstico, tipo de seguro,  cuál es el costo promedio por visita y en qué ciudad es más alto?

## Referencias bibliográficas


## Declaración de porcentaje de uso de IA
# <center>**Escuela Politécnica Nacional**</center>
## <center>**Business Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña

------------

# <center>**Caso de Estudio: Modelo conceptual lógico físico estrella**</center>

## **Índice de contenidos**
1. [Archivo 'products.csv'](#archivo-products)
    * [Diagrama del modelo estrella](#diagrama-modelo-estrella-1)
2. [Archivo 'Tabla_Desnormalizada_Ventas.csv'](#archivo-tabla-ventas)
    * [Proceso de normalización](#proceso-normalizacion)
    * [Diagrama del modelo estrella](#diagrama-modelo-estrella-2)
    * [Preguntas contestadas en SQL](#preguntas-contestadas-SQL)

---

## Archivo 'products.csv'

Para obtener el diagrama del modelo estrella del archivo 'products.csv' en Power Pivot, se siguió una serie de pasos para agregar tanto las tablas de dimensiones como la tabla de hechos.

Primero, mediante una consulta SQL, se obtuvo la tabla que se iba a agregar al modelo, incluyendo el encabezado y los registros.

<img width="405" height="547" alt="image" src="https://github.com/user-attachments/assets/3e58c81b-3c53-438f-ab6b-89675f3da54d" />

La tabla se copió y pegó en una hoja de Excel. Luego, se seleccionaron el encabezado y los registros y, en la pestaña *Insert*, se hizo clic en la opción *Table* para que Excel la reconozca como una tabla.

<img width="659" height="499" alt="image" src="https://github.com/user-attachments/assets/dd17ef23-59f5-4397-9a8c-11715fe5d466" />

En la pestaña *Table Design*, se asignó el nombre correspondiente a la tabla creada; en este caso, 'dim_category'.

<img width="1070" height="524" alt="image" src="https://github.com/user-attachments/assets/9bf701c9-8876-410f-8184-7c4610ac0fc2" />

En la pestaña *Power Pivot*, mediante la opción *Add to Data Model*, se añadió la tabla al modelo de datos.

<img width="1457" height="767" alt="image" src="https://github.com/user-attachments/assets/6fe77805-d3ec-437d-819c-b797aac2005e" />

### Diagrama del modelo estrella

Después de añadir todas las tablas de dimensiones ('dim_category', 'dim_subcategory') y la tabla de hechos ('fact_products') al modelo de datos con los pasos mencionados, en la ventana de Power Pivot se seleccionó la opción *Diagram View*. Allí se crearon las relaciones entre las tablas de dimensiones y la tabla de hechos mediante los campos 'category_id' y 'subcategory_id', obteniendo como resultado el diagrama del modelo estrella.

<img width="962" height="548" alt="image" src="https://github.com/user-attachments/assets/daecb81f-a0e9-4a46-936f-240ff340e694" />

## Archivo 'Tabla_Desnormalizada_Ventas.csv'

### Proceso de normalización

Los datos del archivo csv se trasladaron a una tabla en una base de datos.

<img width="810" height="726" alt="image" src="https://github.com/user-attachments/assets/a7bf639a-8950-4230-8262-d5364f8e57c4" />

<img width="872" height="676" alt="image" src="https://github.com/user-attachments/assets/8ada7403-579a-498b-a517-5350ac012f30" />

<img width="874" height="672" alt="image" src="https://github.com/user-attachments/assets/7c0fa71c-b142-489b-bc54-a39f3b8a9c36" />

<img width="871" height="678" alt="image" src="https://github.com/user-attachments/assets/a4bdb480-f906-4e7a-87e8-aff0ee94b6a6" />

<img width="1388" height="719" alt="image" src="https://github.com/user-attachments/assets/b536f1c2-8ce3-42e0-80c7-4f5b7ebdc495" />

Se crearon las tablas de dimensiones y la tabla de hechos.

<img width="415" height="426" alt="image" src="https://github.com/user-attachments/assets/9ac987b3-0693-4d15-9897-af5d72be0dab" />

<img width="419" height="387" alt="image" src="https://github.com/user-attachments/assets/f7016214-0386-4522-86a9-6118996881d9" />

<img width="676" height="543" alt="image" src="https://github.com/user-attachments/assets/5d000a1c-ca76-452f-a542-e0467cfbd761" />

Se insertaron los datos de la tabla creada en un principio (desnormalizada) a cada una de las tablas pertenecientes al modelo estrella.

<img width="1076" height="557" alt="image" src="https://github.com/user-attachments/assets/9665dd16-cc92-4cc2-8d90-f3992f98d1cd" />

<img width="952" height="545" alt="image" src="https://github.com/user-attachments/assets/4ec538a6-c234-4e4a-b1fe-bfb20d8f390b" />

<img width="859" height="425" alt="image" src="https://github.com/user-attachments/assets/ab71cce2-d175-426a-883d-e254031ad59a" />

<img width="857" height="409" alt="image" src="https://github.com/user-attachments/assets/ea9178c8-25f5-4c06-8ac3-b54f35f458b1" />

<img width="924" height="650" alt="image" src="https://github.com/user-attachments/assets/47f2976d-024c-4e70-9876-cab0ec28eadc" />


### Diagrama del modelo estrella

Para el archivo 'Tabla_Desnormalizada_Ventas.csv', se siguieron los mismos pasos aplicados previamente con el archivo 'products.csv' en otro Excel para añadir las tablas de dimensiones y la tabla de hechos al modelo de datos en Power Pivot. Luego, se establecieron las relaciones entre 'dim_product', 'dim_customer' y 'dim_date' con la tabla 'fact_sale', obteniendo así el diagrama del modelo estrella.

<img width="918" height="707" alt="image" src="https://github.com/user-attachments/assets/2ba0aeec-3633-46ff-8b24-65b948138640" />

### Preguntas contestadas en SQL

Después de implementar el esquema estrella del archivo 'Tabla_Desnormalizada_Ventas.csv' en una base de datos en PostgreSQL, las preguntas planteadas se respondieron mediante sentencias SQL, como se muestra a continuación.

#### 1. ¿Cuántas ventas se realizaron por categoría de producto y mes?

<img width="755" height="893" alt="image" src="https://github.com/user-attachments/assets/cca5c1a4-9e55-4537-9f24-de09ae0d5ae1" />



#### 3. ¿Cuál es la cantidad total vendida por producto?

<img width="521" height="523" alt="image" src="https://github.com/user-attachments/assets/00b994a3-76a0-45dc-aced-eafc2ba1414c" />

### 4. ¿Cuál fue la cantidad enviada por mes de envió?

<img width="966" height="966" alt="Captura de pantalla 2026-05-05 182314" src="https://github.com/user-attachments/assets/c1ade080-87db-45fa-a37b-40e8990c5876" />










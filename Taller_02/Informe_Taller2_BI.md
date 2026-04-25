# <center>**Escuela Politécnica Nacional**</center>
## <center>**Business Intelligence**</center>
### **Integrantes:**
- Juan Cofre
- Fernando Huilca
- Sebastián León
- Gregory Salazar
- Mateo Simbaña

------------

# <center>**Caso de Estudio: Ferretería El Tornillo Feliz**</center>

Antes de empezar con el proceso ETL, se guardaron los datos entregados en una base de datos.

Primero, se creó una base de datos 'TornilloFelizBD' en PostgreSQL.

<img width="1166" height="682" alt="Screenshot 2026-04-23 200558" src="https://github.com/user-attachments/assets/204c2c91-05c9-4b0e-a1ef-ec7963e47b58" />

Después, se creó un esquema denominado 'staging'.

<img width="827" height="693" alt="image" src="https://github.com/user-attachments/assets/c50bf38e-40da-463c-8f85-a1a12c2c3317" />

Dentro del esquema 'staging', se generó una tabla 'productos_ferreteria_raw' y se guardaron los datos de los productos entregados por la Ferretería El Tornillo Feliz.

<img width="1143" height="868" alt="Screenshot 2026-04-23 200852" src="https://github.com/user-attachments/assets/54f6294b-0eae-4598-bb15-0e3104305e35" />

## Initial Load

Se procedió con la carga inicial desde Pentaho.

Primeramente, se rellenaron y seleccionaron los campos correspondientes para crear la conexión a la base de datos ubicada en PostgreSQL.

<img width="915" height="838" alt="image" src="https://github.com/user-attachments/assets/75d41420-7993-46e1-84db-0731383ebc21" />

Se probó la conexión antes de continuar, obteniendo un resultado exitoso.

<img width="896" height="770" alt="image" src="https://github.com/user-attachments/assets/21d05c40-6c04-4b08-8629-5a2f9c5aa81d" />

## Extracción

Con el componente de entrada 'Table input', se cargó la tabla 'productos_ferreteria_raw' a través de una sentencia SQL. 

<img width="1357" height="824" alt="image" src="https://github.com/user-attachments/assets/0b518fac-e410-491d-b0fd-d0c82de77ee5" />

Con el botón 'Preview' se visualizó que la tabla se haya cargado correctamente.

<img width="1622" height="761" alt="image" src="https://github.com/user-attachments/assets/6237540e-3650-493e-8034-2c1f9b6ed085" />

## Transformación

### Estandarización columna 'categoria'

En una consulta SQL, se visualizaron los datos del campo 'categoria' de todos los registros de la tabla 'productos_ferreteria_raw' y se agruparon las diferentes variaciones identificadas para una misma categoría, teniendo como resultado lo siguiente.

<img width="1309" height="316" alt="image" src="https://github.com/user-attachments/assets/e050c4eb-d99d-4312-bf20-8ccd8b4479a3" />

Para estandarizar las categorías, se utilizó el componente 'Value Mapper', donde en la columna 'Source' se ingresaron todas las variantes identificadas de cada categoría y, junto a cada una, en la columna 'Target Value', se estableció el nombre al que debían modificarse.

<img width="598" height="426" alt="image" src="https://github.com/user-attachments/assets/5fd9901c-7889-47d0-ac42-94a01f91f093" />

### Estandarización columna 'unidad_medida'



### Eliminación de símbolos innecesarios y cambio de formato de la columna 'precio_unitario'

Precios incluyen el símbolo $.

<img width="1749" height="533" alt="image" src="https://github.com/user-attachments/assets/2e6e5e81-631e-4e8c-a4fd-bab160e2ed94" />

Cambiar el formato de la columna 'precio_unitario' a Number (Decimal).

<img width="1349" height="654" alt="image" src="https://github.com/user-attachments/assets/99ed207d-f38d-42d2-aa8a-6a61c416c311" />

## Carga

Con el componente de salida 'Table output', se configuró la creación de una nueva tabla denominada 'productos_ferreteria_clean' para exportar los datos transformados. Para ello, se especificaron los campos que debía tener, los cuales fueron recuperados de la tabla de entrada.

<img width="1394" height="805" alt="image" src="https://github.com/user-attachments/assets/9a54d2cb-bfbe-4c9c-89f3-f9ade301a34f" />

Luego, se presionó el botón 'SQL' y, seguidamente, 'Execute' en la ventana posterior, obteniendo como resultado la creación exitosa de la nueva tabla.

<img width="1011" height="682" alt="image" src="https://github.com/user-attachments/assets/cdd9fc25-ccbc-47c1-a3c9-a5319c18f4ca" />

Por último, se ejecutaron las transformaciones establecidas para cargar los datos modificados en la tabla 'productos_ferreteria_clean'.

<img width="866" height="566" alt="image" src="https://github.com/user-attachments/assets/e73d94cf-c00e-4c4f-a8cd-1b2cfd62bc21" />

## Resultados

En la base de datos 'TornilloFelizBD', se observa que las categorías y unidades de medida han sido estandarizadas, así como también se eliminaron símbolos innecesarios y se corrigió el formato de la columna de precios. Por lo tanto, la información de los productos se encuentra ahora en una tabla limpia y normalizada dentro de una base de datos central en PostgreSQL, conforme a lo solicitado por el gerente de sistemas de la empresa.











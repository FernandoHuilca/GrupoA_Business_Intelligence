-- Creación de tablas en la base de datos

-- Tabla raw_personas_desaparecidas
CREATE TABLE raw_personas_desaparecidas (
	fecha_desaparicion DATE,
	fecha_denuncia DATE,
	fecha_conocimiento DATE,
	zona VARCHAR(50),
	distrito VARCHAR(50),
	circuito VARCHAR(50),
	subcircuito VARCHAR(50),
	codigo_provincia VARCHAR(5),
	provincia VARCHAR(50),
	codigo_canton VARCHAR(10),
	canton VARCHAR(50),
	dias_solucion INTEGER,
	latitud_desaparicion varchar(100),
	longitud_desaparicion varchar(100),
	sexo VARCHAR(10),
	nacionalidad VARCHAR(30),
	edad INTEGER,
	rango_edad VARCHAR(30),
	etnia VARCHAR(30),
	fecha_localizacion DATE,
	latitud_localizacion varchar(100),
	longitud_localizacion varchar(100),
	provincia_localizacion VARCHAR(50),
	situacion_actual VARCHAR(30),
	motivo_desaparicion VARCHAR(100),
	motivacion_desaparicion_observada VARCHAR(100),
	estado_desaparecido VARCHAR(50)
);



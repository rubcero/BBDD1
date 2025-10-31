BEGIN;
-- Creacion de tablas intermedias para la carga de datos
CREATE TABLE Circuitos_Int(
    Id  TEXT ,
    Referncia TEXT,
    Nombre TEXT,
    Localizacion TEXT,
    Pais TEXT ,
    Longitud TEXT,
    Latitud TEXT,
    Altura TEXT,
    Url TEXT
);
\copy Circuitos_Int FROM './circuits.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


CREATE TABLE Escuderias_Int(
    Id TEXT,
    Referncia TEXT,
    Nombre TEXT,
    Nacionalidad TEXT,
    Url TEXT
);
\copy Escuderias_Int FROM './constructors.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


CREATE TABLE Pilotos_Int(
    Id TEXT ,
    Referencia TEXT ,
    Numero TEXT ,
    Codigo TEXT ,
    Nombre TEXT ,
    Apellido TEXT ,
    Fecha_Nac TEXT ,
    Nacionalidad TEXT ,
    Url TEXT 
);
\copy Pilotos_Int FROM './drivers.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');



CREATE TABLE Tiempo_vuelta_int(
    Id TEXT ,
    Id_piloto TEXT ,
    Vuelta TEXT ,
    Posicion TEXT ,
    Tiempo TEXT ,
    Mls TEXT 
);
\copy Tiempo_vuelta_int FROM './lap_times.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');

CREATE TABLE Pit_stop_int(
    Id_carrera TEXT ,
    Id_piloto TEXT ,
    Num_paradas TEXT ,
    Vueltas TEXT ,
    Tiempo TEXT ,
    Duracion TEXT ,
    Mls TEXT 
);
\copy Pit_stop_int FROM './pit_stops.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


CREATE TABLE Clasificacion_int(
    Id TEXT ,
    Id_carrera TEXT ,
    Id_piloto TEXT ,    
    Id_escuderia TEXT ,
    Num_piloto TEXT ,
    Posicion TEXT ,
    Q1 TEXT ,
    Q2 TEXT ,
    Q3 TEXT 
);
\copy Clasificacion_int FROM './qualifying.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


CREATE TABLE Carrera_Int(
    Id TEXT ,
    Año TEXT ,
    Ronda TEXT ,
    Id_circuito TEXT ,
    Nombre TEXT ,
    Fecha TEXT ,
    Hora TEXT ,
    Url TEXT ,
    FP1_fecha TEXT ,
    FP1_hora TEXT ,
    FP2_fecha TEXT ,
    FP2_hora TEXT ,
    FP3_fecha TEXT ,
    FP3_hora TEXT ,
    Fecha_quali TEXT ,
    Hora_quali TEXT ,
    Fecha_sprint TEXT ,
    Hora_sprint TEXT 
);
\copy Carrera_Int FROM './races.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


CREATE TABLE Resultados_int(
    Id TEXT ,
    Id_gp TEXT ,
    Id_piloto TEXT ,
    Id_escuderia TEXT ,
    Numero TEXT ,
    Pos_parrilla TEXT ,
    Posicion TEXT ,
    Posicion_texto TEXT ,
    Posicion_orden TEXT ,
    Puntos TEXT ,
    Vueltas TEXT ,
    Tiempo TEXT ,
    Tiempo_mls TEXT ,
    Vuelta_rapida TEXT ,
    Puesto_campeonato TEXT ,
    Tiempo_vuelta_rapida TEXT ,
    Velocidad_vuelta_rapida TEXT,
    Id_estado TEXT
);
\copy Resultados_int FROM './results.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');



CREATE TABLE Temporadas_int(
    Año TEXT,
    Url TEXT
);
\copy Temporadas_int FROM './seasons.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


CREATE TABLE Estado_int(
    Id TEXT,
    Estado TEXT
);
\copy Estado_int FROM './status.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');







-- =============================
-- 1. ESCUDERÍA
-- =============================
CREATE TABLE Escuderia (
    EscuderiaRef TEXT,
    Nombre TEXT   ,
    Nacionalidad TEXT ,
    Url TEXT,
    primary key(EscuderiaRef)
);

-- =============================
-- 2. PILOTO
-- =============================
CREATE TABLE Piloto (
    PilotoRef TEXT,
    Nombre TEXT   ,
    Apellido TEXT   ,
    F_nac DATE,
    Nacionalidad TEXT ,
    Numero INT,
    Url TEXT ,
    EscuderiaRef TEXT,
    PRIMARY KEY(PilotoRef)  
);

-- =============================
-- 3. TEMPORADA
-- =============================
CREATE TABLE Temporada (
    Año INT,
    Url TEXT,
    primary key(Año)
);

-- =============================
-- 4. CIRCUITO
-- =============================
CREATE TABLE Circuito (
    CircuitoRef TEXT,
    Nombre TEXT   ,
    Ciudad TEXT ,
    Pais TEXT ,
    Url TEXT ,
    Longitud TEXT,
    Latitud TEXT,
    Altura INT,
    PRIMARY KEY(CircuitoRef)
);

-- =============================
-- 5. GRAN PREMIO
-- =============================
CREATE TABLE GranPremio (
    IdGranPremio INT ,
    Nombre TEXT   ,
    Ronda INT,
    FechaHora DATE,
    Url TEXT ,
    CircuitoRef TEXT ,
    Año INT,
    PRIMARY KEY(IdGranPremio)  
);

-- =============================
-- 6. BOXES
-- =============================
CREATE TABLE Boxes (
    IdBox INT,
    Hora TIME,
    Tiempo TEXT,
     PRIMARY KEY(IdBox)  
);

-- =============================
-- 7. VUELTA
-- =============================
CREATE TABLE Vuelta (
    IdVuelta INT   ,
    N_vuelta INT,
    Posicion INT,
    Tiempo TEXT,
    PRIMARY KEY(IdVuelta)
);

-- =============================
-- 8. CORRE  (Piloto ↔ GranPremio)
-- =============================
CREATE TABLE Corre (
    PilotoRef TEXT ,
    IdGranPremio INT,
    Escuderiaid TEXT,
    Posicion INT,
    Estado TEXT ,
    Puntos TEXT,
    PRIMARY KEY (PilotoRef, IdGranPremio, Escuderiaid)
);

-- =============================
-- 9. CALIFICA  (Piloto ↔ GranPremio)
-- =============================
CREATE TABLE Califica (
    PilotoRef TEXT ,
    IdGranPremio INT,
    Posicion INT,
    Q1  TEXT,
    Q2  TEXT,
    Q3  TEXT,
    PRIMARY KEY (PilotoRef, IdGranPremio)
);

-- =============================
-- 10. HACEVUELTAS (Piloto ↔ Vuelta ↔ GranPremio)
-- =============================
CREATE TABLE HaceVueltas (
    PilotoRef TEXT ,
    IdVuelta INT,
    IdGranPremio INT,
    PRIMARY KEY (PilotoRef, IdVuelta, IdGranPremio)
);

-- =============================
-- 11. REALIZAPITSTOPS (Piloto ↔ Boxes ↔ GranPremio)
-- =============================
CREATE TABLE RealizaPitStops (
    Id INT ,
    PilotoRef TEXT ,
    IdBox INT,
    IdGranPremio INT,
    Hora TIME,
    Tiempo TEXT,
    primary key (id)
);

-----------------------------------------------
-- 1. Cargar Escuderías
-----------------------------------------------
INSERT INTO Escuderia (EscuderiaRef, Nombre, Nacionalidad, Url)
SELECT 
    Referncia AS EscuderiaRef,
    Nombre,
    Nacionalidad,
    Url
FROM Escuderias_Int;

-----------------------------------------------
-- 2. Cargar Pilotos
-----------------------------------------------
INSERT INTO Piloto (PilotoRef, Nombre, Apellido, F_nac, Nacionalidad, Numero, Url)
SELECT 
    Referencia AS PilotoRef,
    Nombre,
    Apellido,
    TO_DATE(Fecha_Nac, 'YYYY-MM-DD') AS F_nac,
    Nacionalidad,
    NULLIF(Numero, '\N')::INT AS Numero,
    Url
FROM Pilotos_Int;

-----------------------------------------------
-- 3. Cargar Temporadas
-----------------------------------------------
INSERT INTO Temporada (Año, Url)
SELECT 
    NULLIF(Año, '\N')::INT,
    Url
FROM Temporadas_int;

-----------------------------------------------
-- 4. Cargar Circuitos
-----------------------------------------------
INSERT INTO Circuito (CircuitoRef, Nombre, Ciudad, Pais, Url, Longitud, Latitud, Altura)
SELECT 
    Referncia AS CircuitoRef,
    Nombre,
    Localizacion AS Ciudad,
    Pais,
    Url,
    Longitud,
    Latitud,
    NULLIF(Altura, '\N')::INT AS Altura
FROM Circuitos_Int;

-----------------------------------------------
-- 5. Cargar Grandes Premios
-----------------------------------------------
INSERT INTO GranPremio (IdGranPremio, Nombre, Ronda, FechaHora, Url, CircuitoRef, Año)
SELECT 
    NULLIF(Id, '')::INT AS IdGranPremio,
    Nombre,
    NULLIF(Ronda, '')::INT AS Ronda,
    TO_TIMESTAMP(Fecha || ' ' || COALESCE(Hora, '00:00:00'), 'YYYY-MM-DD HH24:MI:SS') AS FechaHora,
    Url,
    Id_circuito AS CircuitoRef,
    NULLIF(Año, '\N')::INT AS Año
FROM Carrera_Int;

-----------------------------------------------
-- 6. Cargar Resultados → Corre
-----------------------------------------------
INSERT INTO Corre (PilotoRef, IdGranPremio, EscuderiaId, Posicion, Estado, Puntos)
SELECT DISTINCT ON (Id_piloto, Id_gp, Id_escuderia)
    Id_piloto AS PilotoRef,
    NULLIF(Id_gp, '\N')::INT AS IdGranPremio,
    Id_escuderia AS EscuderiaId,
    NULLIF(Posicion, '')::INT AS Posicion,
    Id_estado AS Estado,
    Puntos
FROM Resultados_int
WHERE Id_piloto IS NOT NULL 
  AND Id_gp IS NOT NULL
  AND Id_escuderia IS NOT NULL
ORDER BY Id_piloto, Id_gp, Id_escuderia, NULLIF(Posicion, '\N')::INT;


-----------------------------------------------
-- 7. Cargar Clasificación → Califica
-----------------------------------------------
INSERT INTO Califica (PilotoRef, IdGranPremio, Posicion, Q1, Q2, Q3)
SELECT 
    Id_piloto AS PilotoRef,
    NULLIF(Id_carrera, '\N')::INT AS IdGranPremio,
    NULLIF(Posicion, '\N')::INT AS Posicion,
    Q1, Q2, Q3
FROM Clasificacion_int;

-----------------------------------------------
-- 8. Cargar Vueltas → HaceVueltas
-----------------------------------------------
INSERT INTO HaceVueltas (PilotoRef, IdVuelta, IdGranPremio)
SELECT 
    Id_piloto AS PilotoRef,
    NULLIF(Vuelta, '\N')::INT AS IdVuelta,
    NULLIF(Id, '\N')::INT AS IdGranPremio
FROM Tiempo_vuelta_int;

-----------------------------------------------
-- 9. Cargar Paradas → RealizaPitStops
-----------------------------------------------
INSERT INTO RealizaPitStops (Id, PilotoRef, IdBox, IdGranPremio, Hora, Tiempo)
SELECT 
    ROW_NUMBER() OVER() AS Id,
    Id_piloto AS PilotoRef,
    NULLIF(Num_paradas, '\N')::INT AS IdBox,
    NULLIF(Id_carrera, '\N')::INT AS IdGranPremio,
    COALESCE(Tiempo, '00:00:00')::TIME AS Hora,
    Tiempo
FROM Pit_stop_int;


ROLLBACK;

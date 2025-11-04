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
    Id_escuderia INT,
    EscuderiaRef TEXT,
    Nombre TEXT   ,
    Nacionalidad TEXT ,
    Url TEXT,
    primary key(Id_escuderia)
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
    Escuderiaid INT,
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

INSERT INTO Escuderia (Id_escuderia,EscuderiaRef, Nombre, Nacionalidad, Url)
SELECT 
    NULLIF(Id, '\N')::INT AS Id_escuderia,
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


-- =============================
-- 5. Cargar Grandes Premios
-- =============================
INSERT INTO GranPremio (IdGranPremio, Nombre, Ronda, FechaHora, Url, CircuitoRef, Año)
SELECT 
    NULLIF(r.Id, '')::INT AS IdGranPremio,
    r.Nombre,
    NULLIF(r.Ronda, '')::INT AS Ronda,
    TO_TIMESTAMP(r.Fecha || ' ' || COALESCE(r.Hora, '00:00:00'), 'YYYY-MM-DD HH24:MI:SS') AS FechaHora,
    r.Url,
    c.Referncia AS CircuitoRef,  
    NULLIF(r.Año, '\N')::INT AS Año
FROM Carrera_Int r
JOIN Circuitos_Int c 
    ON c.Id = r.Id_circuito;  
-----------------------------------------------
-- 6. Cargar Resultados → Corre
-----------------------------------------------
INSERT INTO Corre (PilotoRef, IdGranPremio, EscuderiaId, Posicion, Estado, Puntos)
SELECT DISTINCT ON (pi.Referencia, r.Id_gp, r.Id_escuderia)
    pi.Referencia AS PilotoRef,                       -- <-- referencia textual correcta
    NULLIF(r.Id_gp, '\N')::INT AS IdGranPremio,
    NULLIF (r.Id_escuderia, '\N')::INT AS EscuderiaId,
    NULLIF(r.Posicion, '\N')::INT AS Posicion,
    r.Id_estado AS Estado,
    r.Puntos
FROM Resultados_int r
JOIN Pilotos_Int pi ON pi.Id = r.Id_piloto          -- unimos por el Id numérico original
LEFT JOIN Escuderias_Int ei ON ei.Id = r.Id_escuderia
-- si quieres usar la referencia textual de la escudería en vez del id numérico:
-- SELECT ... ei.Referncia AS EscuderiaId, ... y JOIN por ei.Id = r.Id_escuderia
WHERE r.Id_piloto IS NOT NULL
  AND r.Id_gp IS NOT NULL
  AND r.Id_escuderia IS NOT NULL
ORDER BY pi.Referencia, r.Id_gp, r.Id_escuderia, NULLIF(r.Posicion, '\N')::INT;


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


--Listado de todos los circuitos y número de Grandes Premios que ha albergado
SELECT 
    c.Nombre AS Circuito,
    COUNT(gp.IdGranPremio) AS Num_GrandesPremios
FROM Circuito c
LEFT JOIN GranPremio gp ON gp.CircuitoRef = c.CircuitoRef
GROUP BY c.Nombre
ORDER BY Num_GrandesPremios DESC;

--Número de Grandes Premios corridos y puntos de Ayrton Senna
SELECT 
    p.Nombre || ' ' || p.Apellido AS Piloto,
    COUNT(DISTINCT c.IdGranPremio) AS GrandesPremios_Corridos,
    SUM(CAST(c.Puntos AS NUMERIC)) AS Total_Puntos
FROM Corre c
JOIN Piloto p ON c.PilotoRef = p.PilotoRef
WHERE p.Nombre ILIKE 'Ayrton' AND p.Apellido ILIKE 'Senna'
GROUP BY p.Nombre, p.Apellido;

--Pilotos nacidos después del 31/12/1999 y número de carreras corridas
SELECT 
    p.Nombre,
    p.Apellido,
    COUNT(DISTINCT c.IdGranPremio) AS Num_Carreras
FROM Piloto p
LEFT JOIN Corre c ON p.PilotoRef = c.PilotoRef
WHERE p.F_nac > '1999-12-31'
GROUP BY p.Nombre, p.Apellido
ORDER BY Num_Carreras DESC;

--Escuderías españolas o italianas y número de Grandes Premios corridos
SELECT 
    e.Nombre AS Escuderia,
    e.Nacionalidad,
    COUNT(DISTINCT c.IdGranPremio) AS Num_GrandesPremios
FROM Escuderia e
JOIN Corre c ON e.Id_escuderia = c.EscuderiaId
WHERE e.Nacionalidad ILIKE 'Spanish' 
   OR e.Nacionalidad ILIKE 'Italian'
GROUP BY e.Nombre, e.Nacionalidad
ORDER BY Num_GrandesPremios DESC;

--Vista: pilotos y puntos por temporada
CREATE OR REPLACE VIEW Vista_Pilotos_Temporada AS
SELECT 
    t.Año,
    p.PilotoRef,
    p.Nombre || ' ' || p.Apellido AS Piloto,
    SUM(CAST(c.Puntos AS NUMERIC)) AS Total_Puntos
FROM Corre c
JOIN Piloto p ON c.PilotoRef = p.PilotoRef
JOIN GranPremio gp ON c.IdGranPremio = gp.IdGranPremio
JOIN Temporada t ON gp.Año = t.Año
GROUP BY t.Año, p.PilotoRef, p.Nombre, p.Apellido
ORDER BY t.Año, Total_Puntos DESC;

SELECT * FROM Vista_Pilotos_Temporada;


COMMIT ;

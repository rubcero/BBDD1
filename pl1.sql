BEGIN;



-- Creacion de tablas intermedias para la carga de datos
\echo 'Creando la tabla Circuitos Intermedia'
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
\echo 'Cargando los datos en la tabla Circuitos Intermedia'
\copy Circuitos_Int FROM './circuits.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');

\echo 'Creando la tabla Escudería Intermedia'
CREATE TABLE Escuderias_Int(
    Id TEXT,
    Referncia TEXT,
    Nombre TEXT,
    Nacionalidad TEXT,
    Url TEXT
);
\echo 'Cargando los datos en la tabla Escuderias Intermedia'
\copy Escuderias_Int FROM './constructors.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


\echo 'Creando la tabla Pilotos Intermedia'
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
\echo 'Cargando los datos en la tabla Pilotos Intermedia'
\copy Pilotos_Int FROM './drivers.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


\echo 'Creando la tabla Tiempo Vuelta Intermedia'
CREATE TABLE Tiempo_vuelta_int(
    Id TEXT ,
    Id_piloto TEXT ,
    Vuelta TEXT ,
    Posicion TEXT ,
    Tiempo TEXT ,
    Mls TEXT 
);
\echo 'Cargando los datos en la tabla Tiempo vuelta Intermedia'
\copy Tiempo_vuelta_int FROM './lap_times.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


\echo 'Creando la tabla Pit Stop Intermedia'
CREATE TABLE Pit_stop_int(
    Id_carrera TEXT ,
    Id_piloto TEXT ,
    Num_paradas TEXT ,
    Vueltas TEXT ,
    Tiempo TEXT ,
    Duracion TEXT ,
    Mls TEXT 
);
\echo 'Cargando los datos en la tabla Pit Stop Intermedia'
\copy Pit_stop_int FROM './pit_stops.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


\echo 'Creando la tabla Clasificación Intermedia'
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
\echo 'Cargando los datos en la tabla Clasificación Intermedia'
\copy Clasificacion_int FROM './qualifying.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


\echo 'Creando la tabla Carrera Intermedia'
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
\echo 'Cargando los datos en la tabla Carrera Intermedia'
\copy Carrera_Int FROM './races.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');


\echo 'Creando la tabla Resultados Intermedia'
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
\echo 'Cargando los datos en la tabla Resultados Intermedia'
\copy Resultados_int FROM './results.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');




\echo 'Creando la tabla Temporadas Intermedia'
CREATE TABLE Temporadas_int(
    Año TEXT,
    Url TEXT
);
\echo 'Cargando los datos en la tabla Temporadas Intermedia'
\copy Temporadas_int FROM './seasons.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');



\echo 'Creando la tabla Estado Intermedia'
CREATE TABLE Estado_int(
    Id TEXT,
    Estado TEXT
);
\echo 'Cargando los datos en la tabla Estado Intermedia'
\copy Estado_int FROM './status.csv' WITH (FORMAT csv, HEADER, DELIMITER E',', NULL '\N', ENCODING 'UTF-8');







-- =============================
-- 1. ESCUDERÍA
-- =============================
\echo 'Creando la tabla Escudería'
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
\echo 'Creando la tabla Piloto'
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
\echo 'Creando la tabla Temporada'
CREATE TABLE Temporada (
    Año INT,
    Url TEXT,
    primary key(Año)
);

-- =============================
-- 4. CIRCUITO
-- =============================
\echo 'Creando la tabla Circuito'
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
\echo 'Creando la tabla Gran Premio'
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
\echo 'Creando la tabla Boxes'
CREATE TABLE Boxes (
    IdBox INT,
    Hora TIME,
    Tiempo TEXT,
     PRIMARY KEY(IdBox)  
);

-- =============================
-- 7. VUELTA
-- =============================
\echo 'Creando la tabla Vuelta'
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
\echo 'Creando la tabla Corre'
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
\echo 'Creando la tabla Califica'
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
\echo 'Creando la tabla HaceVueltas'
CREATE TABLE HaceVueltas (
    PilotoRef TEXT ,
    IdVuelta INT,
    IdGranPremio INT,
    PRIMARY KEY (PilotoRef, IdVuelta, IdGranPremio)
);

-- =============================
-- 11. REALIZAPITSTOPS (Piloto ↔ Boxes ↔ GranPremio)
-- =============================
\echo 'Creando la tabla RealizaPitStops'
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
\echo 'Cargando los datos en la tabla Escudería'
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
\echo 'Cargando los datos en la tabla Pilotos'
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
\echo 'Cargando los datos en la tabla Temporadas'
INSERT INTO Temporada (Año, Url)
SELECT 
    NULLIF(Año, '\N')::INT,
    Url
FROM Temporadas_int;

-----------------------------------------------
-- 4. Cargar Circuitos
-----------------------------------------------
\echo 'Cargando los datos en la tabla Circuitos'
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
\echo 'Cargando los datos en la tabla Grandes Premios'
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
\echo 'Cargando los datos en la tabla Corre'
INSERT INTO Corre (PilotoRef, IdGranPremio, EscuderiaId, Posicion, Estado, Puntos)
SELECT DISTINCT ON (pi.Referencia, r.Id_gp, r.Id_escuderia)
    pi.Referencia AS PilotoRef,                       
    NULLIF(r.Id_gp, '\N')::INT AS IdGranPremio,
    NULLIF (r.Id_escuderia, '\N')::INT AS EscuderiaId,
    NULLIF(r.Posicion, '\N')::INT AS Posicion,
    r.Id_estado AS Estado,
    r.Puntos
FROM Resultados_int r
JOIN Pilotos_Int pi ON pi.Id = r.Id_piloto          -- unimos por el Id numérico original
LEFT JOIN Escuderias_Int ei ON ei.Id = r.Id_escuderia
WHERE r.Id_piloto IS NOT NULL
  AND r.Id_gp IS NOT NULL
  AND r.Id_escuderia IS NOT NULL
ORDER BY pi.Referencia, r.Id_gp, r.Id_escuderia, NULLIF(r.Posicion, '\N')::INT;


-----------------------------------------------
-- 7. Cargar Clasificación → Califica
-----------------------------------------------
\echo 'Cargando los datos en la tabla Califica'
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
\echo 'Cargando los datos en la tabla HaceVueltas'
INSERT INTO HaceVueltas (PilotoRef, IdVuelta, IdGranPremio)
SELECT 
    Id_piloto AS PilotoRef,
    NULLIF(Vuelta, '\N')::INT AS IdVuelta,
    NULLIF(Id, '\N')::INT AS IdGranPremio
FROM Tiempo_vuelta_int;

-----------------------------------------------
-- 9. Cargar Paradas → RealizaPitStops
-----------------------------------------------
\echo 'Cargando los datos en la tabla RealizaPitStops'
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


--Pilotos ganadores por temporada entre 2010 y 2015
SELECT vp.Año, vp.Piloto, vp.Total_Puntos
FROM Vista_Pilotos_Temporada vp
WHERE vp.Año BETWEEN 2010 AND 2015
  AND vp.Total_Puntos = (
        SELECT MAX(vp2.Total_Puntos)
        FROM Vista_Pilotos_Temporada vp2
        WHERE vp2.Año = vp.Año
    )
ORDER BY vp.Año;

--Pilotos que han ganado al menos un Gran Premio (posición = 1)
SELECT DISTINCT p.Nombre || ' ' || p.Apellido AS Piloto
FROM Corre c
JOIN Piloto p ON p.PilotoRef = c.PilotoRef
WHERE c.Posicion = 1;

--Número de Grandes Premios por país
SELECT 
    c.Pais,
    COUNT(gp.IdGranPremio) AS Num_GrandesPremios
FROM GranPremio gp
JOIN Circuito c ON c.CircuitoRef = gp.CircuitoRef
GROUP BY c.Pais
ORDER BY Num_GrandesPremios DESC;

--Piloto con la vuelta más rápida en toda la historia
SELECT  p.Nombre,
        p.Apellido,
        v.Tiempo
FROM Piloto p
JOIN HaceVueltas hv
  ON hv.PilotoRef = p.PilotoRef
JOIN Vuelta v
  ON v.IdVuelta = hv.IdVuelta
WHERE v.Tiempo = (
        SELECT MIN(v2.Tiempo)
        FROM Vuelta v2
      );



--Número de paradas en boxes por piloto en el GP de Mónaco 2023

--Pilotos que han participado en más de 100 Grandes Premios
SELECT 
    p.Nombre || ' ' || p.Apellido AS Piloto,
    COUNT(DISTINCT c.IdGranPremio) AS Num_GP
FROM Corre c
JOIN Piloto p ON p.PilotoRef = c.PilotoRef
GROUP BY p.Nombre, p.Apellido
HAVING COUNT(DISTINCT c.IdGranPremio) > 100
ORDER BY Num_GP DESC;

--Trigger auditoria

CREATE TABLE auditoria (
    id_auditoria SERIAL PRIMARY KEY,
    tabla        TEXT      NOT NULL,
    operacion    TEXT      NOT NULL,   -- 'INSERT', 'UPDATE', 'DELETE'
    usuario      TEXT      NOT NULL,
    fecha_hora   TIMESTAMP NOT NULL
);

CREATE OR REPLACE FUNCTION f_auditoria()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO auditoria(tabla, operacion, usuario, fecha_hora)
    VALUES (TG_TABLE_NAME, TG_OP, CURRENT_USER, NOW());

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- PILOTOS--
CREATE TRIGGER trg_aud_pilotos
AFTER INSERT OR UPDATE OR DELETE ON Piloto
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- ESCUDERIAS--
CREATE TRIGGER trg_aud_escuderias
AFTER INSERT OR UPDATE OR DELETE ON Escuderia
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- CIRCUITOS--
CREATE TRIGGER trg_aud_circuitos
AFTER INSERT OR UPDATE OR DELETE ON Circuito
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- GRANDES PREMIOS--
CREATE TRIGGER trg_aud_gp
AFTER INSERT OR UPDATE OR DELETE ON GranPremio
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- BOXES--
CREATE TRIGGER trg_aud_boxes
AFTER INSERT OR UPDATE OR DELETE ON Boxes
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- CORRE--
CREATE TRIGGER trg_aud_corre
AFTER INSERT OR UPDATE OR DELETE ON Corre
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- CALIFICA--
CREATE TRIGGER trg_aud_califica
AFTER INSERT OR UPDATE OR DELETE ON Califica
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- HACEVUELTAS--
CREATE TRIGGER trg_aud_haccevueltas
AFTER INSERT OR UPDATE OR DELETE ON HaceVueltas
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- VUELTA--
CREATE TRIGGER trg_aud_vuelta
AFTER INSERT OR UPDATE OR DELETE ON Vuelta
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- REALIZA PIT_STOP--
CREATE TRIGGER trg_aud_pit_stop
AFTER INSERT OR UPDATE OR DELETE ON RealizaPitStops
FOR EACH ROW EXECUTE FUNCTION f_auditoria();

-- TEMPORADA--
CREATE TRIGGER trg_aud_temporada
AFTER INSERT OR UPDATE OR DELETE ON Temporada
FOR EACH ROW EXECUTE FUNCTION f_auditoria();


--Trigger pilotos
CREATE TABLE puntos_piloto (
    pilotoref      TEXT PRIMARY KEY,
    puntos_totales INTEGER NOT NULL DEFAULT 0
);

INSERT INTO puntos_piloto (pilotoref, puntos_totales)
SELECT 
    c.pilotoref,
    COALESCE(SUM(CAST(NULLIF(c.puntos, '\N') AS FLOAT)), 0) AS puntos_totales
FROM Corre c
GROUP BY c.pilotoref;

CREATE OR REPLACE FUNCTION f_actualiza_puntos_piloto()
RETURNS TRIGGER AS
$$
DECLARE
    v_puntos_nuevo INTEGER;
BEGIN
    -- Convertimos los puntos TEXT -> INTEGER tratando '\N' como 0
    v_puntos_nuevo := COALESCE(NULLIF(NEW.puntos, '\N')::INTEGER, 0);

    -- Si ya existe el piloto, sumamos puntos
    IF EXISTS (SELECT 1 FROM puntos_piloto WHERE pilotoref = NEW.pilotoref) THEN
        UPDATE puntos_piloto
        SET puntos_totales = puntos_totales + v_puntos_nuevo
        WHERE pilotoref = NEW.pilotoref;

    ELSE
        -- Si no existe, lo insertamos
        INSERT INTO puntos_piloto (pilotoref, puntos_totales)
        VALUES (NEW.pilotoref, v_puntos_nuevo);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER trg_puntos_piloto
AFTER INSERT ON Corre
FOR EACH ROW
EXECUTE FUNCTION f_actualiza_puntos_piloto();

--Pruebas
INSERT INTO Corre (PilotoRef, IdGranPremio, EscuderiaId, Posicion, Estado, Puntos)
VALUES (863,1,1,5,2,0);

INSERT INTO Corre (PilotoRef, IdGranPremio, EscuderiaId, Posicion, Estado, Puntos)
VALUES (863,2,1,5,2,10);

INSERT INTO Corre (PilotoRef, IdGranPremio, EscuderiaId, Posicion, Estado, Puntos)
VALUES (863,1,2,5,2,20);

SELECT * FROM puntos_piloto WHERE pilotoref = '863';

--Creacion de usuario
CREATE ROLE admin LOGIN PASSWORD 'admin';
--GRANT ALL PRIVILEGES ON DATABASE pl1 TO admin;

GRANT ALL PRIVILEGES ON DATABASE postgres TO admin;
GRANT ALL PRIVILEGES ON SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO admin;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO admin;

CREATE ROLE gestor LOGIN PASSWORD 'gestor';
GRANT CONNECT ON DATABASE postgres TO gestor;
--GRANT CONNECT ON DATABASE pl1 TO gestor;
GRANT USAGE ON SCHEMA public TO gestor;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public TO gestor;

GRANT SELECT, USAGE
ON ALL SEQUENCES IN SCHEMA public TO gestor;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO gestor;

CREATE ROLE analista_f1 LOGIN PASSWORD 'analista_pass';

GRANT CONNECT ON DATABASE formula1 TO analista_f1;
GRANT USAGE ON SCHEMA public TO analista_f1;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO analista_f1;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO analista_f1;


CREATE ROLE invitado LOGIN PASSWORD 'invitado';

--GRANT CONNECT ON DATABASE pl1 TO invitado;
GRANT CONNECT ON DATABASE postgres TO invitado;
GRANT USAGE ON SCHEMA public TO invitado;

GRANT SELECT ON
    Piloto,
    Escuderia,
    GranPremio,
    Circuito,
    Temporada,
    Corre 
TO invitado;



COMMIT ;

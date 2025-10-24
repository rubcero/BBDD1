BEGIN;
-- Creacion de tablas intermedias para la carga de datos
CREATE TABLE Ciruitos_Int(
    Id  TEXT ,
    Referncia TEXT,
    Nombre TEXT,
    Localizacion TEXT,
    Pais TEXT ,
    Longitud TEXT,
    Latitud TEXT,
    Altura TEXT,
    Url TEXT
)

CREATE TABLE Escuderias_Int(
    Id TEXT,
    Referncia TEXT,
    Nombre TEXT,
    Nacionalidad TEXT,
    Url TEXT,
)

CREATE TABLE Pilotos_Int(
    Id TEXT;
    Referencia TEXT;
    Numero TEXT;
    Codigo TEXT;
    Nombre TEXT;
    Apellido TEXT;
    Fecha_Nac TEXT;
    Nacionalidad TEXT;
    Url TEXT;
)

CREATE TABLE Tiempo_vuelta_int(
    Id TEXT;
    Id_piloto TEXT;
    Vuelta TEXT;
    Posicion TEXT;
    Tiempo TEXT;
    Mls TEXT;
)

CREATE TABLE Pit_stop_int(
    Id_carrera TEXT;
    Id_piloto TEXT;
    Num_paradas TEXT;
    Vueltas TEXT;
    Tiempo TEXT;
    Duracion TEXT;
    Mls TEXT;
)

CREATE TABLE Clasificacion_int(
    Id TEXT;
    Id_carrera TEXT;
    Id_piloto TEXT;    
    Id_escuderia TEXT;
    Num_piloto TEXT;
    Posicion TEXT;
    Q1 TEXT;
    Q2 TEXT;
    Q3 TEXT;
)

CREATE TABLE Carrera_Int(
    Id TEXT;
    Año TEXT;
    Ronda TEXT;
    Id_circuito TEXT;
    Nombre TEXT;
    Fecha TEXT;
    Hora TEXT;
    Url TEXT;
    FP1_fecha TEXT;
    FP1_hora TEXT;
    FP2_fecha TEXT;
    FP2_hora TEXT;
    FP3_fecha TEXT;
    FP3_hora TEXT;
    Fecha_quali TEXT;
    Hora_quali TEXT;
    Fecha_sprint TEXT;
    Hora_sprint TEXT;
)

CREATE TABLE Resultados_int(
    Id TEXT;
    Id_gp TEXT;
    Id_piloto TEXT;
    Id_escuderia TEXT;
    Numero TEXT;
    Pos_parrilla TEXT;
    Posicion TEXT;
    Posicion_texto TEXT;
    Posicion_orden TEXT;
    Puntos TEXT;
    Vueltas TEXT;
    Tiempo TEXT;
    Tiempo_mls TEXT;
    Vuelta_rapida TEXT;
    Puesto_campeonato TEXT;
    Tiempo_vuelta_rapida TEXT;
    Velocidad_vuelta_rapida TEXT;
    Id_estado TEXT;
)

CREATE TABLE Temporadas_int(
    Año TEXT;
    Url TEXT;
)

CREATE TABLE Estado_int(
    Id TEXT;
    Estado TEXT;
)





-- =============================
-- 1. ESCUDERÍA
-- =============================
CREATE TABLE Escuderia (
    EscuderiaRef TEXT  PRIMARY KEY,
    Nombre TEXT  NOT NULL,
    Nacionalidad TEXT ,
    Url TEXT 
);

-- =============================
-- 2. PILOTO
-- =============================
CREATE TABLE Piloto (
    PilotoRef TEXT  PRIMARY KEY,
    Nombre TEXT  NOT NULL,
    Apellido TEXT  NOT NULL,
    F_nac DATE,
    Nacionalidad TEXT ,
    Numero INT,
    Url TEXT ,
    EscuderiaRef TEXT ,
    FOREIGN KEY (EscuderiaRef) REFERENCES Escuderia(EscuderiaRef)
);

-- =============================
-- 3. TEMPORADA
-- =============================
CREATE TABLE Temporada (
    Año INT PRIMARY KEY,
    Url TEXT 
);

-- =============================
-- 4. CIRCUITO
-- =============================
CREATE TABLE Circuito (
    CircuitoRef TEXT  PRIMARY KEY,
    Nombre TEXT  NOT NULL,
    Ciudad TEXT ,
    Pais TEXT ,
    Url TEXT ,
    Longitud DECIMAL(6,3),
    Latitud DECIMAL(9,6),
    Altura INT
);

-- =============================
-- 5. GRAN PREMIO
-- =============================
CREATE TABLE GranPremio (
    IdGranPremio INT PRIMARY KEY  ,
    Nombre TEXT  NOT NULL,
    Ronda INT,
    FechaHora DATE,
    Url TEXT ,
    CircuitoRef TEXT ,
    Año INT,
    FOREIGN KEY (CircuitoRef) REFERENCES Circuito(CircuitoRef),
    FOREIGN KEY (Año) REFERENCES Temporada(Año)
);

-- =============================
-- 6. BOXES
-- =============================
CREATE TABLE Boxes (
    IdBox INT PRIMARY KEY  ,
    Hora TIME,
    Tiempo DECIMAL(5,3)
);

-- =============================
-- 7. VUELTA
-- =============================
CREATE TABLE Vuelta (
    IdVuelta INT PRIMARY KEY  ,
    N_vuelta INT,
    Posicion INT,
    Tiempo DECIMAL(6,3)
);

-- =============================
-- 8. CORRE  (Piloto ↔ GranPremio)
-- =============================
CREATE TABLE Corre (
    PilotoRef TEXT ,
    IdGranPremio INT,
    Posicion INT,
    Estado TEXT ,
    Puntos DECIMAL(4,1),
    PRIMARY KEY (PilotoRef, IdGranPremio),
    FOREIGN KEY (PilotoRef) REFERENCES Piloto(PilotoRef),
    FOREIGN KEY (IdGranPremio) REFERENCES GranPremio(IdGranPremio)
);

-- =============================
-- 9. CALIFICA  (Piloto ↔ GranPremio)
-- =============================
CREATE TABLE Califica (
    PilotoRef TEXT ,
    IdGranPremio INT,
    Posicion INT,
    Q1 DECIMAL(6,3),
    Q2 DECIMAL(6,3),
    Q3 DECIMAL(6,3),
    PRIMARY KEY (PilotoRef, IdGranPremio),
    FOREIGN KEY (PilotoRef) REFERENCES Piloto(PilotoRef),
    FOREIGN KEY (IdGranPremio) REFERENCES GranPremio(IdGranPremio)
);

-- =============================
-- 10. HACEVUELTAS (Piloto ↔ Vuelta ↔ GranPremio)
-- =============================
CREATE TABLE HaceVueltas (
    PilotoRef TEXT ,
    IdVuelta INT,
    IdGranPremio INT,
    PRIMARY KEY (PilotoRef, IdVuelta, IdGranPremio),
    FOREIGN KEY (PilotoRef) REFERENCES Piloto(PilotoRef),
    FOREIGN KEY (IdVuelta) REFERENCES Vuelta(IdVuelta),
    FOREIGN KEY (IdGranPremio) REFERENCES GranPremio(IdGranPremio)
);

-- =============================
-- 11. REALIZAPITSTOPS (Piloto ↔ Boxes ↔ GranPremio)
-- =============================
CREATE TABLE RealizaPitStops (
    Id INT PRIMARY KEY  ,
    PilotoRef TEXT ,
    IdBox INT,
    IdGranPremio INT,
    Hora TIME,
    Tiempo DECIMAL(5,3),
    FOREIGN KEY (PilotoRef) REFERENCES Piloto(PilotoRef),
    FOREIGN KEY (IdBox) REFERENCES Boxes(IdBox),
    FOREIGN KEY (IdGranPremio) REFERENCES GranPremio(IdGranPremio)
);

ROLLBACK;

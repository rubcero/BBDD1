BEGIN;

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

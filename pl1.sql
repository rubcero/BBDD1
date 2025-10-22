BEGIN;

-- =============================
-- 1. ESCUDERÍA
-- =============================
CREATE TABLE Escuderia (
    EscuderiaRef VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Nacionalidad VARCHAR(50),
    Url VARCHAR(255)
);

-- =============================
-- 2. PILOTO
-- =============================
CREATE TABLE Piloto (
    PilotoRef VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    F_nac DATE,
    Nacionalidad VARCHAR(50),
    Numero INT,
    Url VARCHAR(255),
    EscuderiaRef VARCHAR(10),
    FOREIGN KEY (EscuderiaRef) REFERENCES Escuderia(EscuderiaRef)
);

-- =============================
-- 3. TEMPORADA
-- =============================
CREATE TABLE Temporada (
    Año INT PRIMARY KEY,
    Url VARCHAR(255)
);

-- =============================
-- 4. CIRCUITO
-- =============================
CREATE TABLE Circuito (
    CircuitoRef VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Ciudad VARCHAR(100),
    Pais VARCHAR(50),
    Url VARCHAR(255),
    Longitud DECIMAL(6,3),
    Latitud DECIMAL(9,6),
    Altura INT
);

-- =============================
-- 5. GRAN PREMIO
-- =============================
CREATE TABLE GranPremio (
    IdGranPremio INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL,
    Ronda INT,
    FechaHora DATETIME,
    Url VARCHAR(255),
    CircuitoRef VARCHAR(10),
    Año INT,
    FOREIGN KEY (CircuitoRef) REFERENCES Circuito(CircuitoRef),
    FOREIGN KEY (Año) REFERENCES Temporada(Año)
);

-- =============================
-- 6. BOXES
-- =============================
CREATE TABLE Boxes (
    IdBox INT PRIMARY KEY AUTO_INCREMENT,
    Hora TIME,
    Tiempo DECIMAL(5,3)
);

-- =============================
-- 7. VUELTA
-- =============================
CREATE TABLE Vuelta (
    IdVuelta INT PRIMARY KEY AUTO_INCREMENT,
    N_vuelta INT,
    Posicion INT,
    Tiempo DECIMAL(6,3)
);

-- =============================
-- 8. CORRE  (Piloto ↔ GranPremio)
-- =============================
CREATE TABLE Corre (
    PilotoRef VARCHAR(10),
    IdGranPremio INT,
    Posicion INT,
    Estado VARCHAR(50),
    Puntos DECIMAL(4,1),
    PRIMARY KEY (PilotoRef, IdGranPremio),
    FOREIGN KEY (PilotoRef) REFERENCES Piloto(PilotoRef),
    FOREIGN KEY (IdGranPremio) REFERENCES GranPremio(IdGranPremio)
);

-- =============================
-- 9. CALIFICA  (Piloto ↔ GranPremio)
-- =============================
CREATE TABLE Califica (
    PilotoRef VARCHAR(10),
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
    PilotoRef VARCHAR(10),
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
    Id INT PRIMARY KEY AUTO_INCREMENT,
    PilotoRef VARCHAR(10),
    IdBox INT,
    IdGranPremio INT,
    Hora TIME,
    Tiempo DECIMAL(5,3),
    FOREIGN KEY (PilotoRef) REFERENCES Piloto(PilotoRef),
    FOREIGN KEY (IdBox) REFERENCES Boxes(IdBox),
    FOREIGN KEY (IdGranPremio) REFERENCES GranPremio(IdGranPremio)
);

ROLLBACK;

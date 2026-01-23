-- ============================================
-- Creación de la base de datos
-- ============================================
CREATE DATABASE Potencial_Digital_SQL;
GO

-- Usamos la base de datos recién creada
USE Potencial_Digital_SQL;
GO

-- ============================================
-- Tabla CHARLAS
-- Almacena la información principal de cada charla
-- ============================================
CREATE TABLE CHARLAS (
    -- Identificador único de la charla (autoincremta)
    idCharla SMALLINT IDENTITY(1,1) NOT NULL,

    -- Nombre o título de la charla
    nombre VARCHAR(255) NOT NULL,

    -- Información adicional opcional
    informacion_add VARCHAR(MAX),

    -- Fecha y hora principal de la charla
    fecha DATETIME NOT NULL,

    -- Suma total de los votos recibidos
    suma_votos DECIMAL(4,2) DEFAULT 0,

    -- Número de usuarios que han votado
    num_votantes SMALLINT DEFAULT 0,

    -- Puntuación media de la charla (entre 1 y 10)
    puntuacion_media DECIMAL(4,2) DEFAULT 1,

    -- Clave primaria de la tabla
    CONSTRAINT pk_charlas PRIMARY KEY (idCharla),

    -- Restricción para asegurar valores válidos de puntuación
    CONSTRAINT chk_puntuacion CHECK (puntuacion_media BETWEEN 1 AND 10)
);

-- ============================================
-- Tabla USUARIOS
-- Almacena los datos de los usuarios del sistema
-- ============================================
CREATE TABLE USUARIOS (
    -- Identificador único del usuario
    idUsuario SMALLINT IDENTITY(1,1) NOT NULL,

    -- Nombre del usuario
    nombre VARCHAR(100) NOT NULL,

    -- Teléfono del usuario (único)
    telefono CHAR(13) NOT NULL,

    -- Clave primaria
    CONSTRAINT pk_usuarios PRIMARY KEY (idUsuario),

    -- Restricción de unicidad para el teléfono
    CONSTRAINT uq_telefono UNIQUE (telefono)
);

-- ============================================
-- Tabla ASISTENCIAS
-- Relación N:M entre CHARLAS y USUARIOS
-- Indica qué usuarios asisten a qué charlas
-- ============================================
CREATE TABLE ASISTENCIAS (
    -- Clave foránea hacia CHARLAS
    idCharla SMALLINT NOT NULL,

    -- Clave foránea hacia USUARIOS
    idUsuario SMALLINT NOT NULL,

    -- Clave primaria compuesta
    CONSTRAINT pk_asistencias PRIMARY KEY (idCharla, idUsuario),

    -- Relación con CHARLAS
    CONSTRAINT fk_asistencias_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS(idCharla)
        ON DELETE CASCADE,

    -- Relación con USUARIOS
    CONSTRAINT fk_asistencias_usuarios FOREIGN KEY (idUsuario)
        REFERENCES USUARIOS(idUsuario)
        ON DELETE CASCADE
);

-- ============================================
-- Tabla VOTACIONES
-- Relación N:M entre CHARLAS y USUARIOS
-- Indica qué usuarios han votado cada charla
-- ============================================
CREATE TABLE VOTACIONES (
    -- Clave foránea hacia CHARLAS
    idCharla SMALLINT NOT NULL,

    -- Clave foránea hacia USUARIOS
    idUsuario SMALLINT NOT NULL,

    -- Clave primaria compuesta
    CONSTRAINT pk_votaciones PRIMARY KEY (idCharla, idUsuario),

    -- Relación con CHARLAS (no se permite borrar si hay votos)
    CONSTRAINT fk_votaciones_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS(idCharla)
        ON DELETE NO ACTION,

    -- Relación con USUARIOS
    CONSTRAINT fk_votaciones_usuarios FOREIGN KEY (idUsuario)
        REFERENCES USUARIOS(idUsuario)
        ON DELETE NO ACTION
);

-- ============================================
-- Tabla PONENTES
-- Almacena los datos de los ponentes
-- ============================================
CREATE TABLE PONENTES (
    -- Identificador único del ponente
    idPonente SMALLINT IDENTITY(1,1) NOT NULL,

    -- Nombre del ponente
    nombre VARCHAR(100) NOT NULL,

    -- Importe que cobra el ponente
    cobro DECIMAL(6,2) DEFAULT 0.00,

    -- Clave primaria
    CONSTRAINT pk_ponentes PRIMARY KEY (idPonente)
);

-- ============================================
-- Tabla CHARLAPONENTES
-- Relación N:M entre CHARLAS y PONENTES
-- ============================================
CREATE TABLE CHARLAPONENTES (
    -- Clave foránea hacia CHARLAS
    idCharla SMALLINT NOT NULL,

    -- Clave foránea hacia PONENTES
    idPonente SMALLINT NOT NULL,

    -- Clave primaria compuesta
    CONSTRAINT pk_charlaponentes PRIMARY KEY (idCharla, idPonente),

    -- Relación con CHARLAS
    CONSTRAINT fk_cp_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS(idCharla)
        ON DELETE CASCADE,

    -- Relación con PONENTES
    CONSTRAINT fk_cp_ponentes FOREIGN KEY (idPonente)
        REFERENCES PONENTES(idPonente)
        ON DELETE CASCADE
);

-- ==========================

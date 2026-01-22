CREATE TABLE CHARLAS (
    idCharla SMALLINT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    informacion_add VARCHAR(MAX),
    fecha DATETIME NOT NULL,
    suma_votos DECIMAL(4,2) DEFAULT 0,
    num_votantes SMALLINT DEFAULT 0,
    puntuacion_media DECIMAL(4,2) DEFAULT 1,

    CONSTRAINT pk_charlas PRIMARY KEY (idCharla),
    CONSTRAINT chk_puntuacion CHECK (puntuacion_media BETWEEN 1 AND 10)
);

CREATE TABLE USUARIOS (
    idUsuario SMALLINT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono CHAR(13) NOT NULL,

    CONSTRAINT pk_usuarios PRIMARY KEY (idUsuario),
    CONSTRAINT uq_telefono UNIQUE (telefono)
);

CREATE TABLE ASISTENCIAS (
    idCharla SMALLINT NOT NULL,
    idUsuario SMALLINT NOT NULL,

    CONSTRAINT pk_asistencias PRIMARY KEY (idCharla, idUsuario),

    CONSTRAINT fk_asistencias_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS(idCharla)
        ON DELETE CASCADE,

    CONSTRAINT fk_asistencias_usuarios FOREIGN KEY (idUsuario)
        REFERENCES USUARIOS(idUsuario)
        ON DELETE CASCADE
);

CREATE TABLE VOTACIONES (
    idCharla SMALLINT NOT NULL,
    idUsuario SMALLINT NOT NULL,

    CONSTRAINT pk_votaciones PRIMARY KEY (idCharla, idUsuario),

    CONSTRAINT fk_votaciones_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS(idCharla)
        ON DELETE NO ACTION,

    CONSTRAINT fk_votaciones_usuarios FOREIGN KEY (idUsuario)
        REFERENCES USUARIOS(idUsuario)
        ON DELETE NO ACTION
);

CREATE TABLE PONENTES (
    idPonente SMALLINT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    cobro DECIMAL(6,2) DEFAULT 0.00,

    CONSTRAINT pk_ponentes PRIMARY KEY (idPonente)
);

CREATE TABLE CHARLAPONENTES (
    idCharla SMALLINT NOT NULL,
    idPonente SMALLINT NOT NULL,

    CONSTRAINT pk_charlaponentes PRIMARY KEY (idCharla, idPonente),

    CONSTRAINT fk_cp_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS(idCharla)
        ON DELETE CASCADE,

    CONSTRAINT fk_cp_ponentes FOREIGN KEY (idPonente)
        REFERENCES PONENTES(idPonente)
        ON DELETE CASCADE
);

CREATE TABLE FECHAS (
    idCharla SMALLINT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,

    CONSTRAINT pk_fechas PRIMARY KEY (idCharla, fecha, hora),

    CONSTRAINT fk_fechas_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS(idCharla)
        ON DELETE CASCADE
);

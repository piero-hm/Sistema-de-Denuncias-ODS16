USE master
GO

IF DB_ID('dbDenuncias') IS NOT NULL
BEGIN
    ALTER DATABASE dbDenuncias
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE

    DROP DATABASE dbDenuncias
END
GO

CREATE DATABASE dbDenuncias
GO

USE dbDenuncias
GO

CREATE TABLE tblRol(
    id_rol VARCHAR(5) PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100),
    estado VARCHAR(20)
)

CREATE TABLE tblUsuario(
    id_usuario VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    DNI VARCHAR(8) NOT NULL,
    telefono VARCHAR(9),
    correo_electronico VARCHAR(100),
    turno VARCHAR(20),
    estado VARCHAR(20),
    codigo_institucional VARCHAR(20),
    contraseña VARCHAR(50),
    nombre_usuario VARCHAR(50),
    id_rol VARCHAR(5) NOT NULL,

    FOREIGN KEY(id_rol)
    REFERENCES tblRol(id_rol)
)

CREATE TABLE tblCiudadano(
    DNI VARCHAR(8) PRIMARY KEY,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(9),
    correo_electronico VARCHAR(100)
)

CREATE TABLE tblTipoDenuncia(
    ID_tipoDenuncia VARCHAR(5) PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100),
    estado VARCHAR(20)
)

CREATE TABLE tblTipoDelito(
    ID_tipoDelito VARCHAR(5) PRIMARY KEY,
    nombre_delito VARCHAR(100) NOT NULL,
    articulo_legal VARCHAR(100),
    descripcion VARCHAR(150),
    estado VARCHAR(20)
)

CREATE TABLE tblDenuncia(
    id_denuncia VARCHAR(6) PRIMARY KEY,
    numero_denuncia VARCHAR(20) NOT NULL,
    fecha_registro DATE NOT NULL,
    descripcion_hechos VARCHAR(250),
    canal_ingreso VARCHAR(50),
    id_ciudadano VARCHAR(8) NOT NULL,
    id_usuario VARCHAR(5) NOT NULL,
    ID_tipoDenuncia VARCHAR(5) NOT NULL,

    FOREIGN KEY(id_ciudadano)
    REFERENCES tblCiudadano(DNI),

    FOREIGN KEY(id_usuario)
    REFERENCES tblUsuario(id_usuario),

    FOREIGN KEY(ID_tipoDenuncia)
    REFERENCES tblTipoDenuncia(ID_tipoDenuncia)
)

CREATE TABLE tblExpediente(
    id_expediente VARCHAR(6) PRIMARY KEY,
    numero_expediente VARCHAR(20) NOT NULL,
    fecha_apertura DATE NOT NULL,
    estado_expediente VARCHAR(30),
    observaciones VARCHAR(200),
    id_denuncia VARCHAR(6) NOT NULL,

    FOREIGN KEY(id_denuncia)
    REFERENCES tblDenuncia(id_denuncia)
)

CREATE TABLE tblDiligencia(
    id_diligencia VARCHAR(6) PRIMARY KEY,
    tipo_diligencia VARCHAR(100),
    fecha_programada DATE,
    resultado VARCHAR(200),
    observaciones VARCHAR(200),
    id_expediente VARCHAR(6) NOT NULL,

    FOREIGN KEY(id_expediente)
    REFERENCES tblExpediente(id_expediente)
)

CREATE TABLE tblDenunciaDelito(
    id_denuncia VARCHAR(6) NOT NULL,
    ID_tipoDelito VARCHAR(5) NOT NULL,

    PRIMARY KEY(id_denuncia, ID_tipoDelito),

    FOREIGN KEY(id_denuncia)
    REFERENCES tblDenuncia(id_denuncia),

    FOREIGN KEY(ID_tipoDelito)
    REFERENCES tblTipoDelito(ID_tipoDelito)
)

INSERT INTO tblRol VALUES
('R01','Administrador','Control total del sistema','Activo')

INSERT INTO tblRol VALUES
('R02','Investigador','Gestiona denuncias','Activo')

INSERT INTO tblRol VALUES
('R03','Fiscal','Supervisa expedientes','Activo')


INSERT INTO tblTipoDenuncia VALUES
('TD01','Robo','Denuncia por robo','Activo')

INSERT INTO tblTipoDenuncia VALUES
('TD02','Estafa','Denuncia por estafa','Activo')

INSERT INTO tblTipoDenuncia VALUES
('TD03','Violencia Familiar','Denuncia por violencia','Activo')


INSERT INTO tblTipoDelito VALUES
('D01','Hurto','Art.185','Sustracción de bienes','Activo')

INSERT INTO tblTipoDelito VALUES
('D02','Estafa','Art.196','Engaño económico','Activo')

INSERT INTO tblTipoDelito VALUES
('D03','Lesiones','Art.121','Daño físico','Activo')

INSERT INTO tblTipoDelito VALUES
('D04','Amenazas','Art.151','Amenaza verbal o escrita','Activo')


INSERT INTO tblUsuario VALUES
('U001','Juan','Perez','74581236','987654321','juan@mp.gob.pe','Mañana','Activo','MP001','1234','jperez','R01')

INSERT INTO tblUsuario VALUES
('U002','Maria','Lopez','78541236','987654322','maria@mp.gob.pe','Tarde','Activo','MP002','1234','mlopez','R02')

INSERT INTO tblUsuario VALUES
('U003','Luis','Torres','74589632','987654323','luis@mp.gob.pe','Mañana','Activo','MP003','1234','ltorres','R02')

INSERT INTO tblUsuario VALUES
('U004','Ana','Rojas','78541239','987654324','ana@mp.gob.pe','Noche','Activo','MP004','1234','arojas','R03')


INSERT INTO tblCiudadano VALUES
('71874190','Saome Sakura','Gonzales Valenzuela','Satipo','999888777','sakura@gmail.com')

INSERT INTO tblCiudadano VALUES
('45879632','Carlos','Diaz Ramos','Satipo','987111222','carlos@gmail.com')

INSERT INTO tblCiudadano VALUES
('78541236','Andrea','Perez Salas','Satipo','987333444','andrea@gmail.com')

INSERT INTO tblCiudadano VALUES
('74125896','Miguel','Torres Huaman','Satipo','987555666','miguel@gmail.com')

INSERT INTO tblCiudadano VALUES
('78965412','Maria','Lopez Quispe','Satipo','987777888','maria@gmail.com')


INSERT INTO tblDenuncia VALUES
('DN001','DEN-001','2026-06-01','Robo de celular','Presencial','71874190','U002','TD01')

INSERT INTO tblDenuncia VALUES
('DN002','DEN-002','2026-06-02','Estafa bancaria','Virtual','45879632','U003','TD02')

INSERT INTO tblDenuncia VALUES
('DN003','DEN-003','2026-06-03','Agresion familiar','Presencial','78541236','U002','TD03')

INSERT INTO tblDenuncia VALUES
('DN004','DEN-004','2026-06-04','Robo de laptop','Virtual','74125896','U003','TD01')


INSERT INTO tblExpediente VALUES
('EX001','EXP-001','2026-06-02','Abierto','En investigación','DN001')

INSERT INTO tblExpediente VALUES
('EX002','EXP-002','2026-06-03','Abierto','Pendiente de pruebas','DN002')

INSERT INTO tblExpediente VALUES
('EX003','EXP-003','2026-06-05','Cerrado','Caso resuelto','DN003')


INSERT INTO tblDiligencia VALUES
('DL001','Inspección','2026-06-10','Pendiente','Visita al lugar','EX001')

INSERT INTO tblDiligencia VALUES
('DL002','Entrevista','2026-06-12','Realizada','Declaración tomada','EX002')


INSERT INTO tblDenunciaDelito VALUES
('DN001','D01')

INSERT INTO tblDenunciaDelito VALUES
('DN002','D02')

/* Restricción 1: El DNI del ciudadano debe tener exactamente 8 caracteres. */
ALTER TABLE tblCiudadano
ADD CONSTRAINT CK_Ciudadano_DNI
CHECK (LEN(DNI) = 8);

/* Restricción 2: El teléfono del ciudadano debe tener exactamente 9 dígitos. */
ALTER TABLE tblCiudadano
ADD CONSTRAINT CK_Ciudadano_Telefono
CHECK (LEN(telefono) = 9);

/* Restricción 3: El estado del expediente solo puede ser Abierto, Cerrado o En Proceso. */
ALTER TABLE tblExpediente
ADD CONSTRAINT CK_Expediente_Estado
CHECK (estado_expediente IN ('Abierto','Cerrado','En Proceso'));

/* Restricción 4: El estado del rol solo puede ser Activo o Inactivo. */
ALTER TABLE tblRol
ADD CONSTRAINT CK_Rol_Estado
CHECK (estado IN ('Activo','Inactivo'));

/* Restricción 5: La fecha programada de una diligencia no puede ser anterior al año 2025. */
ALTER TABLE tblDiligencia
ADD CONSTRAINT CK_Diligencia_Fecha
CHECK (fecha_programada >= '2025-01-01');
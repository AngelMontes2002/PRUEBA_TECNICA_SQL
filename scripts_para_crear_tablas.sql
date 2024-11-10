-- CREACION DE BASE DE DATOS
CREATE DATABASE PERMISOS;

-- UTILIZAR LA TABLA DE DATOS PERMISOS
USE PERMISOS;
GO


-- CREACION DE TABLAS DE LA PRUEBA TECNICA
CREATE TABLE Permission (
    idPermi BIGINT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(250) NOT NULL,
    Description NVARCHAR(MAX) NULL
	-- CRUD Permissions
    can_create BIT NOT NULL DEFAULT 0,                        -- Permite crear nuevos registros
    can_read BIT NOT NULL DEFAULT 0,                          -- Permite ver registros existentes
    can_update BIT NOT NULL DEFAULT 0,                        -- Permite modificar registros existentes
    can_delete BIT NOT NULL DEFAULT 0,                        -- Permite eliminar registros existentes
    
    -- Data Transfer Permissions
    can_import BIT NOT NULL DEFAULT 0,                        -- Permite importar datos masivamente
    can_export BIT NOT NULL DEFAULT 0                         -- Permite exportar datos del sistema
);
);

CREATE TABLE PermiUser (
    idUser BIGINT IDENTITY(1,1) PRIMARY KEY, 
    idEnty BIGINT NOT NULL, 
    idPermi INT NOT NULL,
    PRIMARY KEY (idUser, idEnty, idPermi),
    FOREIGN KEY (idEnty) REFERENCES Entity(idEnty),
	FOREIGN KEY (idPermi) REFERENCES Permission(idPermi),
    -- Permission Configuration
    perU_include BIT NOT NULL DEFAULT 1,                     -- Indica si el permiso se incluye (1) o se excluye (0) para el usuario
    -- Unique constraint for user-company, permission and entity catalog combination
    CONSTRAINT UQ_UserCompany_Permission_Entity 
        UNIQUE (idPermi, idUser, idEnty)
);

CREATE TABLE Entity (
    idEnty INT IDENTITY(1,1) PRIMARY KEY,
    e_nombre NVARCHAR(255) NOT NULL UNIQUE,                  -- Nombre del modelo Django asociado
    e_descri NVARCHAR(255) NOT NULL,                      -- Descripción del elemento del catálogo de entidades
    -- Status
    e_active BIT NOT NULL DEFAULT 1,                       -- Indica si el elemento del catálogo está activo (1) o inactivo (0)
    -- Configuration
    e_config NVARCHAR(MAX) NULL,-- Configuración adicional para el elemento del catálogo
	
);

CREATE TABLE PermiRole (
    idrol BIGINT IDENTITY(1,1) PRIMARY KEY,
    idEnty BIGINT NOT NULL,
    idPermi BIGINT NOT NULL,
    PRIMARY KEY (idrol, idEnty, idPermi),
    FOREIGN KEY (idPermi) REFERENCES Permission(idPermi)
	FOREIGN KEY (idEnty) REFERENCES Entity(idEnty)
	FOREIGN KEY (PermiUser) REFERENCES PermiUser(idPermi)
);

CREATE TABLE PermiUserRecord (
    idUser INT NOT NULL,
    idEnty INT NOT NULL,
    idregis INT NOT NULL,
    idPermi INT NOT NULL,
    PRIMARY KEY (idUser, idEnty, idregis, idPermi),
    FOREIGN KEY (idPermi) REFERENCES Permission(idPermi)
);

CREATE TABLE PermiRoleRecord (
    idrol INT NOT NULL,
    idEnty INT NOT NULL,
    idregis INT NOT NULL,
    idPermi INT NOT NULL,
    PRIMARY KEY (idrol, idEnty, idregis, idPermi),
    FOREIGN KEY (idPermi) REFERENCES Permission(idPermi)
);

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(50) NOT NULL
);

CREATE TABLE Roles (
	Roleid BIGINT IDENTITY(1,1) PRIMARY KEY,
	company_id BIGINT NOT NULL,

    r_nombre NVARCHAR(255) NOT NULL,                       -- Nombre descriptivo del rol
    r_code NVARCHAR(255) NOT NULL,                         -- Código del rol (agregado basado en unique_together)
    r_description NVARCHAR(MAX) NULL,                      -- Descripción detallada del rol y sus responsabilidades
    r_active BIT NOT NULL DEFAULT 1,                       -- Indica si el rol está activo (1) o inactivo (0)
    CONSTRAINT UQ_Company_RoleCode UNIQUE (company_id, role_code)
);

CREATE TABLE Company (
    -- Primary Key
    id_compa BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para la compañía
    
    -- Company Information
    compa_name NVARCHAR(255) NOT NULL,                        -- Nombre legal completo de la compañía
    compa_tradename NVARCHAR(255) NOT NULL,                   -- Nombre comercial o marca de la compañía
    
    -- Document Information
    compa_doctype NVARCHAR(2) NOT NULL                        -- Tipo de documento de identificación de la compañía
        CONSTRAINT CK_Company_DocType 
        CHECK (compa_doctype IN ('NI', 'CC', 'CE', 'PP', 'OT')),
    compa_docnum NVARCHAR(255) NOT NULL,                      -- Número de identificación fiscal o documento legal de la compañía
    
    -- Location Information
    compa_address NVARCHAR(255) NOT NULL,                     -- Dirección física de la compañía
    compa_city NVARCHAR(255) NOT NULL,                        -- Ciudad donde está ubicada la compañía
    compa_state NVARCHAR(255) NOT NULL,                       -- Departamento o estado donde está ubicada la compañía
    compa_country NVARCHAR(255) NOT NULL,                     -- País donde está ubicada la compañía
    
    -- Contact Information
    compa_industry NVARCHAR(255) NOT NULL,                    -- Sector industrial al que pertenece la compañía
    compa_phone NVARCHAR(255) NOT NULL,                       -- Número de teléfono principal de la compañía
    compa_email NVARCHAR(255) NOT NULL,                       -- Dirección de correo electrónico principal de la compañía
    compa_website NVARCHAR(255) NULL,                         -- Sitio web oficial de la compañía
    
    -- Media
    compa_logo NVARCHAR(MAX) NULL,                           -- Logo oficial de la compañía
    
    -- Status
    compa_active BIT NOT NULL DEFAULT 1                       -- Indica si la compañía está activa (1) o inactiva (0)
);

CREATE TABLE UserRole (
    idUser INT NOT NULL,
    idrol INT NOT NULL,
    PRIMARY KEY (idUser, idrol),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (Roleid) REFERENCES Roles(RoleID)
);

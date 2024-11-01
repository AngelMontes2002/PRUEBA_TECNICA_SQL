-- CREACION DE BASE DE DATOS
CREATE DATABASE PERMISOS;

-- UTILIZAR LA TABLA DE DATOS PERMISOS
USE PERMISOS;
GO


-- CREACION DE TABLAS DE LA PRUEBA TECNICA
CREATE TABLE Permission (
    idPermi INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);

CREATE TABLE PermiUser (
    idUser INT NOT NULL, 
    idEnty INT NOT NULL, 
    idPermi INT NOT NULL,
    PRIMARY KEY (idUser, idEnty, idPermi),
    FOREIGN KEY (idPermi) REFERENCES Permission(idPermi)
);

CREATE TABLE PermiRole (
    idrol INT NOT NULL,
    idEnty INT NOT NULL,
    idPermi INT NOT NULL,
    PRIMARY KEY (idrol, idEnty, idPermi),
    FOREIGN KEY (idPermi) REFERENCES Permission(idPermi)
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
	Roleid INT PRIMARY KEY,
    nombrerol NVARCHAR(50) NOT NULL
);

CREATE TABLE UserRole (
    idUser INT NOT NULL,
    idrol INT NOT NULL,
    PRIMARY KEY (idUser, idrol),
    FOREIGN KEY (idUser) REFERENCES Users(UserID),
    FOREIGN KEY (idrol) REFERENCES Roles(RoleID)
);
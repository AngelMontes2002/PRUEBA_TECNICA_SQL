-- Insertar usuarios
INSERT INTO Users (UserName) VALUES ('Angel');
INSERT INTO Users (UserName) VALUES ('Maria');
INSERT INTO Users (UserName) VALUES ('Antonio');
INSERT INTO Users (UserName) VALUES ('Fredy');
INSERT INTO Users (UserName) VALUES ('Juan');

-- Insertar roles
INSERT INTO Roles (Roleid, nombrerol) VALUES (1, 'ADMIN');
INSERT INTO Roles (Roleid, nombrerol) VALUES (2, 'SUPERVISOR');
INSERT INTO Roles (Roleid, nombrerol) VALUES (3, 'ASISTENTE');
INSERT INTO Roles (Roleid, nombrerol) VALUES (4, 'APRENDIZ');
INSERT INTO Roles (Roleid, nombrerol) VALUES (5, 'AUDITOR');

-- Asignar roles a usuarios en la tabla UserRole
INSERT INTO UserRole (idUser, idrol) VALUES (1, 1);
INSERT INTO UserRole (idUser, idrol) VALUES (2, 2); 
INSERT INTO UserRole (idUser, idrol) VALUES (3, 3);
INSERT INTO UserRole (idUser, idrol) VALUES (4, 4);
INSERT INTO UserRole (idUser, idrol) VALUES (5, 5);

-- Insertando Permisos 
INSERT INTO Permission (nombre, Description) VALUES ('Admin', 'Permision para administrador');
INSERT INTO Permission (nombre, Description) VALUES ('Supervisor', 'Permision para Supervisor');
INSERT INTO Permission (nombre, Description) VALUES ('Empleado', 'Permision para empleado');

-- permisos a usuarios
INSERT INTO PermiUser (idUser, idEnty, idPermi) VALUES (1, 101, 1);

-- permisos a roles
INSERT INTO PermiRole (idrol, idEnty, idPermi) VALUES (2, 101, 2); 

-- permisos de registro a usuarios específicos
INSERT INTO PermiUserRecord (idUser, idEnty, idregis, idPermi) VALUES (1, 101, 2001, 1);

-- Ejemplo: Asignando permisos de registro a roles específicos
INSERT INTO PermiRoleRecord (idrol, idEnty, idregis, idPermi) VALUES (2, 101, 2001, 2);

select * from PermiRole
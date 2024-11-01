-- CONSULTA QUE USUARIO Y QUE ROL TIENE
SELECT 
u.userName AS NOMBRE,
r.nombrerol AS ROLES
FROM Users u
JOIN UserRole ur ON ur.idUser = u.UserID
JOIN Roles r ON ur.idrol = r.Roleid;

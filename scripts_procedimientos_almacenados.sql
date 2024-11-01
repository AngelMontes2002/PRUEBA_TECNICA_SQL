CREATE PROCEDURE GetUserPermissions 
    @idUser INT,
    @idEnty INT
AS
BEGIN
-- Permisos a nivel de entidad

    SELECT 
        'User' AS PermissionType,
        p.nombre AS PermissionName,
        pu.idEnty 
    FROM 
        PermiUser pu
    JOIN 
        Permission p ON pu.idPermi = p.idPermi
    WHERE 
        pu.idUser = @idUser 
        AND pu.idEnty = @idEnty
    
    UNION ALL

    SELECT 
        'Role' AS PermissionType,
        p.nombre AS PermissionName,
        pr.idEnty
    FROM 
        PermiRole pr
    JOIN 
        Permission p ON pr.idPermi = p.idPermi
    JOIN 
        UserRole ur ON ur.idrol = pr.idrol
    WHERE 
        ur.idUser = @idUser 
        AND pr.idEnty = @idEnty;
-- Permisos a nivel de registro individual

 SELECT 
        'UserRecord' AS PermissionType,
        p.nombre AS PermissionName,
        pur.idregis
    FROM 
        PermiUserRecord pur
    JOIN 
        Permission p ON pur.idPermi = p.idPermi
    WHERE 
        pur.idUser = @idUser 
        AND pur.idEnty = @idEnty

    UNION ALL

    SELECT 
        'RoleRecord' AS PermissionType,
        p.nombre AS PermissionName,
        prr.idregis
    FROM 
        PermiRoleRecord prr
    JOIN 
        Permission p ON prr.idPermi = p.idPermi
    JOIN 
        UserRole ur ON ur.idrol = prr.idrol
    WHERE 
        ur.idUser = @idUser 
        AND prr.idEnty = @idEnty;
END;
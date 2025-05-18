CREATE DATABASE IF NOT EXISTS proyecto;
USE proyecto;


DROP TABLE IF EXISTS User_Theme;
DROP TABLE IF EXISTS Theme;
DROP TABLE IF EXISTS Notification;
DROP TABLE IF EXISTS Audit_Log;
DROP TABLE IF EXISTS User_Permission;
DROP TABLE IF EXISTS Form_Permission;
DROP TABLE IF EXISTS Form_Modulo;
DROP TABLE IF EXISTS Form;
DROP TABLE IF EXISTS Modulo_Rol;
DROP TABLE IF EXISTS Modulo;
DROP TABLE IF EXISTS Rol_User;
DROP TABLE IF EXISTS Rol;
DROP TABLE IF EXISTS Permission;
DROP TABLE IF EXISTS Session;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
    id_person INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    document_type VARCHAR(50),
    document_number VARCHAR(50),
    birth_date DATE,
    email VARCHAR(150),
    phone VARCHAR(50)
);

CREATE TABLE User (
    id_user INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    status VARCHAR(20),
    created_at DATETIME,
    id_person INT,
    CONSTRAINT fk_user_person FOREIGN KEY (id_person) REFERENCES Person(id_person)
);

CREATE TABLE Rol (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    description VARCHAR(255),
    status VARCHAR(20)
);

CREATE TABLE Rol_User (
    id_rol_user INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    id_rol INT,
    assigned_at DATETIME,
    CONSTRAINT fk_rol_user_user FOREIGN KEY (id_user) REFERENCES User(id_user),
    CONSTRAINT fk_rol_user_rol FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Modulo (
    id_modulo INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description VARCHAR(255),
    icon VARCHAR(100),
    status VARCHAR(20)
);

CREATE TABLE Modulo_Rol (
    id_modulo_rol INT PRIMARY KEY AUTO_INCREMENT,
    id_modulo INT,
    id_rol INT,
    access_level VARCHAR(50),
    CONSTRAINT fk_modulo_rol_modulo FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo),
    CONSTRAINT fk_modulo_rol_rol FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Form (
    id_form INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    url VARCHAR(255),
    description VARCHAR(255),
    status VARCHAR(20)
);

CREATE TABLE Form_Modulo (
    id_form_modulo INT PRIMARY KEY AUTO_INCREMENT,
    id_form INT,
    id_modulo INT,
    `order` INT,
    CONSTRAINT fk_form_modulo_form FOREIGN KEY (id_form) REFERENCES Form(id_form),
    CONSTRAINT fk_form_modulo_modulo FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo)
);

CREATE TABLE Session (
    id_session INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    login_time DATETIME,
    logout_time DATETIME,
    ip_address VARCHAR(45),
    device_info VARCHAR(255),
    CONSTRAINT fk_session_user FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Permission (
    id_permission INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    description VARCHAR(255)
);

CREATE TABLE Form_Permission (
    id_form_permission INT PRIMARY KEY AUTO_INCREMENT,
    id_form INT,
    id_permission INT,
    CONSTRAINT fk_form_permission_form FOREIGN KEY (id_form) REFERENCES Form(id_form),
    CONSTRAINT fk_form_permission_permission FOREIGN KEY (id_permission) REFERENCES Permission(id_permission)
);

CREATE TABLE User_Permission (
    id_user_permission INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    id_permission INT,
    granted_at DATETIME,
    CONSTRAINT fk_user_permission_user FOREIGN KEY (id_user) REFERENCES User(id_user),
    CONSTRAINT fk_user_permission_permission FOREIGN KEY (id_permission) REFERENCES Permission(id_permission)
);

CREATE TABLE Audit_Log (
    id_audit INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    action VARCHAR(100),
    timestamp DATETIME,
    description TEXT,
    table_affected VARCHAR(100),
    CONSTRAINT fk_audit_log_user FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Notification (
    id_notification INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    title VARCHAR(150),
    message TEXT,
    read_status BOOLEAN,
    sent_at DATETIME,
    CONSTRAINT fk_notification_user FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Theme (
    id_theme INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    primary_color VARCHAR(20),
    secondary_color VARCHAR(20),
    is_dark_mode BOOLEAN
);

CREATE TABLE User_Theme (
    id_user_theme INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT,
    id_theme INT,
    assigned_at DATETIME,
    CONSTRAINT fk_user_theme_user FOREIGN KEY (id_user) REFERENCES User(id_user),
    CONSTRAINT fk_user_theme_theme FOREIGN KEY (id_theme) REFERENCES Theme(id_theme)
);

-- PROCEDIMIENTOS ALMACENADOS --

DROP PROCEDURE IF EXISTS InsertPerson;
DELIMITER //
CREATE PROCEDURE InsertPerson (
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_document_type VARCHAR(50),
    IN p_document_number VARCHAR(50),
    IN p_birth_date DATE,
    IN p_email VARCHAR(150),
    IN p_phone VARCHAR(50)
)
BEGIN
    INSERT INTO Person (first_name, last_name, document_type, document_number, birth_date, email, phone)
    VALUES (p_first_name, p_last_name, p_document_type, p_document_number, p_birth_date, p_email, p_phone);
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS InsertUser;
DELIMITER //
CREATE PROCEDURE InsertUser (
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_status VARCHAR(20),
    IN p_id_person INT
)
BEGIN
    INSERT INTO User (username, password, status, created_at, id_person)
    VALUES (p_username, p_password, p_status, NOW(), p_id_person);
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateUserStatus;
DELIMITER //
CREATE PROCEDURE UpdateUserStatus (
    IN p_id_user INT,
    IN p_new_status VARCHAR(20)
)
BEGIN
    UPDATE User SET status = p_new_status WHERE id_user = p_id_user;
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteUser;
DELIMITER //
CREATE PROCEDURE DeleteUser (
    IN p_id_user INT
)
BEGIN
    DELETE FROM User WHERE id_user = p_id_user;
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS GetAllUsers;
DELIMITER //
CREATE PROCEDURE GetAllUsers ()
BEGIN
    SELECT * FROM User;
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS InsertRol;
DELIMITER //
CREATE PROCEDURE InsertRol (
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(255),
    IN p_status VARCHAR(20)
)
BEGIN
    INSERT INTO Rol (name, description, status)
    VALUES (p_name, p_description, p_status);
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS AssignRolToUser;
DELIMITER //
CREATE PROCEDURE AssignRolToUser (
    IN p_id_user INT,
    IN p_id_rol INT
)
BEGIN
    INSERT INTO Rol_User (id_user, id_rol, assigned_at)
    VALUES (p_id_user, p_id_rol, NOW());
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS GetFormsByModulo;
DELIMITER //
CREATE PROCEDURE GetFormsByModulo (
    IN p_id_modulo INT
)
BEGIN
    SELECT f.*
    FROM Form f
    JOIN Form_Modulo fm ON f.id_form = fm.id_form
    WHERE fm.id_modulo = p_id_modulo;
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS InsertSession;
DELIMITER //
CREATE PROCEDURE InsertSession (
    IN p_id_user INT,
    IN p_ip_address VARCHAR(45),
    IN p_device_info VARCHAR(255)
)
BEGIN
    INSERT INTO Session (id_user, login_time, ip_address, device_info)
    VALUES (p_id_user, NOW(), p_ip_address, p_device_info);
END;
//
DELIMITER ;

DROP PROCEDURE IF EXISTS LogoutSession;
DELIMITER //
CREATE PROCEDURE LogoutSession (
    IN p_id_session INT
)
BEGIN
    UPDATE Session SET logout_time = NOW() WHERE id_session = p_id_session;
END;
//
DELIMITER ;


-- Insertamos una persona
CALL InsertPerson(
    'Natsuko',              -- first_name
    'Hirose',               -- last_name
    'CC',                   -- document_type
    '5566778899',           -- document_number
    '1998-07-12',           -- birth_date
    'natsuko.hirose@mail.com', -- email
    '3105556677'            -- phone
);
CALL InsertPerson(
    'maki',              -- first_name
    'zenin',               -- last_name
    'CC',                   -- document_type
    '543534534',           -- document_number
    '1997-07-12',           -- birth_date
    'maki.zenin@mail.com', -- email
    '3105543543'            -- phone
);


SELECT id_person FROM Person WHERE document_number = '5566778899';



-- 3. Insertamos un usuario asociado a esa persona (usando el id_person obtenido)
CALL InsertUser(
    'natsuko_h',           -- username
    'hashed_password123',  -- password (usa password hashed)
    'active',              -- status
    1                      -- id_person
);

-- 4. Insertamos un rol
CALL InsertRol(
    'Admin',               -- name
    'Administrador del sistema', -- description
    'active'               -- status
);

-- 5. Asignamos el rol creado al usuario 
CALL AssignRolToUser(
    1,     -- id_user
    1      -- id_rol
);

-- 6. Insertamos un módulo
INSERT INTO Modulo (id_modulo, name, description, icon, status)
VALUES (1, 'Dashboard', 'Panel principal', 'dashboard_icon', 'active');

-- 7. Insertamos un formulario y asociamos al módulo 
INSERT INTO Form (id_form, name, url, description, status)
VALUES (1, 'Home', '/home', 'Página de inicio', 'active');

INSERT INTO Form_Modulo (id_form_modulo, id_form, id_modulo, `order`)
VALUES (1, 1, 1, 1);

-- 8. Insertamos permisos
INSERT INTO Permission (id_permission, name, description)
VALUES (1, 'Read', 'Permiso de lectura');

-- 9. Asignamos permiso a formulario
INSERT INTO Form_Permission (id_form_permission, id_form, id_permission)
VALUES (1, 1, 1);

-- 10. Asignamos permiso directamente a usuario
INSERT INTO User_Permission (id_user_permission, id_user, id_permission, granted_at)
VALUES (1, 1, 1, NOW());

-- 11. Insertamos una sesión para el usuario
CALL InsertSession(
    1,                     -- id_user
    '192.168.1.100',       -- ip_address
    'Mozilla Firefox'      -- device_info
);

-- 12. Consultamos usuarios para ver datos
CALL GetAllUsers();

-- 13. Consultamos formularios de módulo
CALL GetFormsByModulo(1);

SELECT * FROM Person;
SELECT * FROM User;
SELECT * FROM Rol;
SELECT * FROM Rol_User;
SELECT * FROM Modulo;
SELECT * FROM Modulo_Rol;
SELECT * FROM Form;
SELECT * FROM Form_Modulo;
SELECT * FROM Session;
SELECT * FROM Permission;
SELECT * FROM Form_Permission;
SELECT * FROM User_Permission;
SELECT * FROM Audit_Log;
SELECT * FROM Notification;
SELECT * FROM Theme;
SELECT * FROM User_Theme;

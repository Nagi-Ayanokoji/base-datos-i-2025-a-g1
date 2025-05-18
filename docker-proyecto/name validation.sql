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
    id_person INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    document_type VARCHAR(50),
    document_number VARCHAR(50),
    birth_date DATE,
    email VARCHAR(150),
    phone VARCHAR(50)
);

CREATE TABLE User (
    id_user INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    status VARCHAR(20),
    created_at DATETIME,
    id_person INT,
    CONSTRAINT fk_user_person FOREIGN KEY (id_person) REFERENCES Person(id_person)
);

CREATE TABLE Rol (
    id_rol INT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(255),
    status VARCHAR(20)
);

CREATE TABLE Rol_User (
    id_rol_user INT PRIMARY KEY,
    id_user INT,
    id_rol INT,
    assigned_at DATETIME,
    CONSTRAINT fk_rol_user_user FOREIGN KEY (id_user) REFERENCES User(id_user),
    CONSTRAINT fk_rol_user_rol FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Modulo (
    id_modulo INT PRIMARY KEY,
    name VARCHAR(100),
    description VARCHAR(255),
    icon VARCHAR(100),
    status VARCHAR(20)
);

CREATE TABLE Modulo_Rol (
    id_modulo_rol INT PRIMARY KEY,
    id_modulo INT,
    id_rol INT,
    access_level VARCHAR(50),
    CONSTRAINT fk_modulo_rol_modulo FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo),
    CONSTRAINT fk_modulo_rol_rol FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Form (
    id_form INT PRIMARY KEY,
    name VARCHAR(100),
    url VARCHAR(255),
    description VARCHAR(255),
    status VARCHAR(20)
);

CREATE TABLE Form_Modulo (
    id_form_modulo INT PRIMARY KEY,
    id_form INT,
    id_modulo INT,
    `order` INT,
    CONSTRAINT fk_form_modulo_form FOREIGN KEY (id_form) REFERENCES Form(id_form),
    CONSTRAINT fk_form_modulo_modulo FOREIGN KEY (id_modulo) REFERENCES Modulo(id_modulo)
);

CREATE TABLE Session (
    id_session INT PRIMARY KEY,
    id_user INT,
    login_time DATETIME,
    logout_time DATETIME,
    ip_address VARCHAR(45),
    device_info VARCHAR(255),
    CONSTRAINT fk_session_user FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Permission (
    id_permission INT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(255)
);

CREATE TABLE Form_Permission (
    id_form_permission INT PRIMARY KEY,
    id_form INT,
    id_permission INT,
    CONSTRAINT fk_form_permission_form FOREIGN KEY (id_form) REFERENCES Form(id_form),
    CONSTRAINT fk_form_permission_permission FOREIGN KEY (id_permission) REFERENCES Permission(id_permission)
);

CREATE TABLE User_Permission (
    id_user_permission INT PRIMARY KEY,
    id_user INT,
    id_permission INT,
    granted_at DATETIME,
    CONSTRAINT fk_user_permission_user FOREIGN KEY (id_user) REFERENCES User(id_user),
    CONSTRAINT fk_user_permission_permission FOREIGN KEY (id_permission) REFERENCES Permission(id_permission)
);

CREATE TABLE Audit_Log (
    id_audit INT PRIMARY KEY,
    id_user INT,
    action VARCHAR(100),
    timestamp DATETIME,
    description TEXT,
    table_affected VARCHAR(100),
    CONSTRAINT fk_audit_log_user FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Notification (
    id_notification INT PRIMARY KEY,
    id_user INT,
    title VARCHAR(150),
    message TEXT,
    read_status BOOLEAN,
    sent_at DATETIME,
    CONSTRAINT fk_notification_user FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Theme (
    id_theme INT PRIMARY KEY,
    name VARCHAR(50),
    primary_color VARCHAR(20),
    secondary_color VARCHAR(20),
    is_dark_mode BOOLEAN
);

CREATE TABLE User_Theme (
    id_user_theme INT PRIMARY KEY,
    id_user INT,
    id_theme INT,
    assigned_at DATETIME,
    CONSTRAINT fk_user_theme_user FOREIGN KEY (id_user) REFERENCES User(id_user),
    CONSTRAINT fk_user_theme_theme FOREIGN KEY (id_theme) REFERENCES Theme(id_theme)
);



INSERT INTO Person (id_person, first_name, last_name, document_type, document_number, birth_date, email, phone)
VALUES 
(1, 'Jinwoo', 'Sung', 'CC', '101000001', '1998-07-15', 'jinwoo.sung@solo.com', '3001000001'),
(2, 'Cha', 'Hae-In', 'CC', '101000002', '1999-03-22', 'cha.haein@solo.com', '3001000002'),
(3, 'Jinho', 'Yoo', 'TI', '101000003', '1995-05-10', 'jinho.yoo@solo.com', '3001000003'),
(4, 'Gunhee', 'Go', 'CC', '101000004', '1968-11-11', 'gunhee.go@solo.com', '3001000004'),
(5, 'Baek', 'Yoonho', 'CE', '101000005', '1989-01-30', 'baek.yoonho@solo.com', '3001000005'),
(6, 'Igris', 'Knight', 'CE', '101000006', '2000-12-12', 'igris.knight@solo.com', '3001000006'),
(7, 'Beru', 'Ant', 'CC', '101000007', '2001-04-01', 'beru.ant@solo.com', '3001000007'),
(8, 'Thomas', 'Andre', 'CC', '101000008', '1985-02-17', 'thomas.andre@solo.com', '3001000008'),
(9, 'Liu', 'Zhigang', 'TI', '101000009', '1987-09-05', 'liu.zhigang@solo.com', '3001000009'),
(10, 'Christopher', 'Reed', 'CE', '101000010', '1983-06-28', 'christopher.reed@solo.com', '3001000010');

DELIMITER $$

CREATE FUNCTION get_user_full_name(p_id_user INT)
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE full_name VARCHAR(255);

    SELECT CONCAT(p.first_name, ' ', p.last_name)
    INTO full_name
    FROM User u
    JOIN Person p ON u.id_person = p.id_person
    WHERE u.id_user = p_id_user;

    RETURN full_name;
END $$

DELIMITER ;
SELECT get_user_full_name(1) AS full_name;


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

-- Tabla Person (10)
INSERT INTO Person VALUES (1, 'Sung', 'Jinwoo', 'Passport', 'A1234567', '1994-01-01', 'jinwoo@example.com', '555-0101');
INSERT INTO Person VALUES (2, 'Cha', 'Haein', 'ID Card', 'B2345678', '1995-03-15', 'haein@example.com', '555-0102');
INSERT INTO Person VALUES (3, 'Jin', 'Hanseong', 'Passport', 'C3456789', '1993-07-20', 'hanseong@example.com', '555-0103');
INSERT INTO Person VALUES (4, 'Go', 'Gunhee', 'ID Card', 'D4567890', '1990-12-05', 'gunhee@example.com', '555-0104');
INSERT INTO Person VALUES (5, 'Sung', 'Ilhwa', 'Passport', 'E5678901', '1970-11-11', 'ilhwa@example.com', '555-0105');
INSERT INTO Person VALUES (6, 'Yoo', 'Jinho', 'Driver License', 'F6789012', '1997-09-25', 'jinho@example.com', '555-0106');
INSERT INTO Person VALUES (7, 'Choi', 'Jiwon', 'Passport', 'G7890123', '1996-02-17', 'jiwon@example.com', '555-0107');
INSERT INTO Person VALUES (8, 'Song', 'Sungsoo', 'ID Card', 'H8901234', '1992-05-30', 'sungsoo@example.com', '555-0108');
INSERT INTO Person VALUES (9, 'Baek', 'Yongjoon', 'Passport', 'I9012345', '1989-08-09', 'yongjoon@example.com', '555-0109');
INSERT INTO Person VALUES (10, 'Jang', 'Sangwoo', 'ID Card', 'J0123456', '1991-04-14', 'sangwoo@example.com', '555-0110');

-- Tabla User (10)
INSERT INTO User VALUES (1, 'jinwoo123', 'pass123', 'active', '2024-01-01 08:00:00', 1);
INSERT INTO User VALUES (2, 'haein456', 'pass456', 'active', '2024-01-02 08:00:00', 2);
INSERT INTO User VALUES (3, 'hanseong789', 'pass789', 'active', '2024-01-03 08:00:00', 3);
INSERT INTO User VALUES (4, 'gunhee101', 'pass101', 'active', '2024-01-04 08:00:00', 4);
INSERT INTO User VALUES (5, 'ilhwa202', 'pass202', 'active', '2024-01-05 08:00:00', 5);
INSERT INTO User VALUES (6, 'jinho303', 'pass303', 'active', '2024-01-06 08:00:00', 6);
INSERT INTO User VALUES (7, 'jiwon404', 'pass404', 'active', '2024-01-07 08:00:00', 7);
INSERT INTO User VALUES (8, 'sungsoo505', 'pass505', 'active', '2024-01-08 08:00:00', 8);
INSERT INTO User VALUES (9, 'yongjoon606', 'pass606', 'active', '2024-01-09 08:00:00', 9);
INSERT INTO User VALUES (10, 'sangwoo707', 'pass707', 'active', '2024-01-10 08:00:00', 10);

-- Tabla Rol (5)
INSERT INTO Rol VALUES (1, 'Admin', 'Administrator role', 'active');
INSERT INTO Rol VALUES (2, 'Hunter', 'Hunter role', 'active');
INSERT INTO Rol VALUES (3, 'Guild Leader', 'Leader of the guild', 'active');
INSERT INTO Rol VALUES (4, 'Support', 'Support role', 'active');
INSERT INTO Rol VALUES (5, 'Observer', 'Read-only role', 'active');

-- Tabla Rol_User (10)
INSERT INTO Rol_User VALUES (1, 1, 1, '2024-01-01 09:00:00');
INSERT INTO Rol_User VALUES (2, 2, 2, '2024-01-02 09:00:00');
INSERT INTO Rol_User VALUES (3, 3, 2, '2024-01-03 09:00:00');
INSERT INTO Rol_User VALUES (4, 4, 3, '2024-01-04 09:00:00');
INSERT INTO Rol_User VALUES (5, 5, 3, '2024-01-05 09:00:00');
INSERT INTO Rol_User VALUES (6, 6, 4, '2024-01-06 09:00:00');
INSERT INTO Rol_User VALUES (7, 7, 4, '2024-01-07 09:00:00');
INSERT INTO Rol_User VALUES (8, 8, 5, '2024-01-08 09:00:00');
INSERT INTO Rol_User VALUES (9, 9, 5, '2024-01-09 09:00:00');
INSERT INTO Rol_User VALUES (10, 10, 1, '2024-01-10 09:00:00');

-- Tabla Modulo (5)
INSERT INTO Modulo VALUES (1, 'Dashboard', 'Main panel', 'dashboard-icon', 'active');
INSERT INTO Modulo VALUES (2, 'Quests', 'Manage quests', 'quests-icon', 'active');
INSERT INTO Modulo VALUES (3, 'Inventory', 'User inventory', 'inventory-icon', 'active');
INSERT INTO Modulo VALUES (4, 'Guild', 'Guild management', 'guild-icon', 'active');
INSERT INTO Modulo VALUES (5, 'Settings', 'System settings', 'settings-icon', 'active');

-- Tabla Modulo_Rol (5)
INSERT INTO Modulo_Rol VALUES (1, 1, 1, 'full');
INSERT INTO Modulo_Rol VALUES (2, 2, 2, 'write');
INSERT INTO Modulo_Rol VALUES (3, 3, 2, 'read');
INSERT INTO Modulo_Rol VALUES (4, 4, 3, 'write');
INSERT INTO Modulo_Rol VALUES (5, 5, 1, 'full');

-- Tabla Form (5)
INSERT INTO Form VALUES (1, 'Login Form', '/login', 'User login page', 'active');
INSERT INTO Form VALUES (2, 'Quest Form', '/quests', 'Manage quests', 'active');
INSERT INTO Form VALUES (3, 'Inventory Form', '/inventory', 'User inventory', 'active');
INSERT INTO Form VALUES (4, 'Guild Form', '/guild', 'Guild management', 'active');
INSERT INTO Form VALUES (5, 'Settings Form', '/settings', 'System settings', 'active');

-- Tabla Form_Modulo (5)
INSERT INTO Form_Modulo VALUES (1, 1, 1, 1);
INSERT INTO Form_Modulo VALUES (2, 2, 2, 1);
INSERT INTO Form_Modulo VALUES (3, 3, 3, 1);
INSERT INTO Form_Modulo VALUES (4, 4, 4, 1);
INSERT INTO Form_Modulo VALUES (5, 5, 5, 1);

-- Tabla Session (5)
INSERT INTO Session VALUES (1, 1, '2024-05-01 08:00:00', '2024-05-01 12:00:00', '192.168.1.10', 'Chrome on Windows');
INSERT INTO Session VALUES (2, 2, '2024-05-01 09:00:00', '2024-05-01 11:30:00', '192.168.1.11', 'Firefox on Mac');
INSERT INTO Session VALUES (3, 3, '2024-05-02 10:00:00', '2024-05-02 14:00:00', '192.168.1.12', 'Edge on Windows');
INSERT INTO Session VALUES (4, 4, '2024-05-03 08:30:00', '2024-05-03 12:30:00', '192.168.1.13', 'Safari on iPhone');
INSERT INTO Session VALUES (5, 5, '2024-05-03 09:15:00', '2024-05-03 10:45:00', '192.168.1.14', 'Chrome on Android');

-- Tabla Permission (5)
INSERT INTO Permission VALUES (1, 'Read', 'Permission to read data');
INSERT INTO Permission VALUES (2, 'Write', 'Permission to write data');
INSERT INTO Permission VALUES (3, 'Delete', 'Permission to delete data');
INSERT INTO Permission VALUES (4, 'Execute', 'Permission to execute actions');
INSERT INTO Permission VALUES (5, 'Administer', 'Full admin permissions');

-- Tabla Form_Permission (5)
INSERT INTO Form_Permission VALUES (1, 1, 1);
INSERT INTO Form_Permission VALUES (2, 2, 2);
INSERT INTO Form_Permission VALUES (3, 3, 1);
INSERT INTO Form_Permission VALUES (4, 4, 4);
INSERT INTO Form_Permission VALUES (5, 5, 5);

-- Tabla User_Permission (5)
INSERT INTO User_Permission VALUES (1, 1, 5, '2024-01-01 10:00:00');
INSERT INTO User_Permission VALUES (2, 2, 2, '2024-01-02 10:00:00');
INSERT INTO User_Permission VALUES (3, 3, 1, '2024-01-03 10:00:00');
INSERT INTO User_Permission VALUES (4, 4, 3, '2024-01-04 10:00:00');
INSERT INTO User_Permission VALUES (5, 5, 1, '2024-01-05 10:00:00');

-- Tabla Audit_Log (3)
INSERT INTO Audit_Log VALUES (1, 1, 'Login', '2024-05-01 08:00:00', 'User logged in', 'User');
INSERT INTO Audit_Log VALUES (2, 2, 'Update Profile', '2024-05-02 09:00:00', 'Updated email address', 'Person');
INSERT INTO Audit_Log VALUES (3, 3, 'Delete Quest', '2024-05-03 10:00:00', 'Deleted a quest record', 'Quest');

-- Tabla Notification (3)
INSERT INTO Notification VALUES (1, 1, 'Welcome', 'Welcome to the system!', FALSE, '2024-05-01 08:05:00');
INSERT INTO Notification VALUES (2, 2, 'Quest Reminder', 'Don\'t forget to complete your quests.', FALSE, '2024-05-02 09:30:00');
INSERT INTO Notification VALUES (3, 3, 'System Update', 'System will be down for maintenance.', TRUE, '2024-05-03 11:00:00');

-- Tabla Theme (2)
INSERT INTO Theme VALUES (1, 'Light', '#FFFFFF', '#000000', FALSE);
INSERT INTO Theme VALUES (2, 'Dark', '#000000', '#FFFFFF', TRUE);

-- Tabla User_Theme (2)
INSERT INTO User_Theme VALUES (1, 1, 2, '2024-01-01 12:00:00');
INSERT INTO User_Theme VALUES (2, 2, 1, '2024-01-02 12:00:00');

SELECT u.username, p.first_name, p.last_name, r.name AS role_name
FROM User u
JOIN Person p ON u.id_person = p.id_person
JOIN Rol_User ru ON u.id_user = ru.id_user
JOIN Rol r ON ru.id_rol = r.id_rol;

SELECT u.username, p.email
FROM User u
JOIN Person p ON u.id_person = p.id_person;


SELECT f.name AS form_name, m.name AS module_name, fm.`order`
FROM Form f
JOIN Form_Modulo fm ON f.id_form = fm.id_form
JOIN Modulo m ON fm.id_modulo = m.id_modulo;


SELECT u.username, r.name AS role_name
FROM User u
JOIN Rol_User ru ON u.id_user = ru.id_user
JOIN Rol r ON ru.id_rol = r.id_rol
WHERE u.username = 'cha_hyunsoo';



SELECT f.name AS form_name, m.name AS module_name
FROM Form f
JOIN Form_Modulo fm ON f.id_form = fm.id_form
JOIN Modulo m ON fm.id_modulo = m.id_modulo;



SELECT u.username, perm.name AS permission_name, up.granted_at
FROM User u
JOIN User_Permission up ON u.id_user = up.id_user
JOIN Permission perm ON up.id_permission = perm.id_permission;



SELECT r.name AS role_name, m.name AS module_name, mr.access_level
FROM Rol r
JOIN Modulo_Rol mr ON r.id_rol = mr.id_rol
JOIN Modulo m ON mr.id_modulo = m.id_modulo;

SELECT f.name AS form_name, perm.name AS permission_name
FROM Form f
JOIN Form_Permission fp ON f.id_form = fp.id_form
JOIN Permission perm ON fp.id_permission = perm.id_permission;

SELECT u.username, t.name AS theme_name, t.is_dark_mode, ut.assigned_at
FROM User u
JOIN User_Theme ut ON u.id_user = ut.id_user
JOIN Theme t ON ut.id_theme = t.id_theme;

SELECT al.timestamp, u.username, al.action, al.table_affected, al.description
FROM Audit_Log al
JOIN User u ON al.id_user = u.id_user
ORDER BY al.timestamp DESC;


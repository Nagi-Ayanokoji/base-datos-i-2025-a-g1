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
    status VARCHAR(20), -- 'activo' o 'inactivo'
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
    access_level VARCHAR(50), -- lectura, escritura, admin, etc.
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
    ip_address VARCHAR(45), -- soporta IPv6
    device_info VARCHAR(255),
    CONSTRAINT fk_session_user FOREIGN KEY (id_user) REFERENCES User(id_user)
);

CREATE TABLE Permission (
    id_permission INT PRIMARY KEY,
    name VARCHAR(50), -- e.g. create, read, update, delete
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

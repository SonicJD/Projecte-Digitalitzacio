DROP DATABASE IF EXISTS `Projecte`;
CREATE DATABASE `Projecte`;
USE `Projecte`;

CREATE TABLE clients (
    DNI CHAR(9) PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telefon VARCHAR(20) NOT NULL,
    correu VARCHAR(100) NOT NULL
);

CREATE TABLE consoles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    any_fabricacio INT NOT NULL,
    preu DECIMAL(10,2) NOT NULL
);

CREATE TABLE accessoris (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    any_fabricacio INT NOT NULL,
    preu DECIMAL(10,2) NOT NULL
);

CREATE TABLE factures (
    numFactura VARCHAR(20) PRIMARY KEY,
    client_DNI CHAR(9) NOT NULL,
    id_consoles INT NOT NULL,
    id_accessoris INT NOT NULL,
    data_factura DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (client_DNI) REFERENCES clients(DNI),
    FOREIGN KEY (id_consoles) REFERENCES consoles(id),
    FOREIGN KEY (id_accessoris) REFERENCES accessoris(id)
);

CREATE TABLE incidencies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consola_id INT NULL,
    id_accessoris INT NULL,
    client_DNI CHAR(9) NOT NULL,
    data_incidencia TIMESTAMP NOT NULL,
    servei_solicitat LONGTEXT NOT NULL,
    FOREIGN KEY (consola_id) REFERENCES consoles(id),
    FOREIGN KEY (id_accessoris) REFERENCES accessoris(id),
    FOREIGN KEY (client_DNI) REFERENCES clients(DNI)
);

-- Inserts clientes
INSERT INTO clients (DNI, nom, telefon, correu) VALUES
('12345678A', 'Anna Puig', '612345678', 'anna.puig@example.com'),
('23456789B', 'Marc Garcia', '622345678', 'marc.garcia@example.com'),
('34567890C', 'Laura Vidal', '632345678', 'laura.vidal@example.com'),
('45678901D', 'Pere Soler', '642345678', 'pere.soler@example.com'),
('56789012E', 'Marta Roca', '652345678', 'marta.roca@example.com'),
('67890123F', 'Joan Ferrer', '662345678', 'joan.ferrer@example.com'),
('78901234G', 'Clara Serra', '672345678', 'clara.serra@example.com'),
('89012345H', 'David Pons', '682345678', 'david.pons@example.com'),
('90123456I', 'Núria Bosch', '692345678', 'nuria.bosch@example.com'),
('01234567J', 'Oriol Mora', '602345678', 'oriol.mora@example.com');

-- Consoles
INSERT INTO consoles (marca, any_fabricacio, preu) VALUES
('Retroid Pocket Flip 2 Handheld', 2024, 289.99),
('Retroid Pocket Classic Handheld', 2023, 149.99),
('Retroid Pocket 4/4Pro Handheld', 2023, 199.99),
('ANBERNIC RG 557', 2024, 359.99),
('ANBERNIC RG 40XXV', 2024, 399.99),
('ANBERNIC RG 34XX', 2023, 449.99),
('Odin2 Portal', 2024, 219.99),
('Odin 2', 2024, 149.99),
('Odin2 Mini', 2024, 99.99);

-- Accessoris
INSERT INTO accessoris (marca, any_fabricacio, preu) VALUES
('Retroid Official Dock', 2024, 49.99),
('Retroid Official Grip for RP4/4Pro', 2023, 29.99),
('Retroid Pocket 5 Protector Shell', 2023, 19.99),
('ANBERNIC handle silicone sleeve for RG405M', 2024, 14.99),
('ANBERNIC RG350/RG350M/RG350P', 2022, 24.99),
('ANBERNIC RG35XXSP', 2024, 34.99),
('Odin 2 Super Dock', 2024, 49.99),
('Odin2 Mini 65w Charger', 2024, 39.99),
('Odin2 Portal ABXY(NS Layout)', 2024, 19.99);

-- Factures
INSERT INTO factures (numFactura, client_DNI, id_consoles, id_accessoris, data_factura, total) VALUES
('F001', '12345678A', 1, 1, '2025-04-01', 289.99),
('F002', '23456789B', 2, 1, '2025-04-02', 149.99),
('F003', '34567890C', 1, 2, '2025-04-03', 199.99),
('F004', '45678901D', 3, 1, '2025-04-04', 359.99),
('F005', '56789012E', 2, 2, '2025-04-05', 99.99),
('F006', '67890123F', 3, 3, '2025-04-06', 399.99),
('F007', '78901234G', 1, 3, '2025-04-07', 49.99),
('F008', '89012345H', 2, 1, '2025-04-08', 449.99),
('F009', '90123456I', 1, 2, '2025-04-09', 219.99),
('F010', '01234567J', 3, 2, '2025-04-10', 149.99);

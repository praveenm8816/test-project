-- WINDOWS-1252: All characters are valid in Windows-1252

CREATE TABLE assurance_clients (
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prï¿œnom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255),
    ville VARCHAR(100),
    province VARCHAR(50),
    code_postal VARCHAR(10),
    pays VARCHAR(50) DEFAULT 'Canada',
    tï¿œlï¿œphone VARCHAR(20),
    courriel VARCHAR(100),
    date_naissance DATE,
    type_assurance VARCHAR(50) CHECK (type_assurance IN ('Auto', 'Habitation', 'Vie', 'Santï¿œ')),
    montant_couverture DECIMAL(12,2),
    date_crï¿œation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    commentaire VARCHAR(255) DEFAULT 'Aucune remarque'
);

INSERT INTO assurance_clients (id, nom, prï¿œnom, adresse, ville, province, code_postal, tï¿œlï¿œphone, courriel, date_naissance, type_assurance, montant_couverture, commentaire)
VALUES (
    1,
    'Lï¿œvesque',
    'ï¿œmilie',
    '1234 rue de l''ï¿œglise, app. 5',
    'Montrï¿œal',
    'Quï¿œbec',
    'H2X 3Y7',
    '+1 514-555-1234',
    'emilie.lï¿œvesque@assurance.ca',
    TO_DATE('1985-07-14', 'YYYY-MM-DD'),
    'Vie',
    250000.00,
    'Client trï¿œs important. Prï¿œfï¿œre la communication en franï¿œais. Rï¿œside ï¿œ Montrï¿œal.'
);

-- Remarque : Ce script contient des caractï¿œres accentuï¿œs : ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, ï¿œ, etc.
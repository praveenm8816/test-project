-- Fichier : r__SIMDATA.ASSURANCE_CLIENTS.pks.sql

CREATE TABLE assurance_clients (
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    pr�nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255),
    ville VARCHAR(100),
    province VARCHAR(50),
    code_postal VARCHAR(10),
    pays VARCHAR(50) DEFAULT 'Canada',
    t�l�phone VARCHAR(20),
    courriel VARCHAR(100),
    date_naissance DATE,
    type_assurance VARCHAR(50) CHECK (type_assurance IN ('Auto', 'Habitation', 'Vie', 'Sant�')),
    montant_couverture DECIMAL(12,2),
    date_cr�ation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    commentaire VARCHAR(255) DEFAULT 'Aucune remarque'
);

INSERT INTO assurance_clients (id, nom, pr�nom, adresse, ville, province, code_postal, t�l�phone, courriel, date_naissance, type_assurance, montant_couverture, commentaire)
VALUES (
    1,
    'L�vesque',
    '�milie',
    '1234 rue de l''�glise, app. 5',
    'Montr�al',
    'Qu�bec',
    'H2X 3Y7',
    '+1 514-555-1234',
    'emilie.l�vesque@assurance.ca',
    TO_DATE('1985-07-14', 'YYYY-MM-DD'),
    'Vie',
    250000.00,
    'Client tr�s important. Pr�f�re la communication en fran�ais. R�side � Montr�al.'
);

-- Remarque : Ce script contient des caract�res accentu�s : �, �, �, �, �, �, �, �, �, �, �, �, etc.
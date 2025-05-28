-- UTF-8 ENCODING (INCORRECT FOR WINDOWS-1252 CHECK)
-- Fichier : r__SIMDATA.ASSURANCE_CLIENTS.pks.sql

CREATE TABLE assurance_clients (
    id INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prénom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255),
    ville VARCHAR(100),
    province VARCHAR(50),
    code_postal VARCHAR(10),
    pays VARCHAR(50) DEFAULT 'Canada',
    téléphone VARCHAR(20),
    courriel VARCHAR(100),
    date_naissance DATE,
    type_assurance VARCHAR(50) CHECK (type_assurance IN ('Auto', 'Habitation', 'Vie', 'Santé')),
    montant_couverture DECIMAL(12,2),
    date_création TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    commentaire VARCHAR(255) DEFAULT 'Aucune remarque'
);

-- Ajout d'un client avec des caractères français
INSERT INTO assurance_clients (id, nom, prénom, adresse, ville, province, code_postal, téléphone, courriel, date_naissance, type_assurance, montant_couverture, commentaire)
VALUES (
    1,
    'Lévesque',
    'Émilie',
    '1234 rue de l''Église, app. 5',
    'Montréal',
    'Québec',
    'H2X 3Y7',
    '+1 514-555-1234',
    'emilie.lévesque@assurance.ca',
    TO_DATE('1985-07-14', 'YYYY-MM-DD'),
    'Vie',
    250000.00,
    'Client très important. Préfère la communication en français. Réside à Montréal.'
);

-- Remarque : Ce script contient des caractères accentués : é, è, à, ç, ô, û, î, ï, ü, œ, É, Ç, etc.
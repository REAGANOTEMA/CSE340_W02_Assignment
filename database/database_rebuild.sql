-- Author: Reagan Otema
-- Email: rotema@byupathway.edu
-- Database Rebuild - CSE 340 Assignment 2

-- =====================================
-- 1. Drop tables if they exist (clean rebuild)
-- =====================================
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS classification CASCADE;
DROP TABLE IF EXISTS account CASCADE;
DROP TYPE IF EXISTS account_type;

-- =====================================
-- 2. Create PostgreSQL type
-- =====================================
CREATE TYPE account_type AS ENUM ('Customer', 'Admin');

-- =====================================
-- 3. Create tables
-- =====================================
CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    account_type account_type DEFAULT 'Customer'
);

CREATE TABLE classification (
    classification_id SERIAL PRIMARY KEY,
    classification_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE inventory (
    inv_id SERIAL PRIMARY KEY,
    inv_make VARCHAR(50) NOT NULL,
    inv_model VARCHAR(50) NOT NULL,
    inv_description TEXT,
    inv_image VARCHAR(255),
    inv_thumbnail VARCHAR(255),
    classification_id INT REFERENCES classification(classification_id)
);

-- =====================================
-- 4. Insert initial data
-- =====================================
-- Classifications
INSERT INTO classification (classification_name) VALUES
('Sport'),
('Truck'),
('SUV');

-- Inventory
INSERT INTO inventory (inv_make, inv_model, inv_description, inv_image, inv_thumbnail, classification_id) VALUES
('GM', 'Hummer', 'small interiors', '/images/hummer.jpg', '/images/hummer-thumb.jpg', 3),
('Ford', 'Mustang', 'classic sport car', '/images/mustang.jpg', '/images/mustang-thumb.jpg', 1),
('Audi', 'R8', 'sleek design', '/images/audi-r8.jpg', '/images/audi-r8-thumb.jpg', 1),
('Chevrolet', 'Camaro', 'fast and furious', '/images/camaro.jpg', '/images/camaro-thumb.jpg', 1);

-- =====================================
-- 5. Task 1 final queries (to run last)
-- =====================================

-- Update GM Hummer description
UPDATE inventory
SET inv_description = REPLACE(inv_description, 'small interiors', 'a huge interior')
WHERE inv_make = 'GM' AND inv_model = 'Hummer';

-- Update image paths
UPDATE inventory
SET inv_image = REPLACE(inv_image, '/images/', '/images/vehicles/'),
    inv_thumbnail = REPLACE(inv_thumbnail, '/images/', '/images/vehicles/');

-- =====================================
-- 6. Verify data
-- =====================================
SELECT * FROM inventory ORDER BY inv_id ASC;
SELECT * FROM classification ORDER BY classification_id ASC;
SELECT * FROM account ORDER BY account_id ASC;

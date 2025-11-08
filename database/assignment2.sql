-- Author: Reagan Otema
-- Email: rotema@byupathway.edu
-- Assignment 2 - CSE 340

-- =====================================
-- 1. Create PostgreSQL type
-- =====================================
CREATE TYPE account_type AS ENUM ('Customer', 'Admin');

-- =====================================
-- 2. Create tables
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
-- 3. Insert initial data
-- =====================================
-- Sample classifications
INSERT INTO classification (classification_name) VALUES
('Sport'),
('Truck'),
('SUV');

-- Sample inventory
INSERT INTO inventory (inv_make, inv_model, inv_description, inv_image, inv_thumbnail, classification_id) VALUES
('GM', 'Hummer', 'small interiors', '/images/hummer.jpg', '/images/hummer-thumb.jpg', 3),
('Ford', 'Mustang', 'classic sport car', '/images/mustang.jpg', '/images/mustang-thumb.jpg', 1),
('Audi', 'R8', 'sleek design', '/images/audi-r8.jpg', '/images/audi-r8-thumb.jpg', 1),
('Chevrolet', 'Camaro', 'fast and furious', '/images/camaro.jpg', '/images/camaro-thumb.jpg', 1);

-- =====================================
-- 4. Task 1 Queries
-- =====================================

-- Query 1: Insert Tony Stark
INSERT INTO account (first_name, last_name, email, password)
VALUES ('Tony', 'Stark', 'tony@starkent.com', 'Iam1ronM@n');

-- Query 2: Update Tony Stark account_type to Admin
UPDATE account
SET account_type = 'Admin'
WHERE email = 'tony@starkent.com';

-- Query 3: Delete Tony Stark
DELETE FROM account
WHERE email = 'tony@starkent.com';

-- Query 4: Update GM Hummer description
UPDATE inventory
SET inv_description = REPLACE(inv_description, 'small interiors', 'a huge interior')
WHERE inv_make = 'GM' AND inv_model = 'Hummer';

-- Query 5: Join inventory with classification for Sport items
SELECT i.inv_make, i.inv_model, c.classification_name
FROM inventory i
INNER JOIN classification c
ON i.classification_id = c.classification_id
WHERE c.classification_name = 'Sport';

-- Query 6: Update image paths
UPDATE inventory
SET inv_image = REPLACE(inv_image, '/images/', '/images/vehicles/'),
    inv_thumbnail = REPLACE(inv_thumbnail, '/images/', '/images/vehicles/');

-- Check updated inventory
SELECT * FROM inventory
ORDER BY inv_id ASC;

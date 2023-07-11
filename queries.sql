

SELECT * FROM animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = 'true' AND  escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR  name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 AND 17.3;


BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species from animals; -- verify that change was made
ROLLBACK;
SELECT species from animals;


BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species from animals;
COMMIT;
SELECT species from animals;


BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals


BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT new_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO new_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts < 1;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts) FROM animals;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;


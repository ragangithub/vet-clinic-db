

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



--  MULTIPLE TABLES DAY 3 

-- What animals belong to Melody Pond?
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name  FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals JOIN species ON species.id = animals.species_id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, owners.full_name, species.name FROM animals
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester with 0 escape attempts.
SELECT animals.name, full_name, escape_attempts FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;


-- Who owns the most animals?
SELECT owners.full_name, COUNT(*) AS count FROM owners JOIN animals ON animals.owner_id = owners.id GROUP BY owners.id ORDER BY count DESC limit 1;

--   DAY 4
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.date_of_visit FROM vets
  JOIN visits ON vets.id = visits.vet_id
  JOIN animals ON animals.id = visits.animal_id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visits.date_of_visit DESC LIMIT 1;


 --How many animals did Stephanie Mendez see?
SELECT  COUNT(animal_id) FROM vets
  JOIN visits ON vets.id = visits.vet_id
  JOIN animals ON animals.id = visits.animal_id
  WHERE vets.name = 'William Tatcher';

  -- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.name, visits.date_of_visit
FROM animals
JOIN visits
ON visits.animal_id = animals.id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.animal_id) AS VISITS
FROM animals
JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY VISITS DESC LIMIT 1;


 -- Who was Maisy Smith's first visit?
  SELECT animals.name, vets.name, visits.date_of_visit
  FROM visits JOIN animals ON visits.animal_id=animals.id
  JOIN vets ON vets.id = visits.vet_id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visits.date_of_visit ASC LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.
  SELECT animals.id, animals.name, animals.date_of_birth, vets.id, vets.name, vets.age, date_of_visit
  FROM visits JOIN animals ON animals.id = visits.animal_id
  JOIN vets ON vets.id = visits.vet_id 
  ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
  SELECT vets.name, COUNT(*) FROM visits JOIN vets 
    ON vets.id = visits.vet_id LEFT JOIN specializations 
    ON specializations.vet_id = visits.vet_id 
    WHERE specializations.vet_id IS NULL GROUP BY vets.name;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
  SELECT vets.name, species.name, COUNT(species.name)
  FROM visits JOIN animals ON visits.animal_id=animals.id JOIN vets ON visits.vet_id=vets.id
  JOIN species ON species.id = animals.species_id 
  WHERE vets.name = 'Maisy Smith' GROUP BY vets.name, species.name
  ORDER BY COUNT DESC LIMIT 1;
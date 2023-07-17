/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id int GENERATED ALWAYS AS IDENTITY NOT NULL,
name VARCHAR(30) NOT NULL ,
date_of_birth date ,
escape_attempts integer ,
neutered boolean,
weight_kg decimal,
PRIMARY KEY(id)
);

ALTER TABLE animals ADD species VARCHAR(50);


CREATE TABLE owners(
  id SERIAL NOT NULL,
  full_name VARCHAR(200),
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species(
  id SERIAL NOT NULL,
  name VARCHAR(200),
  PRIMARY KEY(id)
);




ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id); 

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);



-- DAY 4 

-- Create table vets

CREATE TABLE vets(
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(100),
  age INT,
  date_of_graduation DATE,
  PRIMARY KEY (id)
);

CREATE TABLE specializations (
id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1), 
species_id  INT,
vet_id    INT,
CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id),
CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id),
PRIMARY KEY(id)
);


BEGIN;

ALTER TABLE animals ADD CONSTRAINT animals_id_unique UNIQUE (id);

COMMIT;

CREATE TABLE visits (
visit_id INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1), 
animal_id   INT,
vet_id      INT,
date_of_visit     DATE,
CONSTRAINT fk_animals FOREIGN KEY(animal_id) REFERENCES animals(id),
CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
PRIMARY KEY(visit_id )
);


-- DAY 5 

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX idx_animal_id ON visits (animal_id);
CREATE INDEX idx_vets_id ON visits (vet_id);
CREATE INDEX idx_owners_email ON owners (email);
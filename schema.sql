/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250) NOT NULL, date_of_birth DATE NOT NULL,
    escape_attempt INT NOT NULL, neutered BOOL NOT NULL, weight DECIMAL(50,2) NOT NUL
);
ALTER TABLE animals ADD species varchar;

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR(250) NOT NULL,age INT, PRIMARY KEY(id)
);

CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY,name VARCHAR(50) NOT NULL,PRIMARY KEY(id));

ALTER TABLE animals DROP column species;

ALTER TABLE animals ADD column species_id INT;

ALTER TABLE animals ADD CONSTRAINT animal_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD column owner_id INT;

ALTER TABLE animals ADD CONSTRAINT animal_owner FOREIGN KEY (owner_id) REFERENCES owners (id);

CREATE TABLE vets (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(100), age INT, date_of_graduation DATE, PRIMARY KEY(id));

CREATE TABLE specializations (id INT GENERATED ALWAYS AS IDENTITY, species_id INT, vet_id INT, FOREIGN KEY (species_id) REFERENCES species (id), FOREIGN KEY (vet_id) REFERENCES vets (id));

CREATE TABLE visits (id INT GENERATED ALWAYS AS IDENTITY, date_of_visit DATE, animal_id INT, vet_id INT, PRIMARY KEY (id), FOREIGN KEY (animal_id) REFERENCES animals (id), FOREIGN KEY (vet_id) REFERENCES vets (id));


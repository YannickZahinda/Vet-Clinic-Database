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

INSERT INTO owners(full_name,age) VALUES('Sam Smith', 34),('Jennifer Orwell',19),('Bob',45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker ',38);

INSERT INTO species(name) VALUES('Pokemon'),('Digimon');

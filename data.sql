/* Populate database with sample data. */

INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Agumon','2020/02/3',0,TRUE,20.23);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Gabumon','2018/11/15',1,FALSE,8);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Pikachu','2021/07/1',2,FALSE,15.04);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Devimon','2017/05/12',5,TRUE,11.0);
--Other insertions
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Squirtle','1993-04-2',3,FALSE,-12);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Angemon','2005-06-12',1,TRUE,-45);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Boarmon','2005-06-07',7,TRUE,20.4);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Ditto','2022-05-14',4,TRUE,22);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Charmander','2020-02-08',0,TRUE,-11);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Plantmon','2021-11-15',2,TRUE,-5.4);
INSERT INTO animals(name,date_of_birth,escape_attempt,neutered,weight) VALUES('Blossom','1998-10-13',3,TRUE,17);

INSERT INTO owners(full_name,age) VALUES('Sam Smith', 34),('Jennifer Orwell',19),('Bob',45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker ',38);

INSERT INTO species(name) VALUES('Pokemon'),('Digimon');

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';


UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name = 'Angemon' OR name = 'Boarmon';



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

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),('Maisy Smith', 26, '2019-01-17'),('Stephanie Mendez', 64, '1981-05-04'),('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (species_id, vet_id)
VALUES ((SELECT S.id FROM species S WHERE S.name = 'Pokemon'),
  (SELECT V.id FROM vets V WHERE V.name = 'William Tatcher')
  ),
  ((SELECT S.id FROM species S WHERE S.name = 'Pokemon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Stephanie Mendez')
  ),
  ((SELECT S.id FROM species S WHERE S.name = 'Digimon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Stephanie Mendez')
  ),
  ((SELECT S.id FROM species S WHERE S.name = 'Digimon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Jack Harkness')
  );

INSERT INTO visits (date_of_visit, animal_id, vet_id)
VALUES ('2020-05-24', (SELECT A.id FROM animals A WHERE A.name = 'Agumon'),
  (SELECT V.id FROM vets V WHERE V.name = 'William Tatcher')
  ),
  ('2020-07-22', (SELECT A.id FROM animals A WHERE A.name = 'Agumon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Stephanie Mendez')
  ),
  ('2021-02-02', (SELECT A.id FROM animals A WHERE A.name = 'Gabumon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Jack Harkness')
  ),
  ('2020-01-05', (SELECT A.id FROM animals A WHERE A.name = 'Pikachu'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2020-03-08', (SELECT A.id FROM animals A WHERE A.name = 'Pikachu'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2020-05-14', (SELECT A.id FROM animals A WHERE A.name = 'Pikachu'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2021-05-04', (SELECT A.id FROM animals A WHERE A.name = 'Devimon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Stephanie Mendez')
  ),
  ('2021-02-24', (SELECT A.id FROM animals A WHERE A.name = 'Charmander'),
  (SELECT V.id FROM vets V WHERE V.name = 'Jack Harkness')
  ),
  ('2019-12-21', (SELECT A.id FROM animals A WHERE A.name = 'Plantmon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2020-08-10', (SELECT A.id FROM animals A WHERE A.name = 'Plantmon'),
  (SELECT V.id FROM vets V WHERE V.name = 'William Tatcher')
  ),
  ('2021-04-07', (SELECT A.id FROM animals A WHERE A.name = 'Plantmon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2019-09-29', (SELECT A.id FROM animals A WHERE A.name = 'Squirtle'),
  (SELECT V.id FROM vets V WHERE V.name = 'Stephanie Mendez')
  ),
  ('2020-10-03', (SELECT A.id FROM animals A WHERE A.name = 'Angemon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Jack Harkness')
  ),
  ('2020-11-04', (SELECT A.id FROM animals A WHERE A.name = 'Angemon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Jack Harkness')
  ),
  ('2019-01-24', (SELECT A.id FROM animals A WHERE A.name = 'Boarmon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2019-05-15', (SELECT A.id FROM animals A WHERE A.name = 'Boarmon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2020-02-27', (SELECT A.id FROM animals A WHERE A.name = 'Boarmon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2020-08-03', (SELECT A.id FROM animals A WHERE A.name = 'Boarmon'),
  (SELECT V.id FROM vets V WHERE V.name = 'Maisy Smith')
  ),
  ('2020-05-24', (SELECT A.id FROM animals A WHERE A.name = 'Blossom'),
  (SELECT V.id FROM vets V WHERE V.name = 'Stephanie Mendez')
  ),
  ('2021-01-11', (SELECT A.id FROM animals A WHERE A.name = 'Blossom'),
  (SELECT V.id FROM vets V WHERE V.name = 'William Tatcher')
  );  


  INSERT INTO visits(animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animals_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

  insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';


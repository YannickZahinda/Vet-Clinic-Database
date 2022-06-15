/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT * FROM animals WHERE neutered IS TRUE AND escape_attempt < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT (name, escape_attempt) FROM animals WHERE weight<10.5;
SELECT * FROM animals WHERE neutered IS TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals where weight>=10.4 AND weight<=17.3;

--update species column to be unspecified;
begin transaction;
UPDATE animals
SET species='unspecified';

--roll back the change and verify that species columns went back to the state before transaction.
ROLLBACK;
--Checking if the species has the null value after the ROLLBACK;
SELECT * FROM animals WHERE species='unspecified';

--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species='pokemon' WHERE species IS null;

  --verify the changes before commit :
  SELECT species from where species='pokemon';
--Commit the transaction.
COMMIT;
  --verify after commit :
  SELECT species from where species='pokemon';

--Now, take a deep breath and... Inside a transaction delete all records in the animals table, 
BEGIN;
DELETE FROM animals;
  --verification of changes after deletion
  SELECT * FROM animals;

--then roll back the transaction.
ROLLBACK;

--Inside a transaction:
BEGIN;
   --Delete all animals born after Jan 1st, 2022.
   DELETE FROM animals WHERE date_of_birth>'2022-01-01';

   --Create a savepoint for the transaction.
   SAVEPOINT spdateofbirth;

   --Update all animals' weight to be their weight multiplied by -1.
   UPDATE animals SET weight = weight * -1;

   --Rollback to the savepoint
   ROLLBACK TO spdateofbirth;

   --Update all animals' weights that are negative to be their weight multiplied by -1.
   UPDATE animals SET weight = weight * -1;

   --Commit transaction
   COMMIT;

--Write queries to answers theses questions
  --How many animals are there?
  SELECT COUNT(*) FROM animals;

  --How many animals have never tried to escape?
  SELECT COUNT(*) FROM animals WHERE escape_attempt=0;

  --What is the average weight of animals?
  SELECT neutered, AVG(weight) FROM animals GROUP BY neutered;

  --Who escapes the most, neutered or not neutered animals?
  SELECT MAX(escape_attempt) FROM animals;

  --What is the minimum and maximum weight of each type of animal?
  SELECT species, (MIN(weight),MAX(weight)) FROM animals GROUP BY species;
  
  --What is the average number of escape attempts per animal type of those born between 1990 and 2000?
  SELECT species, AVG(escape_attempt) from animals where EXTRACT(YEAR FROM date_of_birth) between 1990 and 2000 group by species;


SELECT full_name AS owner, name AS animal FROM owners JOIN animals ON owners.id = animals.owner_id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name AS animal, species.name AS species FROM species S JOIN animals A ON S.id = A.species_id WHERE S.name = 'Pokemon';

SELECT O.full_name AS Owner, A.name AS Animals FROM owners O LEFT JOIN animals A ON O.id = A.owner_id;

SELECT S.name AS Species, COUNT(A.name) AS Total_number FROM species S JOIN animals A ON S.id = A.species_id GROUP BY S.name;

SELECT O.full_name as owner, A.name as animal, S.name as type FROM owners O JOIN animals A ON O.id = A.owner_id JOIN species S ON S.id = A.species_id WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

SELECT O.full_name as owner, A.name as animal FROM owners O JOIN animals A ON O.id = A.owner_id WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;
SELECT agg.full_name as owner, count as Total_number FROM (
  SELECT full_name, count(a.owner_id) FROM owners O
  JOIN animals A ON O.id = A.owner_id GROUP BY O.full_name) AS agg 
  WHERE count = (SELECT MAX(count) FROM (SELECT full_name, count(a.owner_id) FROM owners O
  JOIN animals A ON O.id = A.owner_id GROUP BY O.full_name) AS agg
  );

SELECT WT.Vet_name, WT.date_of_visit, WT.animal FROM 
(SELECT Vt.name AS Vet_name, Vs.date_of_visit, A.name AS animal FROM vets Vt
JOIN visits Vs ON Vt.id = Vs.vet_id
JOIN animals A ON Vs.animal_id = A.id
WHERE Vt.name = 'William Tatcher') AS WT
WHERE date_of_visit = (SELECT MAX(WT.date_of_visit) FROM (SELECT Vt.name AS Vet_name, Vs.date_of_visit, A.name AS animal FROM vets Vt
JOIN visits Vs ON Vt.id = Vs.vet_id
JOIN animals A ON Vs.animal_id = A.id
WHERE Vt.name = 'William Tatcher') AS WT);

SELECT COUNT(SM.animal) FROM (SELECT Count(Vt.name) AS No_of_Vet_name, A.name AS animal FROM vets Vt
JOIN visits Vs ON Vt.id = Vs.vet_id JOIN animals A ON Vs.animal_id = A.id
WHERE Vt.name = 'Stephanie Mendez'
GROUP BY A.name) AS SM;

SELECT Vt.id, Vt.name AS Vet_name, Sp.name AS specialty FROM vets Vt
LEFT JOIN specializations Sn ON Vt.id = Sn.vet_id
LEFT JOIN species Sp ON Sn.species_id = Sp.id;

SELECT Vt.name AS Vet_name, A.name AS animal, Vs.date_of_visit FROM vets Vt
JOIN visits Vs ON Vt.id = Vs.vet_id
JOIN animals A ON Vs.animal_id = A.id
WHERE Vt.name = 'Stephanie Mendez' 
AND (Vs.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30');

SELECT AL.animal, AL.Vet_visits FROM
(SELECT A.name AS animal, COUNT(Vt.name) AS Vet_visits FROM vets Vt
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id
  GROUP BY A.name
) as AL
WHERE AL.Vet_visits = (SELECT MAX(AL.Vet_visits) FROM (SELECT A.name AS animal, COUNT(Vt.name) AS Vet_visits FROM vets Vt
JOIN visits Vs ON Vt.id = Vs.vet_id
JOIN animals A ON Vs.animal_id = A.id
GROUP BY A.name) as AL);

SELECT MS.Vet_name, MS.animal, MS.date_of_visit FROM
(SELECT Vt.name AS Vet_name, A.name AS animal, Vs.date_of_visit FROM vets Vt
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id
  WHERE Vt.name = 'Maisy Smith'
) AS MS
WHERE MS.date_of_visit = (SELECT MIN(MS.date_of_visit) FROM 
(SELECT Vt.name AS Vet_name, A.name AS animal, Vs.date_of_visit FROM vets Vt
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id
  WHERE Vt.name = 'Maisy Smith'
) AS MS);

SELECT A.*, Vt.*, Vs.date_of_visit FROM vets Vt
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id
WHERE date_of_visit = (SELECT MAX(MD.date_of_visit) FROM (SELECT Vt.*, A.*, Vs.date_of_visit FROM vets Vt
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id) As MD);

SELECT COUNT(MS.Vet_name) AS visits FROM 
(SELECT  Vt.name AS Vet_name, A.name AS animal, Vs.date_of_visit, Sp.name as specialty FROM vets Vt
  LEFT JOIN specializations Sz ON Vt.id = Sz.vet_id
  LEFT JOIN species Sp ON Sz.species_id = Sp.id
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id
  WHERE Sp.name IS NULL) as MS;

SELECT S.name AS Species_name, MS2.species_id, MS2.Total_number AS Total_number_of_species FROM species S
JOIN (SELECT MS.species_id, MS.Total_number FROM 
(SELECT A.species_id, COUNT(A.species_id) AS Total_number FROM vets Vt
  LEFT JOIN specializations Sz ON Vt.id = Sz.vet_id
  LEFT JOIN species Sp ON Sz.species_id = Sp.id
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id
  WHERE Vt.name = 'Maisy Smith'
  GROUP BY A.species_id) as MS
WHERE MS.Total_number = (SELECT MAX(MS.Total_number) FROM
(SELECT A.species_id, COUNT(A.species_id) AS Total_number FROM vets Vt
  LEFT JOIN specializations Sz ON Vt.id = Sz.vet_id
  LEFT JOIN species Sp ON Sz.species_id = Sp.id
  JOIN visits Vs ON Vt.id = Vs.vet_id
  JOIN animals A ON Vs.animal_id = A.id
  WHERE Vt.name = 'Maisy Smith'
  GROUP BY A.species_id) as MS)) AS MS2
  ON S.id = MS2.species_id;     



SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;

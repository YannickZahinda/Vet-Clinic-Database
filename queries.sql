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

--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species='pokemon' WHERE species IS null;

--Commit the transaction.
COMMIT;

--Now, take a deep breath and... Inside a transaction delete all records in the animals table, 
BEGIN;
DELETE FROM animals;
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
  SELECT id, AVG(weight) FROM animals GROUP BY id;

  --Who escapes the most, neutered or not neutered animals?
  SELECT MAX(escape_attempt) FROM animals;

  --What is the minimum and maximum weight of each type of animal?
  SELECT (MIN(weight),MAX(weight)) FROM animals;
  
  --What is the average number of escape attempts per animal type of those born between 1990 and 2000?
  SELECT date_of_birth, AVG(escape_attempt) from animals where EXTRACT(YEAR FROM date_of_birth) between 1990 and 2000 group by date_of_birth;


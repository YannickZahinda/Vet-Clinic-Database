/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(250) NOT NULL, date_of_birth DATE NOT NULL,
    escape_attempt INT NOT NULL, neutered BOOL NOT NULL, weight DECIMAL(50,2) NOT NUL
);

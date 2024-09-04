#Build a Periodic Table Database

This project, part of the freeCodeCamp certification journey, involves creating a Bash script for querying a periodic table database built with PostgreSQL.

##About the Project

###This project equips you with:

Relational database management skills using PostgreSQL
Scripting abilities with Bash
Understanding of database manipulation techniques
Instructions

##Database Setup

###Connect to the pre-populated database:

Bash
psql --username=freecodecamp --dbname=periodic_table
Use code with caution.

Familiarize yourself with existing tables (elements, properties) and columns.

###Git Repository

Create a project directory named periodic_table.

###Initialize a git repository within it:

Bash
cd periodic_table
git init
Use code with caution.

Bash Script Development

Create a file named element.sh to house your Bash script.

###Ensure it has executable permissions:

Bash
chmod +x element.sh
Use code with caution.

###Implement script logic to:

Accept user input as an argument (atomic number, symbol, or element name).
Connect to the database using psql command with appropriate credentials.
Craft a query to retrieve element information based on the provided argument.
Format and display the retrieved information, including:
Atomic number
Symbol
Name
Atomic Mass (amu)
Melting Point (Celsius)
Boiling Point (Celsius)
Type (metal, nonmetal, metalloid)
Handle cases where no element is found, displaying an appropriate message.
Database Modifications (Optional)

These changes are not strictly required for the core functionality, but demonstrate database manipulation skills:

###Column Renaming:

SQL
ALTER TABLE elements RENAME COLUMN weight TO atomic_mass;
ALTER TABLE elements RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE elements RENAME COLUMN boiling_point TO boiling_point_celsius;
Use code with caution.

###Constraints:

SQL
ALTER TABLE elements
ADD CONSTRAINT unique_symbol_name UNIQUE (symbol, name);
ALTER TABLE elements
ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements
ALTER COLUMN name SET NOT NULL;

ALTER   
 TABLE properties
ADD   
 CONSTRAINT fk_type_id FOREIGN KEY (type_id)
REFERENCES types(type_id);
Use code with caution.

###Types Table:

SQL
CREATE TABLE types (
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(255) NOT NULL
);

INSERT INTO types (type) VALUES ('metal'), ('nonmetal'), ('metalloid');
Use code with caution.

###Fixing Data Inconsistency:

SQL
UPDATE elements
SET symbol = UPPER(symbol);

UPDATE elements
SET atomic_mass = CAST(atomic_mass AS DECIMAL(10, 2));

UPDATE elements
SET atomic_mass = REPLACE(atomic_mass, '0*$', '');

INSERT INTO elements (atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (9, 'F', 'Fluorine', 18.998, -220, -188.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));

INSERT INTO elements (atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (10, 'Ne', 'Neon', 20.18, -248.6, -246.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));

DELETE FROM elements WHERE atomic_number = 1000; -- Remove nonexistent element

ALTER TABLE properties DROP COLUMN type;
Use code with caution.

###Testing

Test your script thoroughly with various inputs, ensuring it retrieves and displays information correctly.

###Committing Changes

Regularly commit your code changes with descriptive messages:

Bash
git add .
git commit -m "Initial commit" # First commit
git commit -m "feat: Added element search functionality" # Subsequent commits
Use code with caution.




###Submission (freeCodeCamp)

Follow freeCodeCamp's specific instructions to submit your project's URL, including the periodic_table.sql file, for evaluation.
Additional Tips

Consider using a linter to ensure code quality and consistency.
Explore more advanced database features like indexes, views, and stored procedures for performance optimization.
Add error handling mechanisms to your script for robustness.
Consider incorporating unit tests for script verification.
By following these guidelines, you'll create a well-structured, efficient, and informative periodic table database and Bash script.
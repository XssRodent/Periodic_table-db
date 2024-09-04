#!/bin/bash

# Check if the input argument is provided

if [ -z "$1" ]; then



  echo "Please provide an element as an argument."

else

# Database connection setup
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Query based on atomic number or name
if [[ $1 =~ ^[0-9]+$ ]]; then
  # Query for atomic number
  ELEMENT_INFO=$($PSQL "SELECT e.symbol, e.atomic_number, e.name, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
    FROM elements e
    INNER JOIN properties p ON e.atomic_number = p.atomic_number
    INNER JOIN types t ON p.type_id = t.type_id
    WHERE e.atomic_number = $1")
    
else
  # Query for symbol or name
  ELEMENT_INFO=$($PSQL "SELECT e.symbol, e.atomic_number, e.name, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius
    FROM elements e
    INNER JOIN properties p ON e.atomic_number = p.atomic_number
    INNER JOIN types t ON p.type_id = t.type_id
    WHERE e.symbol = '$1' OR e.name = '$1'")

fi

# Check if the query returned any results
if [ -z "$ELEMENT_INFO" ]; then
  echo "I could not find that element in the database."
else

# Output the result
echo "$ELEMENT_INFO" | while IFS='|' read SYMBOL NUM NAME TYPE MASS MELT BOIL; do
  echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
done
fi
fi


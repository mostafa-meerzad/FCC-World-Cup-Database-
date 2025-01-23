#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  # Create worldcup database if it doesn't esists
  psql --username=postgres -tc "SELECT 1 FROM pg_database WHERE datname='worldcup';" | grep -q 1 || psql --username=postgres -c "CREATE DATABASE worldcup;"
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

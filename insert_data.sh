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

# Drop tables if they exist
echo "$($PSQL "DROP TABLE IF EXISTS games, teams CASCADE;")"

# Create teams table
echo $($PSQL "CREATE TABLE teams(team_id SERIAL PRIMARY KEY, name VARCHAR NOT NULL UNIQUE)")

# Create teams table
echo $($PSQL "CREATE TABLE games(
  game_id SERIAL UNIQUE PRIMARY KEY, 
  year INT NOT NULL, 
  round VARCHAR NOT NULL,
  winner_id INT NOT NULL REFERENCES teams(team_id),
  opponent_id INT NOT NULL REFERENCES teams(team_id),
  winner_goals INT NOT NULL,
  opponent_goals INT NOT NULL)")

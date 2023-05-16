#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

skip_first_line=true
echo $($PSQL "TRUNCATE TABLE games, teams")
echo $($PSQL "ALTER SEQUENCE games_game_id_seq RESTART")
echo $($PSQL "ALTER SEQUENCE teams_team_id_seq RESTART")

while IFS=',' read -r year round winner opponent winner_goals opponent_goals
do
  if $skip_first_line
  then
    skip_first_line=false
    continue
  fi

  if [[ -z $($PSQL "SELECT name FROM teams WHERE name='$winner'") ]]
  then
    new_country=$($PSQL "INSERT INTO teams(name) VALUES('$winner')")
    echo -e "New country has been added: $winner"
  fi
  winner_id=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")

  if [[ -z $($PSQL "SELECT name FROM teams WHERE name='$opponent'") ]]
  then
    new_country=$($PSQL "INSERT INTO teams(name) VALUES('$opponent')")
    echo -e "New country has been added: $opponent"
  fi
  opponent_id=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")

  new_game=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals)")
  echo -e "New game has been added: $winner vs $opponent" 
done < "games.csv"
#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

skip_first_line=true
declare -i counter=0
countries=()
new_country_sql="INSERT INTO teams(name) VALUES"
game_sql="INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES"
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

  pass_win=0
  counter=1
  for country in "${countries[@]}"
  do
      if [ "$country" == "$winner" ]
      then
        pass_win=1
        winner_id=$counter
        break
      fi
    counter=$counter+1
  done

  pass_op=0
  counter=1
  for country in "${countries[@]}"
  do
      if [ "$country" == "$opponent" ]
      then
        pass_op=1
        opponent_id=$counter
        break
      fi
    counter=$counter+1
  done

  if [  $pass_win -eq 0 ]
  then
    new_country_sql+=" ('$winner'),"
    countries+=("$winner")
    winner_id=${#countries[@]}
    echo -e "New country has been prepared to insert into database: $winner, id = $winner_id"
  fi

  if [ $pass_op -eq 0 ]
  then
    new_country_sql+=" ('$opponent'),"
    countries+=("$opponent")
    opponent_id=${#countries[@]}
    echo -e "New country has been prepared to insert into database: $opponent, id = $opponent_id"
  fi

  game_sql+=" ($year, '$round', $winner_id, $opponent_id, $winner_goals, $opponent_goals),"
  echo -e "New game has been prepared to insert into database: $winner vs $opponent"
done < "games.csv"

new_country_sql="${new_country_sql%,}"
game_sql="${game_sql%,}"

echo $new_country_sql
echo $game_sql

echo $($PSQL "$new_country_sql")
echo $($PSQL "$game_sql")
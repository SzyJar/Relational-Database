#!/bin/bash

#check for database, if no database, create new one
PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"
DATABASE=$($PSQL "SELECT datname FROM pg_database WHERE datname='number_guess'")

if [[ -z $DATABASE ]]
then
CREATE_DATABASE=$($PSQL "CREATE DATABASE number_guess")
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
ADD_USERS_TABLE=$($PSQL "CREATE TABLE users()")
ADD_USER_ID=$($PSQL "ALTER TABLE users ADD COLUMN user_id SERIAL NOT NULL PRIMARY KEY")
ADD_USER_NAME=$($PSQL "ALTER TABLE users ADD COLUMN username VARCHAR(22) NOT NULL")
ADD_GAMES_PLAYED=$($PSQL "ALTER TABLE users ADD COLUMN games int NOT NULL")
ADD_GUESSES=$($PSQL "ALTER TABLE users ADD COLUMN guess int NOT NULL")
fi

#run guessing game
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "Enter your username:"
read USERNAME

CHECK_USERNAME=$($PSQL "SELECT * FROM users WHERE username='$USERNAME'")
if [[ -z $CHECK_USERNAME ]]
then
ADD_NEW_USER=$($PSQL "INSERT INTO users(username,games,guess) VALUES('$USERNAME',0,0)")
GAMES=0
GUESS=0
echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else
GAMES=$(echo "$CHECK_USERNAME" | awk -F '|' '{print $3}')
GUESS=$(echo "$CHECK_USERNAME" | awk -F '|' '{print $4}')
echo -e "Welcome back, $USERNAME! You have played $GAMES games, and your best game took $GUESS guesses."
fi

CURRENT_GUESS=0

echo -e "Guess the secret number between 1 and 1000:"

RANDOM_NUMBER=$((1 + RANDOM % 100))
while [[ $MY_GUESS != $RANDOM_NUMBER ]]
do
read MY_GUESS
((CURRENT_GUESS++))
if [[ ! $MY_GUESS =~ ^[0-9]+$ ]]
then
echo -e "That is not an integer, guess again:"
elif [[ $MY_GUESS -gt $RANDOM_NUMBER ]]
then
echo -e "It's lower than that, guess again:"
elif [[ $MY_GUESS -lt $RANDOM_NUMBER ]]
then
echo -e "It's higher than that, guess again:"
fi
done

((GAMES++))
echo -e "You guessed it in $CURRENT_GUESS tries. The secret number was $RANDOM_NUMBER. Nice job!"

if [[ $CURRENT_GUESS < $GUESS ]] || [[ 0 -eq $GUESS ]]
then
GUESS=$CURRENT_GUESS
fi

ENTER_RESULTS=$($PSQL "UPDATE users SET games = $GAMES, guess = $GUESS WHERE username='$USERNAME'")

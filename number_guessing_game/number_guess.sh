#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo Enter your username:
read NAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$NAME'");
# if not exists
if [[ -z $USER_ID ]]
then
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$NAME')")
  echo "Welcome, $NAME! It looks like this is your first time here."
else
  # user exists
  # query history
  GAME_COUNT=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(guess_times) FROM games WHERE user_id=$USER_ID")
  echo "Welcome back, $NAME! You have played $GAME_COUNT games, and your best game took $BEST_GAME guesses." 
fi

# guess numbers
echo Guess the secret number between 1 and 1000:
SECRET_NUMBER=$(( $RANDOM%1000 + 1 ))
GUESS_COUNT=0


while true
do
  # input number
  read GUESS
  # guess time ++
  ((GUESS_COUNT++))
  # if number is not int
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo That is not an integer, guess again:
  fi

  # if guess greater
  if [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
  fi

  # if guess lesser
  if [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  fi

  # if guess equeal
   if [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$NAME'");
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games (guess_times,user_id) VALUES($GUESS_COUNT,$USER_ID)")
    exit
  fi
done

#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
$PSQL "TRUNCATE games, teams;"
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS
  # insert teams
  # if这一行的team在表里是否存在，否则插入；
  if [[ $WINNER != winner ]]
  then
    WINNER_EXISTS=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_EXISTS ]]
    then
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      echo Insert team result:$INSERT_TEAM_RESULT
    fi

    OPPONENT_EXISTS=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPPONENT_EXISTS ]]
    then
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      echo Insert team result: $INSERT_TEAM_RESULT
    fi
  fi
done

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  # insert game
  if [[ $YEAR != year ]]
  then
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$YEAR','$ROUND','$WINNER_ID','$OPPONENT_ID','$WINNER_GOALS','$OPPONENT_GOALS');")
    echo Insert game result: $INSERT_GAME_RESULT 
  fi
done
#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

SERVICE_LIST () {
  SERVICES_RESULT=$($PSQL "SELECT * FROM services")
  if [[ -z $SERVICES_RESULT ]]
  then
    echo There is no services.
  else
    echo "$SERVICES_RESULT" | while read SERVICE_ID BAR SERVICE
    do  echo $SERVICE_ID\) $SERVICE  | sed 's/^ *//;s/ *$//'
    done
    SELECT_SERVICE
  fi
}

SELECT_SERVICE () {
  # select service
  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]*$ ]]
  then
    echo -e "\nPlease input the number of service"
    SERVICE_LIST
  else
    SERVICE_ID_RESULT=$($PSQL "SELECT service_id FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    # not in the list
    if [[ -z $SERVICE_ID_RESULT ]]
    then
      echo -e "\nI could not find that service. What would you like today?"
      SERVICE_LIST
    
    # in the list
    else
      # ask for phone number
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE

      # find name by phone number
      NAME_RESULT=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
      NAME_RESULT=$(echo $NAME_RESULT | sed 's/^ *//;s/ *$//')
      # no name found
      if [[ -z $NAME_RESULT ]]
      then
        # ask for name
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        # insert into customers
        INSERT_CUST_RESULT=$($PSQL "INSERT INTO customers (phone,name) VALUES ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      fi

      # ask for time
      NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" | sed 's/^ *//;s/ *$//')
      SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_RESULT" | sed 's/^ *//;s/ *$//')
      echo -e "\nWhat time would you like your $SERVICE,$NAME?"
      read SERVICE_TIME
      # insert into appointments
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
      echo $SERVICE,$SERVICE_TIME,$NAME
      INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id,service_id,time) VALUES ($CUSTOMER_ID,$SERVICE_ID_RESULT,'$SERVICE_TIME')")
      # echo result
      echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $NAME."
    fi
  fi
}

SERVICE_LIST

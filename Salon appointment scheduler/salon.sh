#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~"

SERVICES_MENU() {
  declare -i SERVICE_COUNT=0
  echo -e "\n$1"

  SERVICES=$($PSQL "SELECT * FROM services")
  while read SERVICE_ID NAME
  do
    echo $(echo $SERVICE_ID $NAME | sed 's/ |/) /')
    ((SERVICE_COUNT++))
  done < <(echo "$SERVICES")

  read SERVICE_ID_SELECTED
  if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]] && [[ $SERVICE_ID_SELECTED -le $SERVICE_COUNT ]] && [[ $SERVICE_ID_SELECTED != 0 ]]
  then
    SERVICE $SERVICE_ID_SELECTED
  fi
  SERVICES_MENU "I could not find that service. What would you like today?"
}

SERVICE() {
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $1")
  echo "What's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_ID ]]
  then
    echo "I don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_INFO=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    else
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  fi
  echo "What time would you like your$SERVICE_NAME, $(echo $CUSTOMER_NAME | sed 's/ |/"/')."
  read SERVICE_TIME
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$1', '$SERVICE_TIME')")
    
  echo "I have put you down for a$SERVICE_NAME at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed 's/ |/"/')."
  exit
}

SERVICES_MENU "Welcome to My Salon, how can I help you?"
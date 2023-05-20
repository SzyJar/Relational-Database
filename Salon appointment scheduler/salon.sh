#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

SERVICES_MENU() {
  declare -i SERVICE_COUNT=0
  echo -e "\n$1"

  SERVICES=$($PSQL "SELECT * FROM services")
  while read SERVICE_ID NAME
  do
    echo $(echo $SERVICE_ID $NAME | sed 's/ |/) /')
    ((SERVICE_COUNT++))
  done < <(echo "$SERVICES")

  echo -e "0) exit"
  echo $SERVICE_COUNT
  read SERVICES_MENU_SELECTION

  if [[ $SERVICES_MENU_SELECTION == 0 ]]
  then
    echo -e "\nThank you for stopping in.\n"
    exit
  elif [[ $SERVICES_MENU_SELECTION -le $SERVICE_COUNT ]]
  then
    SERVICE $SERVICES_MENU_SELECTION
  fi
  SERVICES_MENU "I could not find that service. What would you like today?"
}

SERVICE() {
  echo "What's your phone number?"
  read PHONE_NUMBER
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$PHONE_NUMBER'")
  if [[ -z $CUSTOMER_ID ]]
  then
    echo "I don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_INFO=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$PHONE_NUMBER')")
  fi
  echo "What time would you like your color, $CUSTOMER_NAME."
  read APPOINTMENT_TIME
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$1', $APPOINTMENT_TIME)")
  
  
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $1")
  echo "I have put you down for a $SERVICE_NAME at $APPOINTMENT_TIME, $CUSTOMER_NAME."

}

SERVICES_MENU "Welcome to My Salon, how can I help you?"
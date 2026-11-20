if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  PSQL='psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c'
  if [[ $1 =~ [0-9] ]]
  then
    FIND_ELEMENT=$($PSQL "SELECT * FROM elements RIGHT JOIN properties USING (atomic_number) RIGHT JOIN types USING (type_id) WHERE atomic_number = $1;")
    if [[ -z $FIND_ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      IFS='|' read TYPE_ID ID SYMBOL NAME MASS MELT_POINT BOIL_POINT TYPE<<<$FIND_ELEMENT
      echo "The element with atomic number $ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
    fi
  else
    FIND_ELEMENT=$($PSQL "SELECT * FROM elements RIGHT JOIN properties USING (atomic_number) RIGHT JOIN types USING (type_id) WHERE symbol = '$1' OR name = '$1';")
    if [[ -z $FIND_ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      IFS='|' read TYPE_ID ID SYMBOL NAME MASS MELT_POINT BOIL_POINT TYPE<<<$FIND_ELEMENT
      echo "The element with atomic number $ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
    fi
  fi
fi
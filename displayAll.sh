#!/bin/bash
# ------------------------------------------------------------------
# [DragonStuff] PokeCHIP
#  This file displays all known Pokemon.
# ------------------------------------------------------------------

VERSION=0.0.1
SUBJECT=Show_All_Pokemon
USAGE="Usage: displayAll.sh"

# --- Options processing -------------------------------------------
if [ $# <= 1 ] ; then
    echo $USAGE
    exit 1;
fi

while getopts ":i:vh" optname
  do
    case "$optname" in
      "v")
        echo "Version $VERSION"
        exit 0;
        ;;
      "i")
        echo "-i argument: $OPTARG"
        ;;
      "h")
        echo $USAGE
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done

shift $(($OPTIND - 1))

search_Name=$1

# --- Locks -------------------------------------------------------
LOCK_FILE=/tmp/$SUBJECT.lock
if [ -f "$LOCK_FILE" ]; then
   echo "Script is already running"
   exit
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE


# --- Body --------------------------------------------------------
for i in {1..721}
do
    pid=`./search.sh pokemon.csv id $i | grep \"id\"\: | sed 's/.$//'`
    pname=`./search.sh pokemon.csv id $i | grep identifier | sed 's/.$//'`
    ptype_id_ext=`./search.sh pokemon_types.csv pokemon_id $i | grep \"type_id\"\: | grep -o '\"[0-9]*\"' | cut -d "\"" -f 2`
    ptype=`./search.sh types.csv id $ptype_id_ext | grep identifier`
    echo - ID: `echo ${pid:8}| cut -d "\"" -f 2`\ \| `echo Name: ${pname:16}`\ \| Type: `echo ${ptype:16} | cut -d "\"" -f 2`
done

for i in {10001..10090}
do
    pid=`./search.sh pokemon.csv id $i | grep \"id\"\: | sed 's/.$//'`
    pname=`./search.sh pokemon.csv id $i | grep identifier | sed 's/.$//'`
    ptype_id_ext=`./search.sh pokemon_dex_numbers.csv pokedex_number $i | grep \"pokedex_id\"\: | grep -o '\"[0-9]*\"' | cut -d "\"" -f 2`
    ptype=`./search.sh types.csv id $ptype_id_ext | grep identifier`
    echo - ID: `echo ${pid:8}| cut -d "\"" -f 2`\ \| `echo Name: ${pname:16}`\ \| Type: `echo ${ptype:16} | cut -d "\"" -f 2`
done
# -----------------------------------------------------------------
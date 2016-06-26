#!/bin/bash
# ------------------------------------------------------------------
# [DragonStuff] PokeCHIP
#  This file searches a specific dataset and outputs matches.
# ------------------------------------------------------------------

VERSION=0.0.1
SUBJECT=Search_Datasets_By_Name
USAGE="Usage: namesearch.sh -ihv dataset search_heading search_query"

# --- Options processing -------------------------------------------
if [ $# == 0 ] ; then
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
# Searching using search.sh
echo Searching for Pokemon: $search_Name
data=``
pid=`./search.sh pokemon.csv identifier $search_Name | grep \"id\"\: | sed 's/.$//'`
pname=`./search.sh pokemon.csv identifier $search_Name | grep identifier | sed 's/.$//'`
pheight=`./search.sh pokemon.csv identifier $search_Name | grep height | sed 's/.$//'`
pweight=`./search.sh pokemon.csv identifier $search_Name | grep weight`
ptype_id_ext=`./search.sh pokemon.csv identifier $search_Name | grep \"id\"\: | grep -o '\"[0-9]*\"' | cut -d "\"" -f 2`
ptype=`./search.sh types.csv id $ptype_id_ext | grep identifier`
pdescription_ext=`./search.sh pokemon.csv identifier $search_Name | grep species_id | grep -o '\"[0-9]*\"' | cut -d "\"" -f 2`
pdescription=`jq '.[] | select((.species_id == '$pdescription_ext') and (.language_id == 9) and (.version_id == 1))' Data/JSON/pokemon_species_flavor_text.csv.json | grep flavor_text`

echo -e ________________________________________
echo -e \| Info\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \|
echo -e \|--------------------------------------\|
echo -e \| `echo $pid`\ \| `echo $pname`\|
echo -e \|--------------------------------------\|
echo -e \| `echo $ptype`\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \|
echo -e \|--------------------------------------\|
echo -e \| `echo $pheight`         \| `echo $pweight`\ \ \ \ \ \ \ \|
echo -e \|--------------------------------------\|
echo -e `echo "$pdescription"`
echo -e \|______________________________________\|
# -----------------------------------------------------------------
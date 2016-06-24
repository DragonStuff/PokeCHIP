#!/bin/bash
# ------------------------------------------------------------------
# [DragonStuff] PokeCHIP
#  This file searches a specific dataset and outputs matches.
# ------------------------------------------------------------------

VERSION=0.0.1
SUBJECT=Search_Datasets
USAGE="Usage: command -ihv args"

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

dataset=$1
searchHeading=$2
searchQuery=$3


# --- Locks -------------------------------------------------------
LOCK_FILE=/tmp/$SUBJECT.lock
if [ -f "$LOCK_FILE" ]; then
   echo "Script is already running"
   exit
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE


# --- Body --------------------------------------------------------
# Searching using jq
echo Arguments: $1, $2, $3
export searchHeading
export searchQuery
echo Searching $dataset for "$searchHeading/$searchQuery"...
echo File length: 
cat Data/JSON/$dataset.json | jq 'length'
jq '.[] | select(."'$searchHeading'" == "'$searchQuery'")' Data/JSON/$dataset.json

# -----------------------------------------------------------------
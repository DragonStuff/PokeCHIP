#!/bin/bash
# ------------------------------------------------------------------
# [DragonStuff] PokeCHIP
#  This file searches a specific dataset and outputs matches.
# ------------------------------------------------------------------

VERSION=0.0.1
SUBJECT=Search_Datasets_By_Name
USAGE="Usage: namesearch.sh -ihv search_query"

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
echo Searching for pokemon type, name or id similar to: $search_Name
echo Number of similarities: `cat displayAll_Database_PreRendered.txt | grep -c $search_Name`
cat displayAll_Database_PreRendered.txt | grep $search_Name
#!/bin/bash
# ------------------------------------------------------------------
# [DragonStuff] PokeCHIP
#  This file interfaces with the searching scripts.
# ------------------------------------------------------------------

PS3='Please enter your choice: '
options=("Display All" "Search by Name" "Search by ID" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Display All")
            # 1
            ;;
        "Search by Name")
            # 2
            ;;
        "Search by ID")
            # 3
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
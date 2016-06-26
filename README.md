# PokeCHIP
[![SUSHI-WARE LICENSE](https://img.shields.io/badge/license-SUSHI--WARE%F0%9F%8D%A3-blue.svg)](https://github.com/MakeNowJust/sushi-ware)

Pokédex for PocketCHIP.

## Usage

./search.sh 
`./search.sh -ihv dataset search_heading search_query`

## Example:
`./search.sh pokemon.csv identifier $search_Name`
    {
    "base_experience": "64",
    "height": "7",
    "id": "1",
    "identifier": "bulbasaur",
    "is_default": "1",
    "order": "1",
    "species_id": "1",
    "weight": "69"
    }

## Usage
./namesearch.sh
`namesearch.sh -ihv search_query`

## Example:

    namesearch.sh bulbasaur
    
    Searching for Pokemon: bulbasaur
    ________________________________________
    | Info                                 |
    |--------------------------------------|
    | ID: 1 | Name: "bulbasaur"
    |--------------------------------------|
    | Type: normal
    |--------------------------------------|
    | H: "7" | W: "69"
    |--------------------------------------|
    "A strange seed was
    planted on its
    back at birth.
    The plant sprouts
    and grows with
    this POKéMON."
    |______________________________________|
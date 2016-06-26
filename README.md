# PokeCHIP
[![SUSHI-WARE LICENSE](https://img.shields.io/badge/license-SUSHI--WARE%F0%9F%8D%A3-blue.svg)](https://github.com/MakeNowJust/sushi-ware)

Pokédex for PocketCHIP.

## Usage
./displayAll.sh
`./displayAll.sh`

## Example:

    ./displayAll.sh
    - ID: 1 | Name: "bulbasaur" | Type: grass
    - ID: 2 | Name: "ivysaur" | Type: grass
    - ID: 3 | Name: "venusaur" | Type: grass
    - ID: 4 | Name: "charmander" | Type: fire
    - ID: 5 | Name: "charmeleon" | Type: fire
    - ID: 6 | Name: "charizard" | Type: fire
    - ID: 7 | Name: "squirtle" | Type: water
    - ID: 8 | Name: "wartortle" | Type: water
    - ID: 9 | Name: "blastoise" | Type: water
    ...


## Usage

./search.sh 
`./search.sh -ihv dataset search_heading search_query`

## Example:

    ./search.sh pokemon.csv identifier $search_Name
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
    
    
### Information:

There are some datasets that did not process correctly due to the maintainer of the original datasets (https://github.com/PokeAPI/pokeapi/tree/master/data/v2/csv) not implementing their CSV correctly- line breaks everywhere :sad_face:.

Please see the file "datasets_to_be_fixed.txt" for datasets that processed with an error.

If you see that the dataset you want has an error, it's probably caused by either newlines or ending with the delimiter.

You can fix this with: `sed '/[0-9],$/ s/$/null/'`

You can also easily convert it without using the sometimes inaccurate tools in this repository by using: http://www.csvjson.com/csv2json
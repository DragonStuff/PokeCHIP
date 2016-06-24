FILES=Data/CSV/*.csv
rm Data/JSON/*.json

for f in $FILES
do
  echo "Processing $f file..."
  b=$(basename $f)
  ./csv2json.sh $f > Data/JSON/$b.tmp
  cat Data/JSON/$b.tmp | tr -s '\"' > Data/JSON/$b.tmp.2
  python -mjson.tool Data/JSON/$b.tmp.2 | tr -s '\"' > Data/JSON/$b.json
  rm Data/JSON/$b.tmp*
done
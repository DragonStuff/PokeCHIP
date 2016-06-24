FILES=Data/CSV/*.csv
rm Data/JSON/*.json

for f in $FILES
do
  echo "Processing $f file..."
  b=$(basename $f)
  ./csv2json.sh $f > Data/JSON/$b.tmp
  python -mjson.tool Data/JSON/$b.tmp > Data/JSON/$b.json
  rm Data/JSON/$b.tmp
done
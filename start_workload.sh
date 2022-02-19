hey -c 40 -z 10m -q 1 -d "100" -t 0  -o csv http://127.0.0.1:31112/function/json-dumps > hey_json-dumps.csv &
sleep 4m
hey -c 15 -z 2m -q 1 -d "100" -t 0 -o csv http://127.0.0.1:31112/function/deltablue>hey_deltablue.csv &

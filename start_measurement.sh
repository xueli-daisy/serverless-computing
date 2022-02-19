#perf
echo Cloudsys2016 | sudo -S perf stat -a -o perf_json-dumps.csv -I 30000 sleep 10m &
#metrics
python record_metrics.py  metrics_json-dumps.csv json-dumps &
python record_metrics.py  metrics_deltablue.csv deltablue &

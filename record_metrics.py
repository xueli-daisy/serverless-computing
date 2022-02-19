import time
import subprocess
import math
import sys

i = 0
sampling_interval=30
metrics_file_name=sys.argv[1]
function_name=sys.argv[2]

while i < 35:
    time.sleep(sampling_interval)
    subprocess.run(['python', 'currentTimeQuery.py', metrics_file_name, str(function_name)], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    print("i:",i)
    i = i + 1


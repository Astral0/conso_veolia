#!/bin/bash

# Timeout in secondes
timeout=30

# Get current directory
set_root() {
    local this=`readlink -n -f $1`
    root=`dirname $this`
}
set_root $0

#export PYTHONPATH=${root}/meross_iot/

timeout --signal=SIGINT ${timeout} python3 $root/get_veolia_idf_consommation.py $*
codret=$?

# Kill ghosts processes
nbprocess=$(pgrep -u www-data -f "python3 $root/get_veolia_idf_consommation.py" -c)
if [ ! $nbprocess -eq 0 ]; then
    pkill -u www-data -f "python3 $root/get_veolia_idf_consommation.py"
fi

exit ${codret}


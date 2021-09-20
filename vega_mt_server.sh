#!/bin/bash
echo "sh /vega_mt_server/vega_mt_server.sh"
./vega_mt_server --daemon --log=/tmp/vega_mt_server.log --log_old=/tmp/vega_mt_server.old.log --log_lim=1000000 --cfg=/vega_mt_server/vega_mt_server.cfg
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

while sleep 60; do
  ps aux |grep vega_mt_server |grep -q -v grep
  PROCESS_STATUS=$?
  if [ $PROCESS_STATUS -ne 0 -o $PROCESS_STATUS -ne 0 ]; then
    echo "Processes has exited."
    exit 1
  fi
done
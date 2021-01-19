#!/bin/bash

set -e

mkdir -p /run/liara

python3 /usr/local/lib/liara/load_profile.py

# Start cron service
if [ ! -z "$__CRON" ]; then
  echo '[CRON] Starting...';
  supercronic ${SUPERCRONIC_OPTIONS} /run/liara/crontab &
fi

# Let's start our webservers
echo '[GUNICORN] Starting...'
gunicorn $(python3 /usr/local/lib/liara/find-wsgi.py $(/usr/local/lib/liara/find-settings.sh)) --bind 127.0.0.1:8000 \
  --timeout ${GUNICORN_TIMEOUT:-30} \
  --log-level ${GUNICORN_LOG_LEVEL:-info} &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start gunicorn: $status"
  exit $status
fi

echo '[NGINX] Starting...'
nginx
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 60; do
  ps aux |grep gunicorn |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep nginx |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done

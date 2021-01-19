#!/bin/bash

if [ ! -z "$__DJANGO_SETTINGSFILE" ]; then
  echo "$__DJANGO_SETTINGSFILE"
  exit 0
fi

# https://stackoverflow.com/a/6637894/6390238
RESULT=$(grep -l -R WSGI_APPLICATION --include \*.py --exclude-dir venv)

# https://stackoverflow.com/a/60811975/6390238
if [ "$(echo "$RESULT" | wc -l)" -gt "1" ]; then
  echo "Error: We have found multiple settings files for your Django app:"
  echo "$RESULT" | awk '{print "  " NR  ") " $s}'
  echo
  echo "Create a liara.json file in your project's root directory with the following content:"
  echo "{
  \"django\": {
    \"settingsFile\": \"my-project/settings.py\"
  }
}"
  echo "You should put your actual settings file path into the above file."
  echo
  echo "> Read more: https://docs.liara.ir/errors/django-settings-file"
  echo
  exit 2
fi

echo "$RESULT"

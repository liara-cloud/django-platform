#!/bin/bash

if [ ! -z "$__DJANGO_SETTINGSFILE" ]; then
  echo "$__DJANGO_SETTINGSFILE"
  exit 0
fi

# https://stackoverflow.com/a/6637894/6390238
RESULT=$(grep -l -R WSGI_APPLICATION --include \*.py --exclude-dir venv)

# https://stackoverflow.com/a/60811975/6390238
if [ "$(echo "$RESULT" | wc -l)" -gt "1" ]; then
  echo "$RESULT"
  exit 2
fi

echo "$RESULT"

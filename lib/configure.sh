#!/bin/bash

set -e

# Append our custom settings
if [ "$__DJANGO_MODIFY_SETTINGS" = "true" ]; then
  cat /usr/local/lib/liara/settings-template.py >> $(/usr/local/lib/liara/find-settings.sh)
fi

if [ "$__DJANGO_COLLECTSTATIC" = "true" ]; then
  echo '> Running collectstatic...'
  mkdir staticfiles
  python manage.py collectstatic --no-input
fi

if [ "$__DJANGO_COMPILEMESSAGES" = "true" ]; then
  echo '> Running compilemessages...'
  python manage.py compilemessages
fi

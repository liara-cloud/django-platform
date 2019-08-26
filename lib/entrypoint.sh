#!/bin/bash

# Find settings module
SETTINGS_MODULE=$(find . -name 'settings.py' | sed -e "s/^\.\///" | sed -e "s/\.py$//" | sed -e "s/\//./")

# Find wsgi
WSGI_FILE=$(python find-wsgi.py $SETTINGS_MODULE)

rm find-wsgi.py Dockerfile

# Run gunicorn in background
gunicorn $WSGI_FILE --bind 0.0.0.0:8000

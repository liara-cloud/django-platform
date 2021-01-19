#!/bin/bash

cd $(dirname $(realpath $0))

output=$(cd fixtures && ../../lib/find-settings.sh)
echo 'TestCase 1) Multiple settings file'
echo "$output" | grep -q 'multiple' && echo 'PASS' || echo 'FAIL!!'

output=$(cd fixtures/settings-file && ../../../lib/find-settings.sh)
echo 'TestCase 2) Standard settings.py file'
echo "$output" | grep -q 'theproject/settings.py' && echo 'PASS' || echo 'FAIL!!'

output=$(cd fixtures/settings-module && ../../../lib/find-settings.sh)
echo 'TestCase 3) Settings as a python module'
echo "$output" | grep -q 'theproject/settings/dj.py' && echo 'PASS' || echo 'FAIL!!'

output=$(__DJANGO_SETTINGSFILE=boom.py ../lib/find-settings.sh)
echo 'TestCase 3) settingsFile parameter'
echo "$output" | grep -q 'boom.py' && echo 'PASS' || echo 'FAIL!!'

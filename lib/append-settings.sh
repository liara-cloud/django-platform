# Find settings file
SETTINGS_FILE=$(find . -name 'settings.py' | grep -z . || find . -wholename "**/settings/__init__.py")

# Append our custom settings
cat /usr/local/lib/liara-django/liara_django_settings_temp.py >> $SETTINGS_FILE

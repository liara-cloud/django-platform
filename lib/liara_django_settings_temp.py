
####
#### The following configuration is automatically appended by Liara.
####
try:
  ALLOWED_HOSTS = tuple(['*'] + list(ALLOWED_HOSTS))
except NameError:
  ALLOWED_HOSTS = ['*']

# Configure static path
# TODO: Allow user to customize these 2 settings via build args.
# TODO: We might just need to check if these are empty then we can configure them.
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATIC_URL = '/static/'

# Configure HTTPS
USE_X_FORWARDED_HOST = True
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

if 'DEBUG' in os.environ:
  # Set the Django setting from the environment variable.
  DEBUG = os.environ['DEBUG'].lower() in ['true', '1']

if 'SECRET_KEY' in os.environ:
  # Set the Django setting from the environment variable.
  SECRET_KEY = os.environ['SECRET_KEY']


# Configure database
import dj_database_url

MAX_CONN_AGE = 600

if 'DATABASES' not in locals():
  DATABASES = {'default': None}

try:
  conn_max_age = CONN_MAX_AGE or MAX_CONN_AGE
except NameError:
  conn_max_age = MAX_CONN_AGE

if 'DATABASE_URL' in os.environ:
  DATABASES['default'] = dj_database_url.config(conn_max_age=conn_max_age, ssl_require=False)

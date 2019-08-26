####
#### The following configuration is automatically appended by Liara.
####
try:
  ALLOWED_HOSTS = tuple(['*'] + list(ALLOWED_HOSTS))
except NameError:
  ALLOWED_HOSTS = ['*']

# Insert Whitenoise Middleware.
try:
  MIDDLEWARE_CLASSES = tuple(['whitenoise.middleware.WhiteNoiseMiddleware'] + list(MIDDLEWARE_CLASSES))
except NameError:
  MIDDLEWARE = tuple(['whitenoise.middleware.WhiteNoiseMiddleware'] + list(MIDDLEWARE))

# Enable GZip.
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'

# Configure static path
# TODO: Allow user to customize these 2 settings via build args.
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

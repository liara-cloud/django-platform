FROM python:3.7

WORKDIR /usr/src/app

COPY lib/* /usr/local/lib/liara-django/

ONBUILD COPY . .

ONBUILD RUN pip install --disable-pip-version-check --no-cache-dir -r requirements.txt \
  && chmod +x /usr/local/lib/liara-django/*.sh \
  && /usr/local/lib/liara-django/append-settings.sh \
  && mkdir staticfiles \
  && python manage.py collectstatic \
  && mv /usr/local/lib/liara-django/find-wsgi.py find-wsgi.py

CMD /usr/local/lib/liara-django/entrypoint.sh

EXPOSE 8000

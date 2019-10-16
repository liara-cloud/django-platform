FROM python:3.7

WORKDIR /usr/src/app

RUN addgroup --system nginx \
    && adduser --system --disabled-login --ingroup nginx --no-create-home --home /nonexistent --gecos "nginx user" --shell /bin/false --uid 101 nginx \
    && apt-get update && apt-get install -y --no-install-recommends nginx

COPY lib/* /usr/local/lib/liara-django/
COPY nginx.conf /etc/nginx/nginx.conf
COPY liara_nginx.conf /etc/nginx/conf.d/liara_nginx.conf
COPY liara_nginx.conf .

ONBUILD COPY . .

ONBUILD RUN if cmp /etc/nginx/conf.d/liara_nginx.conf liara_nginx.conf; \
  then \
    echo 'Applying default liara_nginx.conf...'; \
  else \
    echo 'Applying custom liara_nginx.conf...'; \
    mv liara_nginx.conf /etc/nginx/conf.d/liara_nginx.conf; \
fi

ONBUILD RUN pip install --disable-pip-version-check --no-cache-dir -r requirements.txt \
  && pip install --disable-pip-version-check --no-cache-dir dj-database-url 'gunicorn==19.9.0' \
  && chmod +x /usr/local/lib/liara-django/*.sh \
  && /usr/local/lib/liara-django/append-settings.sh \
  && mkdir staticfiles \
  && python manage.py collectstatic \
  && mv /usr/local/lib/liara-django/find-wsgi.py find-wsgi.py

CMD /usr/local/lib/liara-django/entrypoint.sh

EXPOSE 8000

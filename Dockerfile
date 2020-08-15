FROM python:3.7

WORKDIR /usr/src/app

RUN addgroup --system nginx \
    && adduser --system --disabled-login --ingroup nginx --no-create-home --home /nonexistent --gecos "nginx user" --shell /bin/false --uid 101 nginx \
    && apt-get update && apt-get install -y --no-install-recommends nginx libpq-dev cron vim \
    && ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

COPY --from=liaracloud/supercronic:v0.1.11 /usr/local/bin/supercronic /usr/local/bin/supercronic

COPY lib/* /usr/local/lib/liara-django/
COPY nginx.conf /etc/nginx/nginx.conf
COPY liara_nginx.conf /etc/nginx/conf.d/liara_nginx.conf

ONBUILD COPY . .

ONBUILD ARG __DJANGO_TIMEZONE=Asia/Tehran
ONBUILD ENV TZ=${__DJANGO_TIMEZONE}

ONBUILD RUN if [ -e liara_nginx.conf ]; \
  then \
    echo 'Applying custom liara_nginx.conf...'; \
    mv liara_nginx.conf /etc/nginx/conf.d/liara_nginx.conf; \
  else \
    echo 'Applying default liara_nginx.conf...'; \
fi \
  && echo 'Configuring timezone:' $TZ && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezonero

ONBUILD RUN pip install --disable-pip-version-check --no-cache-dir -r requirements.txt \
  && pip install --disable-pip-version-check --no-cache-dir dj-database-url 'gunicorn==19.9.0' \
  && chmod +x /usr/local/lib/liara-django/*.sh \
  && /usr/local/lib/liara-django/append-settings.sh \
  && mkdir staticfiles \
  && python manage.py collectstatic --no-input

ENV ROOT=/usr/src/app

ONBUILD ARG __CRON
ONBUILD ENV __CRON=${__CRON}

CMD /usr/local/lib/liara-django/entrypoint.sh

EXPOSE 8000

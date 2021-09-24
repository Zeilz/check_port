#!/bin/bash

if [ "$DATABASE" = "postgres"]; then
  echo "Waiting for postgres"

  while ! nc -z $DATABASE_HOST $DATABASE_PORT; do
    sleep 1
  done

  echo "Postgresql probably started"
fi

echo "Making migrations and migrating database"
python manage.py makemigrations main --noinput
python manage.py migrate --noinput

exec "$@"
docker container exec kittygram-final-backend-1 python manage.py migrate
docker container exec kittygram-final-backend-1 python manage.py collectstatic
docker container exec kittygram-final-backend-1 cp -r /app/collected_static/. /static/static/

#!/bin/sh

echo  $DB_SERVER
echo  $DB_PORT
#echo  $DB_USERNAME
echo  $DATABASE_NAME
#echo  $DB_PASSWORD
echo  $EMAIL_USER
#echo  $EMAIL_PASS
#echo  $SECRET_KEY
echo  $SQLALCHEMY_TRACK_MODIFICATIONS
echo  $MAIL_SERVER
echo  $MAIL_PORT
echo  $MAIL_USE_TLS
echo  $FLASK_APP

ls -lrt

if [ ! -f flaskblog/static/main.css ]
then
  echo 'Copying static files...' 
  cp -r static/* flaskblog/static/
fi

mkdir -p /app/logs/
touch /app/logs/gunicorn.log

echo "Waiting for DB to be up and running ..."
sleep 60

flask db upgrade
echo "DB is successfully configured !!"

gunicorn run:app \
  --bind 0.0.0.0:5000 \
  --workers 4 \
  --log-file /app/logs/gunicorn.log \
  --log-level DEBUG \
  --reload

echo "Application started successfully !!"

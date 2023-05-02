#!/bin/bash
nohup redis-server &
source /board/venv/bin/activate
cp nginx.conf /etc/nginx/nginx.conf
#apt-get install -y ssh
#apt-get install -y expect
nginx -c /etc/nginx/nginx.conf
cd src && pip install -r requirements.txt
supervisorctl stop beater
supervisorctl stop recover
ps -ef | grep bg.beats | grep -v color | awk '{print $2}' | xargs kill -9
gunicorn -c gunicorn.conf.py app:app  >/dev/null 2>&1

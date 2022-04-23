#!/bin/bash
nohup redis-server &
source /board/venv/bin/activate
cp nginx.conf /etc/nginx/nginx.conf
#apt-get install -y ssh
#apt-get install -y expect
nginx -c /etc/nginx/nginx.conf
cd src && pip install -r requirements.txt
gunicorn -c gunicorn.conf.py app:app  >/dev/null 2>&1

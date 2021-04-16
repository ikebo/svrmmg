#!/bin/bash
nohup redis-server &
source /board/venv/bin/activate
cp nginx.conf /etc/nginx/nginx.conf
nginx -c /etc/nginx/nginx.conf
cd src && pip install -r requirements.txt
sh heart_beat_firer.sh
gunicorn -c gunicorn.conf.py app:app  >>runtime.log 2>&1

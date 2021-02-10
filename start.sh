#!/bin/bash
nohup redis-server &
source /board/venv/bin/activate
nginx -c /etc/nginx/nginx.conf
cd src && pip install -r requirements.txt && gunicorn -c gunicorn.conf.py app:app  >>runtime.log 2>&1

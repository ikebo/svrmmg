FROM ubuntu:16.04
ENV CT="210128"

# 支持apt-get https
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates

# 换国内源
ADD ./sources.list /etc/apt/sources.list
RUN apt-get update

# 安装redis & common utils
RUN apt-get install -y redis-server redis-tools
RUN apt-get install -y software-properties-common
RUN apt-get update
RUN apt-get install -y iputils-ping net-tools telnet vim

# 使用本地http代理, 加速后面的repository下载
ENV http_proxy=http://172.22.132.124:1087

# 安装python3.7 & pip3 & supervisor
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.7
RUN apt-get install -y python3-pip
RUN add-apt-repository universe
RUN apt-get update
RUN apt-get install -y supervisor
#ADD ./svrmg.conf /etc/supervisor/conf.d/
#RUN supervisord -c /etc/supervisor/supervisord.conf

# 安装nginx
RUN apt-get install -y nginx
ADD ./nginx.conf /etc/nginx/nginx.conf

# 安装 virtualenv
RUN apt-get install -y python-virtualenv

# 去掉代理，以免影响容器访问网络
ENV http_proxy=

# 加载代码 & 配置文件 & 启动脚本
Add ./requirements.txt /board/

# 启动
RUN virtualenv -p /usr/bin/python3.7 /board/venv
RUN /bin/bash -c "cd /board && source venv/bin/activate && pip install -r requirements.txt"

EXPOSE 80
EXPOSE 5000

CMD cp /project/svrmg.conf /etc/supervisor/conf.d/ && supervisord -n -c /etc/supervisor/supervisord.conf

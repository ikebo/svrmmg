docker run -it -d --name svrmg -v $(pwd)/src/nginx.conf:/etc/nginx/nginx.conf -v $(pwd):/project -p 0.0.0.0:80:80/tcp -p 0.0.0.0:5000:5000/tcp egbertke/svrmg

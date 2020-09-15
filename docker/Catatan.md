Download docker images from docker hub 
======================================
```
# pull docker images
docker pull openresty/openresty:1.17.8.2-2-alpine-fat
````

usage openresty on docker 
=========================
```
# i use alpine-fat 
sudo docker run <option> openresty/openresty:1.17.8.2-4-alpine-fat
# sudo docker run <option> <images_name>:<tags>
# <option> can insert with
# -p to maps port
# -v to maps volume
# -d to daemonize (or runing on the backgrounds)

# comple command by alfa
sudo docker run --name openresty -p 80:80 -d openresty/openresty:1.17.8.2-4-alpine-fat
```

Nginx config file 
==================
1. first you must insert default configuration openresty nginx conf to your custom `nginx.conf`
```
include /etc/nginx/conf.d/*.conf;
```
2. run openresty docker with custom nginx.conf
```
sudo docker run -v /home/alfa/Playground/Catatan/Openresty/test/docker/conf.d:/etc/nginx/conf.d -p 80:80 openresty/openresty:1.17.8.2-4-alpine-fat
```



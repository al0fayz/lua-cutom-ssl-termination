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

# complite command by alfa
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
sudo docker run --name openresty -v /home/alfa/Playground/Catatan/Openresty/test/docker/conf.d:/etc/nginx/conf.d -p 80:80 -d openresty/openresty:1.17.8.2-4-alpine-fat
```

docker-compose example
========================
```
cd /dockerfile

#build image with docker-compose (this run on folder with there is a `docker-compose.yml` file exist)
sudo docker-compose up -d

```

Best Parctice
==============
for project existing very dificult for use docker container openresty because you must maps volume for :
- ssl path
- project path
- php fpm path 
- php ini
this is dificult for manage. i sugest if project is exist install openresty on system and custom on nginx.conf directly . and you can run with `service openresty start` . this is bad but i think best practice.

Bugs
======
configuration with redirect http to https on line here
```
     server_name _;
    # redirect http to https
    
    if ($http_x_forwarded_proto = "http") {
        return 301 https://$server_name$request_uri;
    }
```
can't run on Mozilla but run perfect in Chrome , i don't understand why?

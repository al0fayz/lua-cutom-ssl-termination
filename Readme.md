Description
===========
	This is a example of custom configuration nginx with openresty. I make it for use multiple ssl load in single server without reload . 

Requirements 
============
	1. Openresty
	 * Install OpenResty (Nginx + Lua prepackaged) :
    https://openresty.org/en/getting-started.html
	
Example on Here
=============== 
* [Server Name Indication (SNI)](https://en.wikipedia.org/wiki/Server_Name_Indication),
* Multiple Ssl without Reload Nginx 
* Redirect http to https

How to use in Ubuntu
====================
* edit host in local ex: `/etc/hosts` and add some host , example:
```
127.0.0.1       siomaygepeng.my.id
127.0.0.1       boyfajar.my.id
127.0.0.1       maratun.my.id
127.0.0.1       idads.my.id
```

* check service openresty run or not `sudo service --status-all`
* if not run you can run with `sudo service openresty start`
* if error port 80 in use ,you can stop service uses port 80
* look port listening for get service uses port ` sudo lsof -i -P -n | grep LISTEN ` and stop service,  on my machine service use port 80 is apache2 so I stop with `sudo service apache2 stop` and run service openresty again
* finaly you can run nginx with custom conf, example:
```
nginx -p `pwd`/ -c success.conf
```
* if nginx is not found you can add path openresty nginx in your machine like
```
## export path for runing nginx
PATH=/usr/local/openresty/nginx/sbin:$PATH
export PATH
```
* you can test with open your favorite browser and type `https://idads.my.id`
(certificate on here generate by [zerossl](https://zerossl.com/) with 90 day of expired, so if certificate expired you can generate self in zerossl with other domain.)


# auto ssl
```
#make folder for ssl
sudo mkdir /etc/resty-auto-ssl
sudo chown www-data /etc/resty-auto-ssl

# install package with opm
#look opm is exist
opm --help

#search package
opm search 

# package lua-resty-auto-ssl tidak tersedia di opm maka perlu di download menggunakan luarock

#download luarocks
wget http://luarocks.org/releases/luarocks-2.0.13.tar.gz

#extract
tar -xzvf luarocks-2.0.13.tar.gz

cd luarocks-2.0.13/
./configure --prefix=/usr/local/openresty/luajit \
    --with-lua=/usr/local/openresty/luajit/ \
    --lua-suffix=jit \
    --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1
make
sudo make install

# install luarocks with apt
apt install luarocks
```
## this example configuration is under development.


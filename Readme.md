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
* SNI (Server Name Indentification) [Server Name Indication (SNI)](https://en.wikipedia.org/wiki/Server_Name_Indication),
	- Multiple Ssl without Reload Nginx 
	- Redirect http to https

How to use in Ubuntu
====================
edit host in local ex: `/etc/hosts` and add some host , example:
```
127.0.0.1       siomaygepeng.my.id
127.0.0.1       boyfajar.my.id
127.0.0.1       maratun.my.id
127.0.0.1       idads.my.id
```

check service openresty run or not `sudo service --status-all`
if not run you can run with `sudo service openresty start'
if error port 80 in use 
you can stop service uses port 80
look port listening for get service uses port ` sudo lsof -i -P -n | grep LISTEN `



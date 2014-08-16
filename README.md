#vagrant-xe11g with web-server


####Added shell provision for: 
* httpd
* memcached
* php v.5.5
* php-oci8

---

#### Added functionality for setup 
* cpu
* memory
* ip
* virtual hosts 
* mounted folders

----

####Added function serve for creating virtual host. 
```
Examle: serve localhost.example /var/www/html/
```
---
####Added function init_db for creating user and import dump using impdp. 
```
Example: init_db user_name user_pwd dump_dit dump_filename.
```

####Requirements:
```
Virtual box  >= 4.3.10
Vagrant >= 1.6.3

All oracle files have to be put in this repository directory:
Oracle 11g XE R2 - http://www.oracle.com/technetwork/products/express-edition/overview/index.html 

http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
oracle-instantclient11.2-basic-11.2.0.3.0-1.x86_64.rpm
oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm
oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
```

The base vagrant: https://github.com/matthewbaldwin/vagrant-xe11g

Idea of the setting: https://github.com/laravel/homestead

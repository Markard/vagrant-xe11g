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

The base vagrant: https://github.com/matthewbaldwin/vagrant-xe11g
Idea of the setting: https://github.com/laravel/homestead

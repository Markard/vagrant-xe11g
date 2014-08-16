#!/usr/bin/env bash

block="<VirtualHost *:80>
  ServerName $1
  DocumentRoot $2
  <Directory $2>
    AllowOverride All
    Order allow,deny
	Allow from all
  </Directory>
</VirtualHost>
"

echo "$block" > "/etc/httpd/conf/sites-available/$1.conf"
sudo ln -s "/etc/httpd/conf/sites-available/$1.conf" "/etc/httpd/conf/sites-enabled/"
service httpd restart

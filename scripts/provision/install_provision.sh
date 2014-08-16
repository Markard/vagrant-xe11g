#!/usr/bin/env bash

# From Creating a Vagrant Box

cat << EOF
***************************************

Welcome to dev_php_apache Vagrant Box

For PHP development

***************************************
EOF

sudo yum -y install gzip bzip2 unzip
sudo yum -y install mc vim curl wget mercurial git htop debconf-utils dos2unix
sudo yum -y install httpd memcached

sudo chkconfig --levels 235 httpd on
sudo /etc/init.d/httpd start

sudo chkconfig --add memcached
sudo chkconfig memcached on
sudo service memcached start

dos2unix /vagrant/files/etc/httpd/conf/httpd.conf
sudo cp /vagrant/files/etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf
sudo mkdir /etc/httpd/conf/sites-available
sudo mkdir /etc/httpd/conf/sites-enabled

find /vagrant/files/home/. -type f -exec dos2unix {} \;
dos2unix /vagrant/files/aliases
dos2unix /vagrant/files/.bashrc

sudo cp /vagrant/files/aliases /home/vagrant/.bash_aliases
sudo cp /vagrant/files/.bashrc /home/vagrant/.bashrc
sudo cp -R /vagrant/files/home/. /home/vagrant/

sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum -y install php55w php55w-mcrypt php55w-mysql php55w-pdo php55w-cli php55w-gd php55w-xml php55w-mbstring  php55w-pecl-memcache.x86_64

dos2unix /vagrant/files/etc/php.ini
sudo cp /vagrant/files/etc/php.ini /etc/php.ini

sudo wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
sudo rpm -Uhv rpmforge-release*.rf.x86_64.rpm
sudo yum -y install htop

cat << EOF
***************************************

Installing php-oci8

***************************************
EOF

sudo yum install -y php55w-pear php55w-devel zlib zlib-devel bc libaio glibc

sudo rpm -ivh /vagrant/oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
sudo rpm -ivh /vagrant/oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
sudo rpm -ivh /vagrant/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm

sudo ln -s /usr/include/oracle/11.2/client64 /usr/include/oracle/11.2/client
sudo ln -s /usr/lib/oracle/11.2/client64 /usr/lib/oracle/11.2/client

sudo touch /etc/profile.d/oracle.sh
echo 'export LD_LIBRARY_PATH=/usr/lib/oracle/11.2/client64/lib' | sudo tee --append /etc/profile.d/oracle.sh
source /etc/profile.d/oracle.sh

pear download pecl/oci8
tar -xvf oci*.tgz
cd oci*

phpize
./configure --with-oci8=shared,instantclient,/usr/lib/oracle/11.2/client64/lib
make
sudo make install

sudo touch /etc/php.d/oci8.ini
echo 'extension=oci8.so' | sudo tee --append /etc/php.d/oci8.ini

sudo httpd -k restart

echo "You've been provisioned"
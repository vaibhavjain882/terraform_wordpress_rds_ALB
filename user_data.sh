#!/bin/bash
echo "console-setup   console-setup/charmap47 select  UTF-8" > encoding.conf
debconf-set-selections encoding.conf
rm encoding.conf
apt-get update && apt-get upgrade -y
apt-get install python-software-properties -y
add-apt-repository ppa:ondrej/php -y
apt-get update -y
apt-get install apache2 -y
apt-get install php7.2 -y
apt-get install php7.2-mysql libapache2-mod-php7.2 php7.2-cli php7.2-cgi php7.2-gd php7.2-common php7.2-mbstring php7.2-xmlrpc php7.2-soap php7.2-xml php7.2-intl php7.2-zip php7.2-curl -y --allow-unauthenticated
apt-get install mysql-client -y

wget ${wordpress_url}
tar -xvf latest.tar.gz
rsync -av wordpress/* /var/www/html/
rm -f latest.tar.gz

chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

#remove index.html so that apache pick index.php
rm /var/www/html/index.html

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/define('DB_NAME', .*/define('DB_NAME', '${db_name}');/" /var/www/html/wp-config.php
sed -i "s/define('DB_USER', .*/define('DB_USER', '${db_user}');/" /var/www/html/wp-config.php
sed -i "s/define('DB_PASSWORD', .*/define('DB_PASSWORD', '${db_password}');/" /var/www/html/wp-config.php
sed -i "s/define('DB_HOST', .*/define('DB_HOST', '${db_host}');/" /var/www/html/wp-config.php
sed -i "s/define('DB_CHARSET', .*/define('DB_CHARSET', '${db_charset}');/" /var/www/html/wp-config.php


systemctl enable apache2
sleep 5
service apache2 restart

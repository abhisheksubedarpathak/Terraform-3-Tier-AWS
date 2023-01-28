#!/bin/bash
sudo su
yum install -y httpd
systemctl start httpd
systemctl enable httpd.service
yum install https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
yum-config-manager ––enable remi–php73
yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysql –y -y
systemctl restart httpd

echo "<?php phpinfo(); ?>" > /var/www/html/test.php

# Install MySQL
yum install mariadb-server mariadb-libs mariadb -y

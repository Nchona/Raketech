#!/bin/bash
#  Script to install Composer on the docker image 

# Downloading installer and installing Composer installer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'a5c698ffe4b8e376eaff6a6b994b9010afb67a2a8803955ae9a2c01c130d47dc') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
mv composer.phar /usr/local/bin/composer
php -r "unlink('composer-setup.php');"

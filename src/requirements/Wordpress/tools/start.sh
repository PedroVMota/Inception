#!/bin/sh

sleep 10

if [ -f "/var/www/html/wp-config.php" ]
then 
	echo "wordpress already downloaded"
else
	mkdir -p /var/www/html
	mkdir -p /var/run
	
	cd /var/www/html
	# dl la base de worpdress
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	
	chmod +x wp-cli.phar
		
	mv wp-cli.phar /usr/local/bin/wp
	
	#dl worpress
	
	wp core download --allow-root --version=latest --force

	#config de wordpress
	
	mv wp-config-sample.php wp-config.php

	sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
		
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config.php
		
	sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config.php
		
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php
	
	#finalise l'instalation est creation de l'admin
	
	wp core install \
	--allow-root \
	--url=${DOMAIN_NAME} \
	--title=\'${WORDPRESS_TITLE}\' \
	--admin_user=\'${WORDPRESS_ADMIN}\' \
	--admin_password=${WORDPRESS_MPADMIN} \
	--admin_email=${WORDPRESS_EMAIL} \
	--skip-email
	
	#cree le 2eme user
	
	wp user create --allow-root --path=/var/www/html $WORPRESS_USER $WORDPRESS_EMAIL_USER --role=contributor --user_pass=$WORDPRESS_PASSWORD
	touch /var/www/html/.up
		
fi


/usr/sbin/php-fpm7.3
#!bin/bash

set -eo pipefail

if [ ! -f "/var/www/html/wp-config.php" ]; then
	wp core download --allow-root --path="/var/www/html"

	rm -f /var/www/html/wp-config.php8
	rm -f /var/www/html/wp-config.php
	rm -f /etc/php8/php-fpm.d/www.conf

	cp ./www.conf /etc/php8/php-fpm.d/www.conf

	for i in {0..42}; do
		if mariadb -h$DB_SERVER -u$DB_USER -p$DB_USERPASS --database=$WORDPRESS_DB <<< 'SELECT 1;'&>/dev/null; then
			break
		fi
		sleep 5
	done

	wp config create --allow-root --dbname=$WORDPRESS_DB --dbuser=$DB_USER --dbpass=$DB_USERPASS \
		--dbhost=$DB_SERVER --dbcharset="utf8" --dbcollate="utf8_general_ci" --path="/var/www/html"

	wp core install --allow-root --title="${WORDPRESS_TITLE}" --admin_name="${WORDPRESS_ADMIN}" --admin_password="${WORDPRESS_ADMINPASS}" \
		--admin_email="${DB_EMAIL}" --skip-email --url="${DOMAIN_NAME}" --path="/var/www/html"
	wp user create --allow-root $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_USERPASS --path="/var/www/html"
	echo "CONGRATSSSS All is good to go!"
fi


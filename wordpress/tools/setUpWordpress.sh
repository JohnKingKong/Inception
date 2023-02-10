#!/bin/bash

set -euo pipefail

if [ "$1" = "php-fpm7.3" ]; then

	for i in {0..30}; do
		if mariadb -h$MYSQL_SERV -u$MYSQL_USER -p$MYSQL_PASS --database=$MYSQL_DB <<<'SELECT 1;' &>/dev/null; then
			break
		fi
		sleep 2
	done
	if [ "$i" = 30 ]; then
		echo "Error: can't connect to the DB"
		exit 1
	fi
fi

if [ ! -f "/var/www/html/wp-config/php" ]; then

	tar -xzf wordpress.tar.gz
	rm wordpress.tar.gz
	mv wordpress/* html/
	rm -rf wordpress

	wp config create --allow-root \
		--dbname=$MYSQL_DB \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASS \
		--dbhost=mariadb \
		--dbcharset="utf8" \
		--dbcollate="utf8_general_ci" \
		--path="/var/www/html"

	wp core install --allow-root \
		--title="wordpress" \
		--admin_name="wordpress" \
		--admin_password="wordpress" \
		--admin_email="JohnKingKong@wordpress.jp" \
		--skip-email \
		--url=$SERV_NAME \
		--path="/var/www/html"

	wp user create --allow-root \
		$WP_USER \
		$WP_EMAIL \
		--role=author \
		--user_pass=$WP_PASS \
		--path="/var/www/html"
fi

exec "$@"

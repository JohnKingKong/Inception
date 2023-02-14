#!/bin/sh

wp core download --force --allow-root
sleep 10
wp config create --allow-root \
	--dbname=${WP_DB} \
	--dbuser=${DB_USERPASS} \
	--dbpass=${DB_USERPASS} \
	--dbhost=${DB_SERV}
wp core install --allow-root \
	--url=${SERV_NAME} \
	--title=${WP_TITLE} \
	--admin_user=${WP_ADMIN} \
	--admin_password=${WP_ADMINPASS} \
	--admin_email=${WP_ADMINEMAIL}
wp user create --allow-root \
	${WP_USER} \
	${WP_USEREMAIL} \
	--role=subscriber \
	--user_pass=${WP_USERPASS}
# fi
php-fpm7.3 --nodaemonize
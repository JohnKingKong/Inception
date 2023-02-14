FILE=/home/jvigneau/data/mariadb/success

if test -f "/home/jvigneau/data/mariadb/success" ; then
	echo "DATABASE ALREADY SET UP"
else
	echo "SETUPING DATABASE"
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

	mysqld --user=mysql --datadir=/var/lib/mysql &
	sleep 5

	mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_DB};"

	echo "CREATED DATABASE"

	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USERPASS}';"

	echo "CREATED USER"

	mysql -e "GRANT ALL PRIVILEGES ON \`${WP_DB}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USERPASS}';"

	echo "PRIVILEGES GRANTED"

	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASS}';"

	echo "ROOT PASSWORD SET"

	mysql -u root -p${DB_ROOTPASS} -e "FLUSH PRIVILEGES;"

	echo "PRIVILEGES FLUSHED"

	touch /home/jvigneau/data/mariadb/success
	pkill mysqld

fi
exec $@

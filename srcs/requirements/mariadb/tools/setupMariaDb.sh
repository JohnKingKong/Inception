if [ ! -f "/home/jvigneau/data/mariadb/a" ]; then
	echo "DB is already set up"
	exec $@
else
	echo "Setting up the DB"
	mysql_install_db --user=mysql --basedir=/usr/ --datadir=/var/lib/mysql

	mysqld --user=mysql --datadir=/var/lib/mysql &
	sleep 5

	mysql -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB};"
	echo "DB is created"

	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_USERPASS}';"
	echo "User ${DB_USER} created"

	mysql -e "GRANT ALL PRIVILEGES ON \`${WORDPRESS_DB}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USERPASS}';"
	echo "Privileges have been granted"

	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOTPASS}';"
	echo "Root password is now set"

	mysql -u root -p${DB_ROOTPASS} -e "FLUSH PRIVILEGES;"
	echo "Privileges have been flushed"

	touch "/home/jvigneau/data/mariadb/a"
	pkill mysqld

	exec $@
fi
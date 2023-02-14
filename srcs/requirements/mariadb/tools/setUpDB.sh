
if test -f "/home/jvigneau/data/mariadb/success"; then
	echo "DB already set up"
	exec $@
else
	echo "Setting up the DB"
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

	mysqld --user=mysql --datadir=/var/lib/mysql

	mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_DB};"
	echo "DB created"

	mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFED BY '${DB_USERPASS}';"
	echo "User created"

	mysql -e "GRANT ALL PRIVILEGES ON \`${WP_DB}\`.* TO \`${DB_USER}\`@'%' IDENTIFED BY '${DB_USERPASS}';"
	echo "Granted privileges"

	mysql -e "ALTER USE 'root'@'localhost' IDENTIFED BY '${DB_ROOTPASS}';"
	echo "Root password is now set"

	mysql -u root -p${DB_ROOTPASS} -e "FLUSH PRIVILEGES;"
	echo "Done"

	touch /home/jvigneau/data/mariadb/success
	pkill myslqd

	exec $@
fi
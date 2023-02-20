if [ -f ".a" ]; then
	echo "DB is already set up"
else
	echo "Setting up the DB"
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

	mysqld --user=mysql --datadir=/var/lib/mysql &
	sleep 5

	mysql -e "create database if not exists ${WORDPRESS_DB};"
	echo "DB is created"

	mysql -e "create user if not exists '${DB_USER}'@'localhost' identified by '${DB_USERPASS}';"
	echo "User ${DB_USER} created"

	mysql -e "grant all privileges on \`${WORDPRESS_DB}\`.* to \`${DB_USER}\`@'%' identified by '${DB_USERPASS}';"
	echo "Privileges have been granted"

	mysql -e "alter user 'root'@'localhost' identified by '${DB_ROOTPASS}';"
	echo "Root password is now set"

	mysql -u root -p${DB_ROOTPASS} -e "flush privileges;"
	echo "Privileges have been flushed"

	touch ".a"
	pkill mysqld

fi
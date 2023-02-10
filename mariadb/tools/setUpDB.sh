#!/bin/bash

set -euo pipefail

if [ ! -f "$MYSQL_DATADIR/init_database.sql" ]
then
	chown -R mysql:mysql $MYSQL_DATADIR
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db > /dev/null
	cat > "$MYSQL_DATADIR/init_database.sql" << EOF

CREATE DATABASE IF NOT EXISTS $MYSQL_DB;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';
GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS';
FLUSH PRIVILEGES;

EOF

	mysqld --skip-networking=1 &
	for i in {0..42}; do
		if mariadb -uroot -proot --database=mysql <<<'SELECT 1;' &> /dev/null
		then
			break
		fi
		sleep 1
	done

	if [ "$i" = 42 ]
	then
		echo "Error: starting server"
		exit 1
	fi

	mariadb -u root -proot < "$MYSQL_DATADIR/init_database.sql" && killall mysqld
fi

exec "$@"
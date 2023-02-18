FROM			alpine:3.16

RUN				apk update && apk upgrade && \
					apk add --update mariadb mariadb-common mariadb-client mariadb-server-utils gettext bash

RUN				rm -rf /etc/my.cnf
COPY			conf/my.cnf /etc/my.cnf

RUN				rm -rf /etc/mysql/my.cnf
COPY			conf/my.cnf /etc/mysql/my.cnf

COPY			tools/setupMariaDb.sh ./setupMariaDb.sh

RUN				chmod +x setupMariaDb.sh

RUN				mkdir -p /run/mysqld /var/lib/mysql

RUN				chmod 777 /var/lib/mysql
RUN				chmod 777 /run/mysqld
RUN				chown -R mysql:mysql /var/lib/mysql
RUN				chown -R mysql:mysql /run/mysqld

EXPOSE			3306

CMD		["bash", "setupMariaDb.sh"]

CMD				["mysqld"]
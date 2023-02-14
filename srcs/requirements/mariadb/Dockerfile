FROM alpine:3.15

RUN apk add --update mariadb mariadb-common mariadb-client mariadb-server-utils gettext bash

COPY conf/my.cnf /etc/my.cnf
COPY conf/my.cnf /etc/mysql./my.cnf

RUN mkdir -p tools/
COPY tools/setUpDB.sh tools/setUpDB.sh

COPY conf/db_setup.sql db_setup.sql

RUN chmod +x tools/setUpDB.sh

RUN mkdir -p /run/mysqld /var/lib/mysql
RUN chmod 777 /var/lib/mysql
RUN chmod 777 /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT ["bash", "./tools/setUpDB.sh"]

CMD ["mysqld"]
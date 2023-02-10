FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	php-fpm \
	php-mysql \
	mariadb-client \
	curl

RUN mkdir -p /var/www /run/php-mysql

WORKDIR /var/www

COPY ./tools/* .
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN ./curlTheStuff.sh

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

EXPOSE 9000

ENTRYPOINT ["./setUpWordpress.sh"]

CMD ["php-fpm7.3", "-F", "-R"]
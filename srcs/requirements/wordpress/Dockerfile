FROM debian:buster

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	php-fpm php-mysql mariadb-client bash

RUN mkdir -p /var/www /run/php-mysql


COPY ./tools/curlTheStuff.sh ./
COPY ./conf/www.conf ./

RUN chmod +x setUpWordpress.sh

RUN adduser -D jvigneau

RUN mkdir -p /var/www/html
RUN chmod 777 -R /var/www/html
RUN chown -R jvigneau /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv -f wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

ENTRYPOINT ["bash", "./curlTheStuff.sh"]

CMD ["php-fpm7", "-F"]
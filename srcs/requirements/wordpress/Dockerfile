FROM			alpine:3.16

RUN				apk update && apk upgrade && \
				apk add php8 php8-fpm php8-opcache php8-mysqli php8-session php8-iconv php8-json \
				php8-gd php8-curl php8-xml php8-common php8-imap php8-cgi php8-pdo php8-pdo_mysql \
				php8-soap php8-posix php8-redis php8-gettext php8-ldap \
				php8-ctype php8-dom php8-phar curl bash mariadb-client dumb-init

COPY			./tools/setupWordpress.sh ./setupWordpress.sh
RUN				chmod +x setupWordpress.sh

COPY			./conf/www.conf ./www.conf

RUN				adduser -D jvigneau

RUN mkdir -p /var/www/html
RUN chmod 777 -R /var/www/html
RUN chown -R jvigneau /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar
RUN mv -f wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

ENTRYPOINT	["/usr/bin/dumb-init"]

CMD			["bash", "setupWordpress.sh"]

CMD			["bash", "php-fpm8", "-F"]
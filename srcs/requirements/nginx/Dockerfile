FROM		alpine:3.16

RUN			apk update && apk upgrade && apk add nginx openssl dumb-init bash

RUN			mkdir -p /var/www/html /etc/nginx/ssl/certificates /etc/nginx/ssl/keys

COPY		./conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE		443

RUN			openssl req -newkey rsa:4096 -sha256 -x509 -nodes -days 365 \
				-out /etc/nginx/ssl/certificates/nginxSsl.crt \
				-keyout /etc/nginx/ssl/keys/nginxSsl.key \
				-subj "/C=CA/ST=Quebec/L=Quebec City/O=42School/OU=42Quebec/CN=jvigneau.42.fr"

ENTRYPOINT ["dumb-init", "--"]

CMD ["bash","-c", "exec nginx -g daemon off"]
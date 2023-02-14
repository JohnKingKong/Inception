FROM	alpine:3.15

RUN		apk update && apk upgrade && \
		apk add nginx openssl

RUN		mkdir -p /var/www/html

COPY	./conf/default.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /etc/ssl/private
RUN mkdir -p /etc/ssl/certs

RUN		openssl req -x509 -nodes -sha256 -days 365 -newkey rsa:4096 \
			-subj "/C=CA/ST=Quebec/L=Quebec City/O=42School/OU=42Quebec/CN=jvigneau.42.fr" \
			-keyout /etc/nginx/ssl/private/nginx_key.key -out /etc/nginx/ssl/certs/nginx_cert.crt

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]
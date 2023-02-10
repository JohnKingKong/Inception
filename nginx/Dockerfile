FROM	debian:buster

RUN		apt-get update && \
		apt-get install -y nginx openssl

ARG SSL_CERT
ARG SSL_KEY
ARG SERV_NAME

ENV SSL_CERT=$SSL_CERT
ENV SSL_KEY=$SSL_KEY
ENV SERV_NAME=$SERV_NAME

COPY ./tools/certificate.sh .
COPY ./tools/setUpServer.sh .

RUN mkdir /etc/nginx/ssl

RUN ./certificate.sh

EXPOSE	443

ENTRYPOINT ["./setUpServer.sh"]

CMD ["nginx", "-g", "daemon off;"]

#!/bin/bash

set -euo pipefail

# Set la configuration du server, avec tls et ssl, ainsi que fastcgi pour le php
if [ "$1" = "nginx" ];
then
	echo > /etc/nginx/conf.d/default.conf << EOF

server {
	listen 443 ssl;
	listen [::]:443 ssl;

	server_name $SERV_NAME;

	ssl_certificate	/etc/nginx/ssl/$SSL_CERT;
	ssl_certificate_key /etc/nginx/ssl/$SSL_KEY;
	ssl_protocols TLSv1.2 TLSv1.3;

	root var/www/html;
	index index.php index.html index.nginx-debian.html;

	location / {
        autoindex   on;
        try_files   \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param PATH_INFO \$fastcgi_path_info;
    }

    location ~ /\.ht {
        	deny all;
    }
        
    location = /favicon.ico { 
    	log_not_found off; access_log off; 
    }

    location = /robots.txt { 
        log_not_found off; access_log off; allow all; 
    }
    
    location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
        expires max;
        log_not_found off;
    }

}
EOF
fi

exec "$@"
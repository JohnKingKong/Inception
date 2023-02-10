#!/bin/bash

set -exuo pipefail

mkdir -p /etc/nginx/ssl

cd /etc/nginx/ssl

# Create Certificate Authority
openssl req -x509 \
    -sha256 -days 3650 \
    -nodes \
    -newkey rsa:2048 \
    -subj "/CN=$SERV_NAME/C=CA/ST=Quebec/L=Quebec City/O=42 Network/OU=42 Quebec" \
    -keyout rootCA.key \
    -out rootCA.crt

# Create the Server Private Key
openssl genrsa -out $SSL_KEY 2048

# Create Certificate Signing Request Configuration
cat > csr.conf <<EOF
[ req ]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = CA
ST = Quebec
L = Quebec City
O = 42 Network
OU = 42 Quebec
CN = $SERV_NAME

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $SERV_NAME
EOF

# Generate Certificate Signing Request (CSR) Using Server Private Key
openssl req -new -key $SSL_KEY -out server.csr -config csr.conf

# Create Certificate configuration
cat > cert.conf <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $SERV_NAME
EOF

# Generate SSL certificate With self signed CA
openssl x509 -req \
    -in server.csr \
    -CA rootCA.crt -CAkey rootCA.key \
    -CAcreateserial -out $SSL_CRT \
    -days 365 \
    -sha256 -extfile cert.conf
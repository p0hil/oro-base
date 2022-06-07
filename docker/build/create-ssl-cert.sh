#!/bin/bash

openssl genrsa -des3 -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem

openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config cert.conf
openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 500 -sha256 -extfile v3.conf

#openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config cert.conf
#openssl openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.crt -days 500 -sha256 -extfile v3.conf
#openssl dhparam -out ./../config/ssl/dhparam.pem 2048

# Mac
#sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ./../config/ssl/nginx-self-signed.crt

# Linux
#sudo cp ./../config/ssl/nginx-self-signed.crt /usr/local/share/ca-certificates/
#sudo update-ca-certificates
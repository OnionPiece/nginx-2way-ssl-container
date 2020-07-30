if [[ $DOMAIN == "" ]]; then
	echo "Env DOMAIN is needed!" && exit 1
fi
sed -i "s/DOMAIN/$DOMAIN/g" /etc/nginx/conf.d/foo.conf

# gen ca certs
openssl genrsa -out ca.key 2048 > /dev/null 2>&1
openssl req -x509 -new -key ca.key -days 365 -out ca.crt -subj "/C=CN/ST=BJ/L=BJ/O=Loktar/OU=Ogar/CN=nginx-ca" > /dev/null 2>&1

# gen server certs
openssl genrsa -out server.key 2048 > /dev/null 2>&1
openssl req -new -key server.key -out server.csr -subj "/C=CN/ST=BJ/L=BJ/O=Loktar/OU=Ogar/CN=$DOMAIN" > /dev/null 2>&1
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365 > /dev/null 2>&1

# gen client certs
openssl genrsa -out client.key 2048 > /dev/null 2>&1
openssl req -new -key client.key -out client.csr -subj "/C=CN/ST=BJ/L=BJ/O=Loktar/OU=Ogar/CN=client" > /dev/null 2>&1
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365 > /dev/null 2>&1

if [[ -d /certs ]]; then
	cp ca.crt client.crt client.key /certs
	chmod 644 /certs/client.key
fi

nginx -g 'daemon off;'

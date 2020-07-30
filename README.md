# nginx-2way-ssl-container

run e.g.
--------

docker run -it -d -e DOMAIN=mytest.local.io -v `pwd`/foodir:/certs nginx-2way-ssl


test
----

cd foodir
curl --resolve mytest.local.io:8123:<ContainerIP> --cacert ca.crt --cert client.crt --key client.key https://mytest.local.io:8123

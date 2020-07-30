FROM centos

RUN yum install -y openssl-devel nginx && mkdir /etc/nginx/ssl

ADD nginx.conf /etc/nginx/

ADD foo.conf /etc/nginx/conf.d/

WORKDIR /etc/nginx/ssl

ADD start.sh ./

CMD ["/bin/bash", "/etc/nginx/ssl/start.sh"]

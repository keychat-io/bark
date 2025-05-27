FROM docker.io/secondark/aspd

ADD ./contrib/docker/aspd_create_if_not_exists.sh /create_if_not_exists.sh
RUN chmod a+x /create_if_not_exists.sh

ENTRYPOINT ["/usr/local/bin/aspd"]



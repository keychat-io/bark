FROM docker.io/secondark/bark

ADD ./contrib/docker/bark_create_if_not_exists.sh /create_if_not_exists.sh
RUN chmod a+x /create_if_not_exists.sh

ENTRYPOINT ["/usr/local/bin/bark"]



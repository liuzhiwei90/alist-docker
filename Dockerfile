FROM alpine:3.18.2
COPY main.sh /home/main.sh
COPY repositories /etc/apk/repositories
RUN apk update
RUN apk --no-cache update \
    && apk --no-cache add curl
CMD ["/bin/sh", "/home/main.sh"]
FROM alpine

ENV MAILNAME=localhost

RUN apk add openssl exim

ADD entrypoint.sh /entrypoint.sh

ADD exim.conf /etc/exim/exim.conf

EXPOSE 25

ENTRYPOINT ["/entrypoint.sh"]
CMD ["exim", "-bd", "-q15m", "-v"]

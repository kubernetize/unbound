FROM alpine:3.11

RUN addgroup -g 5353 unbound && \
    adduser -G unbound -D -H -u 5353 unbound && \
    apk --no-cache add libcap unbound && \
    setcap cap_net_bind_service+ep /usr/sbin/unbound && \
    mkdir -p /var/run/unbound && \
    (unbound-anchor -a /var/run/unbound/root.key || :) && \
    chown -R unbound:unbound /var/run/unbound

ADD assets /

USER 5353

EXPOSE 53/tcp 53/udp

CMD ["unbound", "-d"]

FROM alpine:3.18.3

LABEL org.opencontainers.image.authors "Richard Kojedzinszky <richard@kojedz.in>"
LABEL org.opencontainers.image.source https://github.com/kubernetize/unbound

RUN addgroup -g 5353 unbound && \
    adduser -G unbound -D -H -u 5353 unbound && \
    apk --no-cache add libcap unbound bind-tools && \
    setcap cap_net_bind_service+ep /usr/sbin/unbound && \
    apk --no-cache del libcap && \
    mkdir -p /var/run/unbound && \
    (unbound-anchor -a /var/run/unbound/root.key || :) && \
    chown -R unbound:unbound /var/run/unbound

ADD assets /

USER 5353

EXPOSE 53/tcp 53/udp

CMD ["unbound", "-d"]

FROM alpine:latest

ENV GAM_VERSION=5.04

RUN apk update \
    && apk add bash curl python3 \
    && cd /tmp \
    && curl -o install-gam -s -S -L https://git.io/install-gam \
    && chmod +x install-gam \
    && ./install-gam -l -d /gam -v ${GAM_VERSION} \
    && touch /gam/gam/nobrowser.txt /gam/gam/noupdatecheck.txt \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

WORKDIR /gam

ENTRYPOINT [ "/gam/gam/gam" ]

CMD [ "--help" ]

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/intracto/docker-gam"

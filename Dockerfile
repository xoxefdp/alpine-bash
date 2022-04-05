ARG ARCH=
ARG BASH_VERSION
ARG ALPINE_VERSION
ARG IMAGE_VERSION=$BASH_VERSION-alpine$ALPINE_VERSION

FROM ${ARCH}bash:${IMAGE_VERSION}

# Install system dependencies
RUN set -xe && \
  apk add --no-cache --update && \
  rm -rf /var/cache/apk/* /tmp/*

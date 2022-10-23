ARG ARCH=
ARG IMAGE_VERSION=latest

FROM ${ARCH}bash:${IMAGE_VERSION}

# Install system dependencies
RUN set -xe && \
  apk add --no-cache --update && \
  rm -rf /var/cache/apk/* /tmp/*

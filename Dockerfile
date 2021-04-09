ARG ALPINE_VERSION=latest

FROM alpine:${ALPINE_VERSION}

# Install system dependencies
RUN set -xe && \
  apk add --no-cache --update && \
  apk add --no-cache bash && \
  rm -rf /var/cache/apk/* /tmp/*

# Command to run
# ENTRYPOINT ["/bin/bash"]
CMD ["/bin/bash"]

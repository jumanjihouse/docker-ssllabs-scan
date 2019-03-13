FROM alpine:3.9 as scanner_builder

ARG VERSION

RUN apk add --no-cache \
      curl \
      musl-dev \
      && :

RUN apk add --no-cache -X http://dl-4.alpinelinux.org/alpine/edge/community \
      'go>=1.11.5-r0' \
      && :

RUN apk add --no-cache -X http://dl-4.alpinelinux.org/alpine/edge/main \
      'ca-certificates>=20190108-r0' \
      && :

RUN adduser -D developer

# Run subsequent commands as "developer".
USER developer

# https://github.com/golang/go/issues/9344#issuecomment-69944514
RUN cd /tmp && \
    curl -sSLO https://github.com/ssllabs/ssllabs-scan/archive/v${VERSION}.tar.gz && \
    tar xvzf v${VERSION}.tar.gz && \
    cd ssllabs-scan-${VERSION} && \
    GOPATH=~ \
    CGO_ENABLED=0 \
    GOOS=linux \
    LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH \
    go build \
      -a \
      -tags netgo \
      -ldflags '-extldflags "-static" -s' \
      -buildmode exe \
      ssllabs-scan-v3.go

#
# Build the runtime image.
#
FROM scratch

USER user
ENTRYPOINT ["/ssllabs-scan"]
CMD ["--help"]

ARG VERSION
COPY --from=scanner_builder /tmp/ssllabs-scan-${VERSION}/ssllabs-scan-v3 /ssllabs-scan
COPY --from=scanner_builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY . /

ARG CIRCLE_BUILD_URL
ARG BUILD_DATE
ARG VCS_REF

LABEL \
    io.github.jumanjiman.ci-build-url=$CIRCLE_BUILD_URL \
    org.label-schema.name="jumanjiman/ssllabs-scan" \
    org.label-schema.description="scans secure websites with the Qualys SSL Labs service" \
    org.label-schema.url="https://github.com/jumanjihouse/docker-ssllabs-scan" \
    org.label-schema.vcs-url="https://github.com/jumanjihouse/docker-ssllabs-scan.git" \
    org.label-schema.docker.dockerfile="/Dockerfile.runtime" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.license="https://www.ssllabs.com/about/terms.html" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$VERSION

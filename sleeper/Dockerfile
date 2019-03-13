FROM alpine:3.9 as sleeper_builder

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

# Build a binary that just sleeps a while.
# This is used in the test harness to prove the process runs as an unprivileged user.
# https://medium.com/@lizrice/non-privileged-containers-based-on-the-scratch-image-a80105d6d341
COPY sleeper.go /tmp/
RUN cd /tmp && \
    GOPATH=~ \
    CGO_ENABLED=0 \
    GOOS=linux \
    LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LIBRARY_PATH \
    go build \
      -a \
      -tags netgo \
      -ldflags '-extldflags "-static" -s' \
      -buildmode exe \
      sleeper.go

# This image is used in the test harness to
# prove a scratch container can run as a non-root user.
FROM scratch

COPY --from=sleeper_builder /tmp/sleeper /
COPY passwd /etc/passwd
USER user
ENTRYPOINT ["/sleeper"]

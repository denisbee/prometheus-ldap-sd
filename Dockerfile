ARG GO_VERSION="1.15.14"
ARG ALPINE_VERSION="3.15.0"

FROM alpine:$ALPINE_VERSION as build
RUN apk add --no-cache make go git
WORKDIR /workdir
ADD . .
RUN make build

FROM alpine:$ALPINE_VERSION
COPY --from=build /workdir/_build/prometheus-ldap-sd-server /usr/bin/prometheus-ldap-sd-server 
EXPOSE 8889
ENTRYPOINT ["/usr/bin/prometheus-ldap-sd-server"]

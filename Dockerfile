FROM alpine:latest as builder
WORKDIR /vega_mt_server_tmp
RUN apk --no-cache add curl zip
RUN curl -sf  -o /vega_mt_server_tmp/vega_mt_server.zip -L https://fmsvega.ru/ru/content/ru/soft/server/vega_mt_server.0.9.3.linux.x64.zip
RUN unzip vega_mt_server.zip
RUN mkdir -p /vega_mt_server
WORKDIR /vega_mt_server
RUN cp /vega_mt_server_tmp/Deploy.Linux.x64/bin/vega_mt_server .
RUN cp /vega_mt_server_tmp/Deploy.Linux/etc/vega_mt_server /vega_mt_server_tmp/Deploy.Linux/etc/vega_mt_server.cfg
RUN cp /vega_mt_server_tmp/Deploy.Linux/etc/vega_mt_server.cfg .
RUN sed -i 's/listen_on=(IPv4)12345,(IPv6)12345/listen_on=(IPv4)"0.0.0.0" : 12345/' /vega_mt_server/vega_mt_server.cfg
COPY vega_mt_server.sh .
RUN chmod +x /vega_mt_server/vega_mt_server

FROM ubuntu:latest
WORKDIR /vega_mt_server
COPY --from=builder /vega_mt_server/ /vega_mt_server/
CMD ["sh", "/vega_mt_server/vega_mt_server.sh"]

FROM alpine as alpine

RUN apk --no-cache add fontconfig msttcorefonts-installer \
 && update-ms-fonts \
 && fc-cache -f \
 && mkdir -p /finalfs/etc /finalfs/usr/share \
 && cp -a /etc/fonts /finalfs/etc/ \
 && cp -a /usr/share/xml /usr/share/font* /finalfs/usr/share/
 
FROM huggla/qgisserver-alpine:3.10-20191112

COPY --from=alpine /finalfs /

USER starter

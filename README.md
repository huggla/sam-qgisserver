# qgisserver-alpine
Qgis Server based on Alpine. Only fastcgi, no web server.

Still in testing.

Share unix socket, /run/qgisserver/fastcgi.sock, with a fcgi-capable web server container (f ex. huggla/lighttpd2-alpine).

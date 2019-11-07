# qgisserver-alpine
A small and secure Docker image with Qgis Server based on Alpine. Only fastcgi, no web server. Share unix socket, /run/qgisserver/fastcgi.sock, with a fcgi-capable web server container (f ex. huggla/lighttpd2-alpine).

## Environment variables
### Runtime variables with default value
* VAR_CONFIG_DIR="/etc/qgisserver"
* VAR_FINAL_COMMAND="/usr/local/bin/spawn-fcgi -n -d \$VAR_PROJECT_STORAGE_DIR -s \$VAR_SOCKET_DIR/fastcgi.sock -M 777 -- /usr/local/bin/multiwatch -f \$VAR_FCGICHILDREN /usr/qgis/qgis_mapserv.fcgi"
* VAR_LINUX_USER="qgisserver"
* VAR_PROJECT_STORAGE_DIR="/projects"
* VAR_PLUGINS_DIR="/qgis_server_plugins"
* VAR_SOCKET_DIR="/run/fastcgi"
* VAR_MAX_CACHE_LAYERS="100"
* VAR_LOG_LEVEL="2"
* VAR_PARALLEL_RENDERING="1"
* VAR_MAX_THREADS="-1"
* VAR_CACHE_DIR="/var/cache/qgisserver"
* VAR_CACHE_SIZE="50"
* VAR_FCGICHILDREN="1"

## Capabilities
Can drop all but SETPCAP, SETGID and SETUID.

## Tips
### To use with huggla/lighttpd2-alpine
* Run huggla/qgisserver-alpine and huggla/lighttpd2-alpine on the same host.
* Make sure VAR_SOCKET_DIR in qgisserver-alpine (default: /run/fastcgi) is mounted as the parent directory to VAR_FASTCGI_SOCKET_FILE in lighttpd2-alpine (default: /run/fastcgi/fastcgi.sock).
* Set VAR_OPERATION_MODE="fcgi" in lighttpd2-alpine.
* (Optional) Adjust VAR_setup3_workers, VAR_setup4_io__timeout and VAR_setup5_stat_cache__ttl in lighttpd2-alpine.

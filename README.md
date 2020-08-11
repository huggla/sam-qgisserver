# sam-qgisserver
Secure and Minimal Qgis Server Docker-image. Only fastcgi, no web server. Share unix socket, /run/qgisserver/fastcgi.sock, with a fcgi-capable web server container (f ex. huggla/sam-lighttpd2).

## Environment variables
### Runtime variables with default value
* VAR_LINUX_USER="qgisserver" (User running VAR_FINAL_COMMAND)
* VAR_CONFIG_DIR="/etc/qgisserver" (Directory containing configuration files)
* VAR_FINAL_COMMAND="/usr/local/bin/spawn-fcgi -n -d \$VAR_PROJECT_STORAGE_DIR -s \$VAR_SOCKET_DIR/fastcgi.sock -M 777 -- /usr/local/bin/multiwatch -f \$VAR_FCGICHILDREN /usr/qgis/qgis_mapserv.fcgi" (Command run by VAR_LINUX_USER)
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
### To use with huggla/sam-lighttpd2
* Run huggla/sam-qgisserver and huggla/sam-lighttpd2 on the same host.
* Make sure VAR_SOCKET_DIR in sam-qgisserver (default: /run/fastcgi) is mounted as the parent directory to VAR_FASTCGI_SOCKET_FILE in sam-lighttpd2 (default: /run/fastcgi/fastcgi.sock).
* Set VAR_OPERATION_MODE="fcgi" and VAR_setup1_module_load="[ 'mod_fastcgi' ]" in sam-lighttpd2.
* (Optional) Adjust VAR_setup3_workers, VAR_setup4_io__timeout and VAR_setup5_stat_cache__ttl in sam-lighttpd2.
* Put Qgis project files in VAR_PROJECT_STORAGE_DIR.
* Try to load http://<hostaddress>/?map=myproject.qgs&service=WMS&request=GetCapabilities

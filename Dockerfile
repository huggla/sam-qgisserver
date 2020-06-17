# Secure and Minimal image of Qgis Server
# https://hub.docker.com/repository/docker/huggla/sam-qgisserver

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.3"
ARG IMAGETYPE="application"
ARG BASEIMAGE="huggla/qgisserver-alpine:3.10-20191112"
ARG BUILDDEPS="fontconfig msttcorefonts-installer"
ARG BUILDCMDS=\
'   update-ms-fonts '\
'&& fc-cache -f '\
'&& cp -a /etc/fonts /finalfs/etc/ '\
'&& cp -a /usr/share/xml /usr/share/font* /finalfs/usr/share/'
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-build} as build
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_LINUX_USER="qgisserver" \
    VAR_CONFIG_DIR="/etc/qgisserver" \
    VAR_INIT_CAPS="cap_chown" \
    VAR_PROJECT_STORAGE_DIR="/projects" \
    VAR_PLUGINS_DIR="/qgis_server_plugins" \
    VAR_SOCKET_DIR="/run/fastcgi" \
    VAR_MAX_CACHE_LAYERS="100" \
    VAR_LOG_LEVEL="2" \
    VAR_PARALLEL_RENDERING="1" \
    VAR_MAX_THREADS="-1" \
    VAR_CACHE_DIR="/var/cache/qgisserver" \
    VAR_CACHE_SIZE="50" \
    VAR_FCGICHILDREN="1" \
    VAR_FINAL_COMMAND="XDG_RUNTIME_DIR=/runtimeqgis /usr/local/bin/spawn-fcgi -n -d \$VAR_PROJECT_STORAGE_DIR -s \$VAR_SOCKET_DIR/fastcgi.sock -M 777 -- /usr/local/bin/multiwatch -f \$VAR_FCGICHILDREN /usr/qgis/qgis_mapserv.fcgi"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

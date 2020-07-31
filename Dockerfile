# Secure and Minimal image of Qgis Server
# https://hub.docker.com/repository/docker/huggla/sam-qgisserver

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.4"
ARG IMAGETYPE="application"
ARG QGIS_VERSION="3.10.8-rc"
ARG BASEIMAGE="huggla/sam-qgisserver:$QGIS_VERSION"
ARG RUNDEPS="py3-qt5"
ARG FINALCMDS=\
'   cp -a "/usr/lib/qt5/plugins/platforms/libqoffscreen.so" "/usr/lib/qt5/plugins/imageformats" "/usr/lib/qt5/plugins/designer" "/usr/lib/qt5/plugins/PyQt5" "/usr/lib/qt5/plugins/generic" "/usr/lib/qt5/plugins/qmltooling" "/usr/lib/qt5/plugins/bearer" "/usr/lib/qt5/plugins/platforms" "/usr/lib/qt5/plugins/sqldrivers" "/usr/lib/qt5/plugins/platforminputcontexts" "/tmp/" '\
'&& rm -rf "/usr/lib/qt5/plugins" "/usr/lib/qt5/qml" "/usr/lib/qt5/libexec" "/usr/lib/qt5/bin" "/usr/lib/qt5/mkspecs" '\
'&& mkdir -p "/usr/lib/qt5/plugins" '\
'&& mv "/tmp/imageformats" "/tmp/PyQt5" "/tmp/designer" "/tmp/generic" "/tmp/qmltooling" "/tmp/bearer" "/tmp/platforms" "/tmp/sqldrivers" "/tmp/platforminputcontexts" "/usr/lib/qt5/plugins/" '\
'&& find "/usr/bin" -type f ! -name "spawn-fcgi" ! -name "multiwatch" -delete '
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

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

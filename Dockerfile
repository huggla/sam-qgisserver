# Secure and Minimal image of Qgis Server
# https://hub.docker.com/repository/docker/huggla/sam-qgisserver

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="dev"
ARG IMAGETYPE="application"
ARG QGIS_VERSION="3_10_7"
ARG NETCDF_VERSION="4.7.4"
ARG QSCINTILLA_VERSION="2.11.4"
ARG LIBSPATIALINDEX_VERSION="1.9.3"
ARG HDF5_VERSION="1.12.0"
ARG CONTENTIMAGE1="huggla/sam-content:netcdf-$NETCDF_VERSION"
ARG CONTENTSOURCE1="/content*"
ARG CONTENTDESTINATION1="/content/"
ARG CONTENTIMAGE2="huggla/sam-content:libspatialindex-$LIBSPATIALINDEX_VERSION"
ARG CONTENTSOURCE2="/content*"
ARG CONTENTDESTINATION2="/content/"
ARG CONTENTIMAGE3="huggla/sam-content:qscintilla-$QSCINTILLA_VERSION"
ARG CONTENTSOURCE3="/content*"
ARG CONTENTDESTINATION3="/content/"
ARG CONTENTIMAGE4="huggla/sam-content:hdf5-$HDF5_VERSION"
ARG CONTENTSOURCE4="/content*"
ARG CONTENTDESTINATION4="/content/"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG RUNDEPS="spawn-fcgi fcgi qt5-qtbase qt5-qtbase-x11 opencl-icd-loader qt5-qtsvg qt5-qtwebkit libqca qt5-qtkeychain geos gdal libspatialite libzip qt5-qtserialport qt5-qtlocation libev openmpi libstdc++"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev sqlite samurai qca qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev mt-st \
               curl-dev fcgi-dev zlib-dev openmpi-dev libxml2-dev \
               automake autoconf freexl-dev python3-dev proj-dev fontconfig \
               libspatialite-dev libressl libressl-dev py3-qt5 msttcorefonts-installer\
               py3-sip-pyqt5 py3-sip py-sip-dev py3-qtpy qt5-qttools-static \
               qt5-qtxmlpatterns-dev py3-opencl fortify-headers boost-dev boost-build libev-dev qt5-qtwebengine-dev qt5-qtwebview-dev"
ARG CLONEGITS="https://git.lighttpd.net/lighttpd/multiwatch.git"
ARG DOWNLOADS="https://github.com/qgis/QGIS/archive/final-$QGIS_VERSION.tar.gz"
ARG MAKEDIRS="/usr/qgis /runtimeqgis"
ARG LINUXUSEROWNED="/runtimeqgis"
ARG EXECUTABLES="/usr/bin/spawn-fcgi"
ARG STARTUPEXECUTABLES="/usr/bin/multiwatch"
ARG CC="mpicc"
ARG BUILDCMDS=\
'   update-ms-fonts '\
'&& fc-cache -f '\
'&& cp -a /etc/fonts /finalfs/etc/ '\
'&& cp -a /usr/share/xml /usr/share/font* /finalfs/usr/share/ '\
'&& cd multiwatch '\
'&& cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_C_FLAGS="$CFLAGS" ./ '\
'&& eval "$COMMON_MAKECMDS" '\
'&& cp -a /content/* / '\
"&& cd ../QGIS-final-$QGIS_VERSION "\
"&& sed -i '/SET(TS_FILES/d' i18n/CMakeLists.txt "\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=ON -DWITH_BINDINGS=ON -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF -DCMAKE_C_FLAGS=\"$CFLAGS\" ./ "\
'&& ninja '\
'&& ninja install '\
'&& rm -rf /content/usr/share/proj /content/usr/lib/*.a /content/usr/lib/*.la '\
'&& mv /content "/finalfs/tmp/content"'
ARG FINALCMDS=\
'   mv "/usr/bin/qgis_mapserv.fcgi" "/usr/bin/wms_metadata.xml" "/usr/qgis/" '\
'&& cp -a "/usr/lib/qt5/plugins/platforms/libqoffscreen.so" "/usr/lib/qt5/plugins/imageformats" "/tmp/" '\
'&& rm -rf "/usr/lib/qt5/plugins" "/usr/lib/qt5/qml" "/usr/lib/qt5/libexec" "/usr/lib/qt5/bin" "/usr/lib/qt5/mkspecs" '\
'&& mkdir -p "/usr/lib/qt5/plugins/platforms" '\
'&& mv "/tmp/libqoffscreen.so" "/usr/lib/qt5/plugins/platforms/" '\
'&& mv "/tmp/imageformats" "/usr/lib/qt5/plugins/" '\
'&& find "/usr/bin" -type f ! -name "spawn-fcgi" ! -name "multiwatch" -delete '\
'&& find "/usr/share" -mindepth 1 -maxdepth 1 ! -name "proj" ! -name "font*" ! -name "xml" -delete '\
'&& cp -a /tmp/content/usr/* "/usr/" '\
'&& chmod 700 /runtimeqgis'
ARG REMOVEDIRS="/usr/include"
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

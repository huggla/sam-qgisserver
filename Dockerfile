# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="1.0"
ARG TAG="20191007"
ARG IMAGETYPE="application"
ARG QGIS_VERSION="3_4"
ARG PROJ_VERSION="5.2.0"
ARG NETCDF_VERSION="4.7.0"
ARG QSCINTILLA_VERSION="2.11.2"
ARG LIBSPATIALINDEX_VERSION="master"
ARG HDF5_VERSION="1.10.5"
ARG CONTENTIMAGE1="huggla/proj5-content:$PROJ_VERSION-$TAG"
ARG CONTENTSOURCE1="/content*"
ARG CONTENTDESTINATION1="/content/"
ARG CONTENTIMAGE2="huggla/netcdf-content:$NETCDF_VERSION-$TAG"
ARG CONTENTSOURCE2="/content*"
ARG CONTENTDESTINATION2="/content/"
ARG CONTENTIMAGE3="huggla/libspatialindex-content:$LIBSPATIALINDEX_VERSION-$TAG"
ARG CONTENTSOURCE3="/content*"
ARG CONTENTDESTINATION3="/content/"
ARG CONTENTIMAGE4="huggla/qscintilla-content:$QSCINTILLA_VERSION-$TAG"
ARG CONTENTSOURCE4="/content*"
ARG CONTENTDESTINATION4="/content/"
ARG CONTENTIMAGE5="huggla/hdf5-content:$HDF5_VERSION-$TAG"
ARG CONTENTSOURCE5="/content*"
ARG CONTENTDESTINATION5="/content/"
ARG EXCLUDEAPKS="proj-datumgrid"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG RUNDEPS="spawn-fcgi fcgi qt5-qtbase qt5-qtbase-x11 opencl-icd-loader qt5-qtsvg qt5-qtwebkit libqca qt5-qtkeychain geos gdal libspatialite libzip qt5-qtserialport qt5-qtlocation libev openmpi libstdc++"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev sqlite ninja qca qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev mt-st \
               curl-dev fcgi-dev zlib-dev openmpi-dev libxml2-dev \
               automake autoconf freexl-dev python3-dev \
               libspatialite-dev libressl libressl-dev py3-qt5 \
               py3-sip-pyqt5 py3-sip py-sip-dev py3-qtpy qt5-qttools-static \
               qt5-qtxmlpatterns-dev py3-opencl fortify-headers boost-dev boost-build libev-dev"
ARG CLONEGITS="https://git.lighttpd.net/multiwatch.git \
               '-b release-$QGIS_VERSION --depth 1 https://github.com/qgis/QGIS.git'"
ARG EXECUTABLES="/usr/bin/spawn-fcgi"
ARG STARTUPEXECUTABLES="/usr/bin/multiwatch"
ARG CC="mpicc"
ARG BUILDCMDS=\
'   cd multiwatch '\
'&& cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_C_FLAGS="$CFLAGS" ./ '\
'&& eval "$COMMON_MAKECMDS" '\
'&& cp -a /content/* / '\
'&& cd ../QGIS '\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=ON -DWITH_BINDINGS=ON -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF -DCMAKE_C_FLAGS="$CFLAGS" ./ "\
'&& ninja '\
'&& ninja install '\
'&& mv "$DESTDIR/usr/bin/qgis_mapserv.fcgi" "$DESTDIR/usr/bin/wms_metadata.xml" "$DESTDIR/usr/qgis/" '\
'&& cp -a "$DESTDIR/usr/lib/qt5/plugins/platforms/libqoffscreen.so" "/tmp/" '\
'&& rm -rf "$DESTDIR/usr/lib/qt5/plugins" "$DESTDIR/usr/lib/qt5/qml" "$DESTDIR/usr/lib/qt5/libexec" "$DESTDIR/usr/lib/qt5/bin" "$DESTDIR/usr/lib/qt5/mkspecs" '\
'&& mkdir -p "$DESTDIR/usr/lib/qt5/plugins/platforms" '\
'&& mv "/tmp/libqoffscreen.so" "$DESTDIR/usr/lib/qt5/plugins/platforms/" '\
'&& find "$DESTDIR/usr/bin" -type f ! -name "spawn-fcgi" ! -name "multiwatch" -delete '\
'&& find "$DESTDIR/usr/share" -mindepth 1 -maxdepth 1 ! -name "proj" -delete '\
'&& rm -rf /content/usr/share/proj '\
'&& cp -a /content/usr/* "$DESTDIR/usr/" '\
'&& rm -rf /content'
ARG MAKEDIRS="/usr/qgis"
ARG REMOVEDIRS="/usr/include"
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$SaM_VERSION-$TAG}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/build:$SaM_VERSION-$TAG} as build
FROM ${BASEIMAGE:-huggla/base:$SaM_VERSION-$TAG} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================

ENV VAR_LINUX_USER="qgisserver" \
    VAR_CONFIG_DIR="/etc/qgisserver" \
    VAR_PROJECT_STORAGE_DIR="/projects" \
    VAR_PLUGINS_DIR="/qgis_server_plugins" \
    VAR_SOCKET_DIR="/run/qgisserver" \
    VAR_MAX_CACHE_LAYERS="100" \
    VAR_LOG_LEVEL="2" \
    VAR_PARALLEL_RENDERING="1" \
    VAR_MAX_THREADS="-1" \
    VAR_CACHE_DIR="/var/cache/qgisserver" \
    VAR_CACHE_SIZE="50" \
    VAR_FCGICHILDREN="1" \
    VAR_FINAL_COMMAND="/usr/local/bin/spawn-fcgi -n -d \$VAR_PROJECT_STORAGE_DIR -s \$VAR_SOCKET_DIR/fastcgi.sock -M 777 -- /usr/local/bin/multiwatch -f \$VAR_FCGICHILDREN /usr/qgis/qgis_mapserv.fcgi"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

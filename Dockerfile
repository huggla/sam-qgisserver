# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="1.0"
ARG TAG="20190925"
ARG IMAGETYPE="application"
ARG QGIS_VERSION="3_4"
ARG PROJ_VERSION="5.2.0"
ARG NETCDF_VERSION="4.7.0"
ARG QSCINTILLA_VERSION="2.11.2"
ARG HDF5_VERSION="1.10.5"
ARG CONTENTIMAGE1="huggla/proj5-content:$PROJ_VERSION"
ARG CONTENTSOURCE1="/content*"
ARG CONTENTDESTINATION1="/content/"
ARG CONTENTIMAGE2="huggla/netcdf-content:$NETCDF_VERSION"
ARG CONTENTSOURCE2="/content*"
ARG CONTENTDESTINATION2="/content/"
ARG CONTENTIMAGE3="huggla/libspatialindex-content:$TAG"
ARG CONTENTSOURCE3="/content*"
ARG CONTENTDESTINATION3="/content/"
ARG CONTENTIMAGE4="huggla/qscintilla-content:$QSCINTILLA_VERSION"
ARG CONTENTSOURCE4="/content*"
ARG CONTENTDESTINATION4="/content/"
ARG CONTENTIMAGE5="huggla/hdf5-content:$HDF5_VERSION"
ARG CONTENTSOURCE5="/content*"
ARG CONTENTDESTINATION5="/content/"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG EXCLUDEAPKS="proj proj-datumgrid"
ARG RUNDEPS="spawn-fcgi fcgi qt5-qtbase qt5-qtbase-x11 opencl-icd-loader qt5-qtsvg qt5-qtwebkit libqca qt5-qtkeychain geos gdal libspatialite libzip qt5-qtserialport qt5-qtlocation libev openmpi"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev sqlite ninja qca qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev mt-st \
               curl-dev fcgi-dev zlib-dev openmpi-dev libxml2-dev \
               automake autoconf freexl-dev python3-dev \
               libspatialite-dev libressl libressl-dev \
               py3-sip-pyqt5 py3-sip py-sip-dev py3-qtpy qt5-qttools-static \
               qt5-qtxmlpatterns-dev py3-opencl fortify-headers boost-dev boost-build libev-dev"
ARG CLONEGITS="https://git.lighttpd.net/multiwatch.git \
               '-b release-$QGIS_VERSION --depth 1 https://github.com/qgis/QGIS.git'"
ARG EXECUTABLES="/usr/bin/spawn-fcgi"
ARG STARTUPEXECUTABLES="/usr/local/bin/multiwatch"
ARG CC="mpicc"
ARG BUILDCMDS=\
'   cd /content '\
'&& gzfiles="$(ls *.gz | grep -ve "-doc[.]gz$" | grep -ve "-dev[.]gz$" | xargs)" '\
'&& content="$(zcat $gzfiles | sort -u - | xargs)" '\
'&& for file in $content; '\
'   do '\
'      if [ ! -e "/finalfs$file" ] || [ -f "/finalfs$file" ]; '\
'      then '\
'         cp -a "/content$file" "/finalfs$file"; '\
'      fi; '\
'   done '\
'&& rm -rf /content '\
'&& cd $BUILDDIR/multiwatch '\
'&& cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_C_FLAGS="$CFLAGS" ./ '\
'&& eval "$COMMON_MAKECMDS" '\
"&& cd ../QGIS "\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=ON -DWITH_BINDINGS=ON -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF -DCMAKE_C_FLAGS="$CFLAGS" ./ "\
"&& ninja "\
'&& ninja install'
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
    VAR_PLUGINS_DIR="/qgis_server_plugins" \
    VAR_MAX_CACHE_LAYERS="100" \
    VAR_LOG_LEVEL="2" \
    VAR_PARALLEL_RENDERING="1" \
    VAR_MAX_THREADS="-1" \
    VAR_CACHE_DIR="/var/cache/qgisserver" \
    VAR_CACHE_SIZE="50" \
    VAR_FCGICHILDREN="1" \
    VAR_FINAL_COMMAND="/usr/local/bin/spawn-fcgi -n -s /run/qgisserver/fastcgi.sock -M 777 -- /usr/local/bin/multiwatch -f \$VAR_FCGICHILDREN /usr/bin/qgis_mapserv.fcgi"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

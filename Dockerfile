# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190902"
ARG IMAGETYPE="application"
ARG PROJ_VERSION="5.2.0"
ARG NETCDF_VERSION="4.7.0"
ARG QSCINTILLA_VERSION="2.11.2"
ARG CONTENTIMAGE1="huggla/proj5-content:$PROJ_VERSION"
ARG CONTENTSOURCE1="/content*"
ARG CONTENTDESTINATION1="/"
ARG CONTENTIMAGE2="huggla/netcdf-content:$NETCDF_VERSION"
ARG CONTENTSOURCE2="/content*"
ARG CONTENTDESTINATION2="/"
ARG CONTENTIMAGE3="huggla/libspatialindex-content:$TAG"
ARG CONTENTSOURCE3="/content*"
ARG CONTENTDESTINATION3="/"
ARG CONTENTIMAGE4="huggla/qscintilla-content:$QSCINTILLA_VERSION"
ARG CONTENTSOURCE4="/content*"
ARG CONTENTDESTINATION4="/"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG RUNDEPS="spawn-fcgi fcgi qt5-qtbase qt5-qtbase-x11 opencl-icd-loader qt5-qtsvg qt5-qtwebkit libqca qt5-qtkeychain"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev sqlite ninja qca qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev mt-st \
               curl-dev fcgi-dev zlib-dev openmpi-dev libxml2-dev \
               automake autoconf freexl-dev python3-dev \
               libspatialite-dev libressl libressl-dev \
               py3-sip-pyqt5 py3-sip py-sip-dev py3-qtpy \
               qt5-qtxmlpatterns-dev py3-opencl fortify-headers boost-dev boost-build libev-dev"
ARG CLONEGITS="https://git.lighttpd.net/multiwatch.git \
               '-b release-3_4 --depth 1 https://github.com/qgis/QGIS.git'"
ARG STARTUPEXECUTABLES="/usr/bin/spawn-fcgi /usr/bin/multiwatch"
ARG BUILDCMDS=\
'   cd / '\
'&& content="$(zcat $(ls | grep -e "-app[.]gz$" -e "-static[.]gz$") | sort -u -)" '\
'&& for file in $content; '\
'   do '\
'      if [ ! -e "$file" ] || [ -f "$file" ] && [ ! -l "$file" ]; '\
'      then '\
'         cp -a "$file" /finalfs/; '\
'      fi; '\
'   done '\
'&& cd $BUILDDIR/multiwatch '\
'&& cmake . '\
'&& $COMMON_MAKECMDS '\
"&& cd ../QGIS "\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=ON -DWITH_BINDINGS=ON -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF ./ "\
"&& sed -i '/SET(TS_FILES/d' i18n/CMakeLists.txt "\
"&& ninja "\
'&& ninja install'
# ARGs (passed to Build) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/build:$TAG} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================

ENV VAR_LINUX_USER="qgisserver" \
    VAR_FCGICHILDREN="1" \
    VAR_FINAL_COMMAND="spawn-fcgi -f \$VAR_FCGICHILDREN /usr/bin/qgis_mapserv.fcgi -s /run/qgisserver/fastcgi.sock -M 770 -n -- multiwatch"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

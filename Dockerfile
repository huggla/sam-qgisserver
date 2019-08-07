ARG TAG="20190806"
ARG HDF5_VERSION="1.10.5"
ARG NETCDF_VERSION="4.7.0"
ARG QSCINTILLA_VERSION="2.11.1"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev sqlite ninja qca qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev mt-st \
               curl-dev fcgi-dev zlib-dev openmpi-dev libxml2-dev \
               automake autoconf freexl-dev proj proj-dev python3-dev libspatialite-dev ipsec-tools ipsec-tools-dev libressl libressl-dev asio asio-dev py3-oauth2client py3-service_identity py3-cherrypy xmlsec-dev py3-urllib3 openssl openssl-dev py3-cryptography boost-dev py3-pycryptodome py3-sip-pyqt5 py3-sip py-sip-dev py3-qtpy"
ARG CLONEGITS="https://github.com/libspatialindex/libspatialindex.git \
               '-b release-3_4 --depth 1 https://github.com/qgis/QGIS.git'"
ARG DOWNLOADS="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz \
               https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz \
               https://www.riverbankcomputing.com/static/Downloads/QScintilla/$QSCINTILLA_VERSION/QScintilla_gpl-$QSCINTILLA_VERSION.tar.gz"
ARG BUILDCMDS=\
'qgis_DESTDIR="$DESTDIR" '\
"&& unset DESTDIR "\
"&& cd hdf5-$HDF5_VERSION "\
'&& $COMMON_CONFIGURECMD --enable-parallel '\
'&& $COMMON_MAKECMDS '\
"&& cd ../netcdf-c-$NETCDF_VERSION "\
'&& $COMMON_INSTALLSRC '\
"&& cd ../libspatialindex "\
"&& ./autogen.sh "\
'&& $COMMON_INSTALLSRC '\
"&& cd ../QScintilla_gpl-$QSCINTILLA_VERSION/Qt4Qt5 "\
"&& qmake-qt5 "\
'&& $COMMON_MAKECMDS '\
"&& cd ../Python "\
"&& python3 configure.py --pyqt=PyQt5 --qmake=/usr/bin/qmake-qt5 "\
"&& qmake-qt5 "\
'&& $COMMON_MAKECMDS '\
"&& cd ../../QGIS "\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=ON -DWITH_BINDINGS=ON -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF ./ "\
"&& ninja "\
'&& DESTDIR="$qgis_DESTDIR" ninja install'

#--------Generic template (don't edit)--------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as final
ARG CONTENTSOURCE1
ARG CONTENTSOURCE1="${CONTENTSOURCE1:-/}"
ARG CONTENTDESTINATION1
ARG CONTENTDESTINATION1="${CONTENTDESTINATION1:-/}"
ARG CONTENTSOURCE2
ARG CONTENTSOURCE2="${CONTENTSOURCE2:-/}"
ARG CONTENTDESTINATION2
ARG CONTENTDESTINATION2="${CONTENTDESTINATION2:-/}"
ARG CONTENTSOURCE3
ARG CONTENTSOURCE3="${CONTENTSOURCE3:-/}"
ARG CONTENTDESTINATION3
ARG CONTENTDESTINATION3="${CONTENTDESTINATION3:-/}"
ARG CLONEGITSDIR
ARG DOWNLOADSDIR
ARG MAKEDIRS
ARG MAKEFILES
ARG EXECUTABLES
ARG STARTUPEXECUTABLES
ARG EXPOSEFUNCTIONS
ARG GID0WRITABLES
ARG GID0WRITABLESRECURSIVE
ARG LINUXUSEROWNED
ARG LINUXUSEROWNEDRECURSIVE
COPY --from=build /finalfs /
#---------------------------------------------

#--------Generic template (don't edit)--------
USER starter
ONBUILD USER root
#---------------------------------------------

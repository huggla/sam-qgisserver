ARG TAG="20190527"
ARG HDF5_VERSION="1.8.21"
ARG NETCDF_VERSION="4.7.0"
ARG SIP_VERSION="4.19.17"
ARG QSCINTILLA_VERSION="2.11.1"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev proj4-dev ninja qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev \
               curl-dev fcgi-dev zlib-dev \
               automake autoconf py3-qt5 python3-dev qt5-qtxmlpatterns-dev"
ARG CLONEGITS="https://github.com/libspatialindex/libspatialindex.git \
               '-b release-3_4 --depth 1 https://github.com/qgis/QGIS.git'"
ARG DOWNLOADS="https://raw.githubusercontent.com/txt2tags/txt2tags/master/txt2tags \
               http://www.hdfgroup.org/ftp/HDF5/current18/src/hdf5-$HDF5_VERSION.tar.gz \
	       http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-4.4.0-RC1.tar.gz \
               https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz \
               https://www.riverbankcomputing.com/static/Downloads/sip/$SIP_VERSION/sip-$SIP_VERSION.tar.gz \
               https://www.riverbankcomputing.com/static/Downloads/QScintilla/$QSCINTILLA_VERSION/QScintilla_gpl-$QSCINTILLA_VERSION.tar.gz"
ARG BUILDCMDS=\
"   mv txt2tags /usr/bin/ "\
"&& chmod +x /usr/bin/txt2tags "\
"&& cd hdf5-$HDF5_VERSION "\
"&& ./configure \
		--build=$CBUILD \
		--host=$CHOST \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--disable-threadsafe \
		--enable-cxx \
		--enable-direct-vfd \
    --enable-parallel "\
"&& make "\
"&& make install "\
"&& cd netcdf-c-$NETCDF_VERSION "\
"&& ./configure --prefix=/usr "\
"&& make "\
"&& DESTDIR=/ make install "\
"&& cd ../http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-4.4.0-RC1 "\
"&& ./configure \
                --prefix=/usr \
                --build=$CBUILD \
                --host=$CHOST \
                --enable-freexl=no "\
"&& make "\
"&& make install "\
"&& cd ../libspatialindex "\
"&& ./autogen.sh "\
"&& ./configure --prefix=/usr "\
"&& make "\
"&& DESTDIR=/ make install "\
"&& ln -s /usr/lib/qt5/bin/qmake /usr/bin/ "\
"&& cd ../sip-$SIP_VERSION "\
"&& python3 configure.py --use-qmake "\
"&& qmake "\
"&& python3 configure.py "\
"&& make "\
"&& DESTDIR=/ make install "\
"&& cd ../QScintilla_gpl-$QSCINTILLA_VERSION/Qt4Qt5 "\
"&& qmake "\
"&& make "\
"&& DESTDIR=/ make install "\
"&& cd ../Python "\
"&& python3 configure.py --pyqt=PyQt5 "\
"&& sed -i 's/include_next/include/' /usr/include/fortify/stdlib.h "\
"&& qmake "\
"&& make "\
"&& DESTDIR=/ make install "\
"&& ln -s /usr/bin/python3.7 /usr/bin/python "\
"&& cd ../../ "\
"&& rm -rf netcdf-c-$NETCDF_VERSION libspatialindex sip-$SIP_VERSION QScintilla_gpl-$QSCINTILLA_VERSION "\
"&& apk del autoconf automake "\
"&& cd QGIS "\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=ON -DWITH_BINDINGS=ON -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF ./ "\
"&& ninja "\
"&& ninja install"

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

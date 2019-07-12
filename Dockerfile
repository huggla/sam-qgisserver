ARG TAG="20190527"
ARG HDF5_VERSION="1.10.5"
ARG NETCDF_VERSION="4.7.0"
ARG SIP_VERSION="4.19.17"
ARG QSCINTILLA_VERSION="2.11.1"
#ARG CFLAGS="-I/proj5.2.0/usr/include"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev sqlite ninja qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev mt-st \
               curl-dev fcgi-dev zlib-dev openmpi-dev libxml2-dev \
               automake autoconf py3-qt5 python3-dev qt5-qtxmlpatterns-dev boost-dev boost-build gfortran gtest-dev freexl-dev hdf5-dev proj4-dev \
	       acct cmake cryptsetup-libs device-mapper-libs syslinux mtools lddtree openrc ncurses-terminfo openssh alpine-conf busybox-suid busybox-initscripts alpine-keys alpine-base libcap libcom qt5-qtbase-x11 openssl libcom_err libattr chrony chrony-openrc e2fsprogs e2fsprogs-libs"
ARG CLONEGITS="https://github.com/libspatialindex/libspatialindex.git \
               '-b release-3_4 --depth 1 https://github.com/qgis/QGIS.git'"
ARG DOWNLOADS="\
#https://raw.githubusercontent.com/txt2tags/txt2tags/master/txt2tags \
               https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz \
	       http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-5.0.0-beta0.tar.gz \
               https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz \
	       http://download.osgeo.org/proj/proj-5.2.0.tar.gz \
               https://www.riverbankcomputing.com/static/Downloads/sip/$SIP_VERSION/sip-$SIP_VERSION.tar.gz \
               https://www.riverbankcomputing.com/static/Downloads/QScintilla/$QSCINTILLA_VERSION/QScintilla_gpl-$QSCINTILLA_VERSION.tar.gz"
#ARG CFLAGS="apa=apa"
ARG BUILDCMDS=\
"cd proj-5.2.0 "\
#"&& echo \"\$DESTDIR\" "\
#"&& IFS_bak=\$IFS "\
#"&& echo -n \"\$IFS_bak\" "\
#"&& echo stop "\
#"&& apk -q list -I "\
"&& ./configure --prefix=/usr "\
"&& make "\
#"&& libtool --finish /usr/lib "\
"&& unset DESTDIR "\
"&& unset CFLAGS "\
"&& make install "\
"&& libtool --finish /usr/lib "\
"&& cd ../hdf5-$HDF5_VERSION "\
"&& ./configure \
--prefix=/usr \
--sysconfdir=/etc \
--localstatedir=/var \
--disable-threadsafe \
#               --enable-cxx \
--enable-direct-vfd \
    --enable-parallel "\
"&& make "\
#"&& libtool --finish /usr/lib "\
"&& make install "\
"&& libtool --finish /usr/lib "\
"&& cd ../netcdf-c-$NETCDF_VERSION "\
"&& ./configure --prefix=/usr "\
"&& make "\
#"&& libtool --finish /usr/lib "\
"&& make install "\
"&& libtool --finish /usr/lib "\
"&& cd ../libspatialite-5.0.0-beta0 "\
#"&& CFLAGS=\"$CFLAGS -I/proj5.2.0/usr/include\" ./configure --prefix=/usr "\
"&& ./configure --prefix=/usr "\
#"&& CFLAGS=\"$CFLAGS -I/proj5.2.0/usr/include\" make "\
"&& make "\
#"&& libtool --finish /usr/lib "\
#"&& CFLAGS=\"$CFLAGS -I/proj5.2.0/usr/include\" make install "\
"&& make install "\
"&& libtool --finish /usr/lib "\
#"&& IFS=\$IFS_bak "\
"&& cd ../libspatialindex "\
"&& ./autogen.sh "\
"&& ./configure --prefix=/usr "\
"&& make "\
#"&& libtool --finish /usr/lib "\
"&& make install "\
"&& ln -s /usr/lib/qt5/bin/qmake /usr/bin/ "\
"&& libtool --finish /usr/lib "\
"&& cd ../sip-$SIP_VERSION "\
"&& qmake -query "\
"&& python3 configure.py --use-qmake "\
"&& qmake -query "\
"&& qmake -d "\
#"&& python3 configure.py "\
"&& make "\
#"&& libtool --finish /usr/lib "\
"&& make install "\
"&& libtool --finish /usr/lib "\
#"&& ls -la /usr/lib/qt5/mkspecs/common "\
"&& cd ../QScintilla_gpl-$QSCINTILLA_VERSION/Qt4Qt5 "\
#"&& qmake -query "\
"&& qmake "\
"&& cat Makefile "\
"&& make "\
#"&& libtool --finish /usr/lib "\
"&& make install "\
"&& libtool --finish /usr/lib "\
"&& cd ../Python "\
"&& python3 configure.py --pyqt=PyQt5 "\
#"&& sed -i 's/include_next/include/' /usr/include/fortify/stdlib.h "\
#"&& qmake "\
"&& make "\
#"&& libtool --finish /usr/lib "\
"&& make install "\
"&& libtool --finish /usr/lib "\
"&& ln -s /usr/bin/python3.7 /usr/bin/python "\
"&& cd ../../ "\
#"&& rm -rf netcdf-c-$NETCDF_VERSION libspatialindex sip-$SIP_VERSION QScintilla_gpl-$QSCINTILLA_VERSION "\
#"&& apk del autoconf automake "\
"&& cd QGIS "\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=ON -DWITH_BINDINGS=ON -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF ./ "\
"&& ninja "\
#"&& libtool --finish /usr/lib "\
"&& DESTDIR=$DESTDIR ninja install "\
"&& libtool --finish /usr/lib"

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

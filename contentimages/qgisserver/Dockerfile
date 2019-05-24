ARG TAG="20190517"
ARG NETCDF_VERSION="4.7.0"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev proj4-dev ninja qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev \
               hdf5-dev curl-dev fcgi-dev libspatialite-dev \
               automake autoconf"
ARG CLONEGITS="https://github.com/libspatialindex/libspatialindex.git \
               https://github.com/qgis/QGIS.git"
ARG DOWNLOADS="https://raw.githubusercontent.com/txt2tags/txt2tags/master/txt2tags \
               https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz"
ARG BUILDCMDS=\
"   mv txt2tags /usr/bin/ "\
"&& cd netcdf-c-$NETCDF_VERSION "\
"&& ./configure --prefix=/usr "\
"&& make "\
"&& DESTDIR=/ make install "\
"&& cd ../libspatialindex "\
"&& ./autogen.sh "\
"&& ./configure --prefix=/usr "\
"&& make "\
"&& DESTDIR=/ make install "\
"&& cd ../QGIS "\
"&& cmake -GNinja -DCMAKE_INSTALL_PREFIX=/usr -DWITH_GRASS=OFF -DWITH_GRASS7=OFF \
          -DSUPPRESS_QT_WARNINGS=ON -DENABLE_TESTS=OFF -DWITH_QSPATIALITE=OFF \
          -DWITH_APIDOC=OFF -DWITH_ASTYLE=OFF -DWITH_DESKTOP=OFF -DWITH_SERVER=ON \
          -DWITH_SERVER_PLUGINS=OFF -DWITH_BINDINGS=OFF -DWITH_QTMOBILITY=OFF \
          -DWITH_QUICK=OFF -DWITH_3D=OFF -DWITH_GUI=OFF -DDISABLE_DEPRECATED=ON \
          -DSERVER_SKIP_ECW=ON -DWITH_GEOREFERENCER=OFF "

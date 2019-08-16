# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190806"
ARG NETCDF_VERSION="4.7.0"
ARG PNETCDF_VERSION="1.11.2"
ARG HDF5_MAJOR_VERSION="1.10"
ARG HDF5_MINOR_VERSION="5"
ARG HDF5_VERSION="$HDF5_MAJOR_VERSION.$HDF5_MINOR_VERSION"
ARG HUBPROFILE="huggla"
ARG HUBREPO="netcdf"
ARG HUBVERSION="$NETCDF_VERSION"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base musl-dev zlib-dev openmpi-dev curl-dev m4 libtool linux-headers linux-virt-dev autoconf automake"
ARG CLONEGITS="https://github.com/Parallel-NetCDF/PnetCDF.git"
ARG DOWNLOADS="https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz \
               https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$HDF5_MAJOR_VERSION/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd hdf5-$HDF5_VERSION "\
"&& cd ../PnetCDF "\
"&& autoreconf -i "\
'&& ./configure '\
'&& make '\
'&& DESTDIR="" make install '\
'&& exit '\
"&& cd ../netcdf-c-$NETCDF_VERSION "\
'&& $COMMON_CONFIGURECMD --disable-shared --enable-pnetcdf --enable-fsync --enable-dynamic-loading --disable-utilities --disable-examples --disable-testsets --enable-parallel-tests '\
'&& $COMMON_MAKECMDS '\
'&& mkdir -p "$DESTDIR-dev/usr/lib" "$DESTDIR-doc/usr" "$DESTDIR-util/usr" "$DESTDIR-static/usr/lib" '\
'&& mv "$DESTDIR/usr/lib/pkgconfig" "$DESTDIR-dev/usr/lib/" '\
'&& mv "$DESTDIR/usr/include" "$DESTDIR-dev/usr/" '\
'&& mv "$DESTDIR/usr/share" "$DESTDIR-doc/usr/" '\
'&& mv "$DESTDIR/usr/bin" "$DESTDIR-util/usr/" '\
'&& mv "$DESTDIR/usr/lib/libnetcdf.a" "$DESTDIR-static/usr/lib/"'
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
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

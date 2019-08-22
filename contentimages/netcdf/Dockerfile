# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190820"
ARG NETCDF_VERSION="4.7.0"
ARG PNETCDF_VERSION="1.11.2"
ARG HDF5_MAJOR_VERSION="1.10"
ARG HDF5_MINOR_VERSION="5"
ARG HDF5_VERSION="$HDF5_MAJOR_VERSION.$HDF5_MINOR_VERSION"
ARG HUBPROFILE="huggla"
ARG HUBREPO="netcdf"
ARG HUBVERSION="$NETCDF_VERSION"
ARG BASEIMAGE="huggla/hdf5:$HDF5_VERSION"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="zlib-dev openmpi-dev curl-dev m4"
ARG DOWNLOADS="https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz \
               https://parallel-netcdf.github.io/Release/pnetcdf-$PNETCDF_VERSION.tar.gz \
               https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$HDF5_MAJOR_VERSION/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd netcdf-c-$NETCDF_VERSION "\
'&& CC=mpicc LIBS=-ldl $COMMON_CONFIGURECMD --disable-doxygen --disable-shared --enable-parallel-tests --disable-utilities --disable-testsets --enable-erange-fill --with-gnu-ld '\
'&& make '\
'&& DESTDIR="" make install '\
'&& make clean '\
"&& cd ../pnetcdf-$PNETCDF_VERSION "\
'&& $COMMON_CONFIGURECMD --disable-shared --disable-cxx --disable-fortran --with-gnu-ld --enable-netcdf4 '\
'&& make '\
'&& DESTDIR="" make install '\
"&& cd ../netcdf-c-$NETCDF_VERSION "\
'&& CC=mpicc LIBS=-ldl $COMMON_CONFIGURECMD --disable-doxygen --disable-shared --enable-pnetcdf --enable-parallel-tests --disable-utilities --disable-testsets --enable-erange-fill --with-gnu-ld '\
'&& $COMMON_MAKECMDS'
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
# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>

# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190806"
ARG NETCDF_VERSION="4.7.0"
ARG HDF5_VERSION="1.10.5"
ARG HUBPROFILE="huggla"
ARG HUBREPO="netcdf"
ARG HUBVERSION="$NETCDF_VERSION"
ARG BASEIMAGE="huggla/hdf5:$HDF_VERSION"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base"
ARG DOWNLOADS="https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd /netcdf-c-$NETCDF_VERSION "\
"&& rm -rf /app/* "\
'&& $COMMON_CONFIGURECMD --enable-fsync --enable-dynamic-loading --disable-utilities --disable-testsets '\
'&& $COMMON_MAKECMDS'
# ARGs (passed to Build) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
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

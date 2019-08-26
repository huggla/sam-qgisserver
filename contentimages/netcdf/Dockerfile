# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190822"
ARG IMAGETYPE="content"
ARG NETCDF_VERSION="4.7.0"
ARG PNETCDF_VERSION="1.11.2"
ARG HDF5_MAJOR_VERSION="1.10"
ARG HDF5_MINOR_VERSION="5"
ARG HDF5_VERSION="$HDF5_MAJOR_VERSION.$HDF5_MINOR_VERSION"
ARG HUBPROFILE="huggla"
ARG HUBREPO="netcdf"
ARG HUBVERSION="$NETCDF_VERSION"
ARG ADDTO_PATH="/usr"
ARG BASEIMAGE="huggla/hdf5"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="zlib-dev openmpi-dev curl-dev m4"
ARG DOWNLOADS="https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-$NETCDF_VERSION.tar.gz \
               https://parallel-netcdf.github.io/Release/pnetcdf-$PNETCDF_VERSION.tar.gz"
ARG BUILDCMDS=\
'LDFLAGS=\"-L/usr/lib -I/usr/include\" '\
"&& cd netcdf-c-$NETCDF_VERSION "\
'&& CC=mpicc $COMMON_CONFIGURECMD '\
'&& make && make install'
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

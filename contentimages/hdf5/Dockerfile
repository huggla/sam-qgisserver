# ==================== Init stage ====================
# Build ARGs
ARG TAG="20190806"
ARG HDF5_MAJOR_VERSION="1.10"
ARG HDF5_MINOR_VERSION="5"
ARG HDF5_VERSION="$HDF5_MAJOR_VERSION.$HDF5_MINOR_VERSION"
ARG HUBPROFILE="huggla"
ARG HUBREPO="hdf5"
ARG HUBVERSION="$HDF5_VERSION"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base"
ARG DOWNLOADS="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$HDF5_MAJOR_VERSION/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd /hdf5-$HDF5_VERSION "\
'&& $COMMON_CONFIGURECMD --enable-static=no --enable-parallel --enable-direct-vfd=yes '\
'&& $COMMON_MAKECMDS'

# Generic template (don't edit)
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init

# =================== Build stage ====================
# Generic template (don't edit)
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as final

# Build ARGs to pass to final stage


# Generic template (don't edit)
COPY --from=build /finalfs /

# =================== Final stage ====================
# Generic template (don't edit)
USER starter
ONBUILD USER root

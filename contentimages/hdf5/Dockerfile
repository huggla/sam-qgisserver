# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190806"
ARG HDF5_MAJOR_VERSION="1.10"
ARG HDF5_MINOR_VERSION="5"
ARG HDF5_VERSION="$HDF5_MAJOR_VERSION.$HDF5_MINOR_VERSION"
ARG HUBPROFILE="huggla"
ARG HUBREPO="hdf5"
ARG HUBVERSION="$HDF5_VERSION"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
#ARG RUNDEPS="zlib openmpi"
ARG BUILDDEPS="build-base zlib-dev openmpi-dev mt-st libtool"
ARG DOWNLOADS="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$HDF5_MAJOR_VERSION/hdf5-$HDF5_VERSION/src/hdf5-$HDF5_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd hdf5-$HDF5_VERSION "\
'&& $COMMON_CONFIGURECMD --enable-shared=no --enable-parallel --enable-direct-vfd=yes '\
'&& $COMMON_MAKECMDS '\
'&& mkdir -p "$DESTDIR-dev/usr/lib" "$DESTDIR-examples/usr/share" '\
'&& mv "$DESTDIR/usr/share/hdf5_examples" "$DESTDIR-examples/usr/share/" '\
'&& mv "$DESTDIR/usr/share" "$DESTDIR/usr/include" "$DESTDIR-dev/usr/"'
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

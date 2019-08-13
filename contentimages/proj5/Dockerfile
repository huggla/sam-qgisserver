# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build)
ARG TAG="20190806"
ARG PROJ_VERSION="5.2.0"
ARG HUBPROFILE="huggla"
ARG HUBREPO="proj5"
ARG HUBVERSION="$PROJ_VERSION"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base mt-st"
ARG DOWNLOADS="http://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd proj-$PROJ_VERSION "\
'&& $COMMON_CONFIGURECMD --enable-static=no '\
'&& $COMMON_MAKECMDS'

# ! Generic template (don't edit) !
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/base:$TAG}} as init

# =========================================================================
# Build
# =========================================================================
# ! Generic template (don't edit) !
FROM ${BUILDIMAGE:-huggla/build} as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as final
COPY --from=build /finalfs /

# =========================================================================
# Final
# =========================================================================
# ! Generic template (don't edit) !
USER starter
ONBUILD USER root

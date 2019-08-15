# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190806"
ARG PROJ_VERSION="5.2.0"
ARG HUBPROFILE="huggla"
ARG HUBREPO="proj5"
ARG HUBVERSION="$PROJ_VERSION"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG BUILDDEPS="build-base"
ARG DOWNLOADS="http://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd proj-$PROJ_VERSION "\
'&& $COMMON_INSTALLSRC '\
'&& mkdir -p "$DESTDIR-dev/usr/lib" "$DESTDIR-datumgrid/usr/share" "$DESTDIR-doc/usr" "$DESTDIR-util/usr" "$DESTDIR-static/usr/lib" '\
'&& mv "$DESTDIR/usr/lib/pkgconfig" "$DESTDIR-dev/usr/lib/" '\
'&& mv "$DESTDIR/usr/include" "$DESTDIR-dev/usr/" '\
'&& mv "$DESTDIR/usr/share/proj" "$DESTDIR-datumgrid/usr/share/" '\
'&& mv "$DESTDIR/usr/share" "$DESTDIR-doc/usr/" '\
'&& mv "$DESTDIR/usr/bin" "$DESTDIR-util/usr/" '\
'&& mv "$DESTDIR/usr/lib/libproj.a" "$DESTDIR-static/usr/lib/"'
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

# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190806"
ARG QSCINTILLA_VERSION="2.11.2"
ARG HUBPROFILE="huggla"
ARG HUBREPO="qscintilla"
ARG HUBVERSION="$QSCINTILLA_VERSION"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base cmake gdal-dev geos-dev libzip-dev \
               sqlite-dev sqlite ninja qca qca-dev qt5-qtbase-dev \
               flex-dev opencl-icd-loader-dev opencl-headers \
               bison postgresql-dev qt5-qtserialport-dev libtool \
               qt5-qtsvg-dev qt5-qtwebkit-dev qt5-qtlocation-dev \
               qt5-qttools-dev exiv2-dev qt5-qtkeychain-dev mt-st \
               curl-dev fcgi-dev zlib-dev openmpi-dev libxml2-dev \
               automake autoconf freexl-dev python3-dev \
               libspatialite-dev libressl libressl-dev \
               py3-sip-pyqt5 py3-sip py-sip-dev py3-qtpy \
               qt5-qtxmlpatterns-dev py3-opencl fortify-headers boost-dev boost-build"
ARG DOWNLOADS="https://www.riverbankcomputing.com/static/Downloads/QScintilla/$QSCINTILLA_VERSION/QScintilla_gpl-$QSCINTILLA_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd QScintilla_gpl-$QSCINTILLA_VERSION/Qt4Qt5 "\
'&& sedstr="/TRANSLATIONS/,\$d" '\
"&& sed -i '\$sedstr' qscintilla.pro "\
'&& qmake-qt5 -set DESTDIR $DESTDIR '\
"&& qmake-qt5 "\
"&& make "\
"&& make install "\
"&& cd ../Python "\
'&& python3 configure.py --pyqt=PyQt5 --qmake=/usr/bin/qmake-qt5 --no-docstrings --destdir=$DESTDIR '\
"&& sed -i 's/include_next/include/' /usr/include/fortify/stdlib.h "\
"&& make "\
"&& make install"
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

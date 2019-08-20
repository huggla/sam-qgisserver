# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190820"
ARG QSCINTILLA_VERSION="2.11.2"
ARG HUBPROFILE="huggla"
ARG HUBREPO="qscintilla"
ARG HUBVERSION="$QSCINTILLA_VERSION"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG ADDREPOS="http://dl-cdn.alpinelinux.org/alpine/edge/testing"
ARG BUILDDEPS="build-base libtool qt5-qtbase-dev py3-sip-pyqt5 py3-sip py3-qtpy py-sip-dev python3-dev fortify-headers"
ARG DOWNLOADS="https://www.riverbankcomputing.com/static/Downloads/QScintilla/$QSCINTILLA_VERSION/QScintilla_gpl-$QSCINTILLA_VERSION.tar.gz"
ARG DESTDIR="/app"
ARG BUILDCMDS=\
"   cd QScintilla_gpl-$QSCINTILLA_VERSION/Qt4Qt5 "\
"&& qmake-qt5 "\
'&& $COMMON_MAKECMDS '\
"&& cd ../Python "\
"&& python3 configure.py --pyqt=PyQt5 --qmake=/usr/bin/qmake-qt5 --no-docstrings "\
"&& sed -i 's/include_next/include/' /usr/include/fortify/stdlib.h "\
'&& $COMMON_MAKECMDS '\
"&& cd / "\
"&& cp -a \$BUILDDIR \$DESTDIR/ "\
'&& apk --repositories-file /etc/apk/repositories --keys-dir /etc/apk/keys --no-cache --initramfs-diskless-boot --clean-protected --root $DESTDIR add --initdb '$BUILDDEPS\
'&& chroot $DESTDIR /bin/sh -c \"cd $BUILDDIR/QScintilla_gpl-'$QSCINTILLA_VERSION'/Qt4Qt5 && make install\" '\
'&& chroot $DESTDIR /bin/sh -c \"cd $BUILDDIR/QScintilla_gpl-'$QSCINTILLA_VERSION'/Python && make install\" '\
'&& apk --repositories-file /etc/apk/repositories --keys-dir /etc/apk/keys --no-cache --initramfs-diskless-boot --clean-protected --root $DESTDIR --purge del '$BUILDDEPS\
"&& rm -rf \$DESTDIR\$BUILDDIR"
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

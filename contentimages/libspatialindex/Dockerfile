# =========================================================================
# Init
# =========================================================================
# ARGs (passed to Build) <BEGIN>
ARG TAG="20190822"
ARG IMAGETYPE="content"
ARG HUBPROFILE="huggla"
ARG HUBREPO="libspatialindex"
ARG HUBVERSION="$TAG"
ARG BASEIMAGE="huggla/busybox:$TAG"
ARG CLONEGITS="https://github.com/libspatialindex/libspatialindex.git"
ARG BUILDCMDS=\
"   cd libspatialindex "\
"&& ./autogen.sh "\
'&& $COMMON_INSTALLSRC'
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

ARG GOLANG_IMAGE_TAG='1.23.6'
FROM golang:${GOLANG_IMAGE_TAG}

ARG LIBVIPS_VERSION='8.12.0'
ARG RELEASE_TAR="vips-${LIBVIPS_VERSION}.tar.gz"

RUN wget "https://github.com/libvips/libvips/releases/download/v${LIBVIPS_VERSION}/${RELEASE_TAR}"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates automake build-essential curl \
    gobject-introspection gtk-doc-tools libglib2.0-dev libjpeg62-turbo-dev libpng-dev \
    libwebp-dev libtiff5-dev libgif-dev libexif-dev libxml2-dev libpoppler-glib-dev \
    swig libmagickwand-dev libpango1.0-dev libmatio-dev libopenslide-dev libcfitsio-dev \
    libgsf-1-dev libfftw3-dev libfftw3-doc liborc-0.4-dev librsvg2-dev libimagequant-dev libheif-dev

RUN tar -xf "${RELEASE_TAR}" && \
    cd vips-${LIBVIPS_VERSION} && \
    ./configure \
        --disable-debug \
        --disable-dependency-tracking \
        --disable-introspection \
        --disable-static \
        --enable-gtk-doc-html=no \
        --enable-gtk-doc=no \
        --enable-pyvips8=no && \
    make && \
    make install && \
    ldconfig

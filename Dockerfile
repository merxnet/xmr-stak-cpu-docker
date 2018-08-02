ARG ALPINE_VERSION=3.8


FROM alpine:${ALPINE_VERSION} AS build

ENV CMAKE_OPTS '-DMICROHTTPD_ENABLE=OFF -DXMR-STAK_COMPILE=generic -DOpenCL_ENABLE=OFF -DCUDA_ENABLE=OFF'

RUN apk update \
    && apk add --no-cache cmake g++ gcc git libressl-dev libstdc++ make \
    && apk add --no-cache hwloc-dev --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    && git clone https://github.com/fireice-uk/xmr-stak.git \
    && cd xmr-stak \
    && git checkout $(git describe --abbrev=0 --tags) \
    && mkdir build \
    && cd build \
    && cmake .. ${CMAKE_OPTS} \
    && make install


FROM alpine:${ALPINE_VERSION}

LABEL maintainer='docker@merxnet.io'

COPY --from=build /xmr-stak/build/bin/xmr-stak /usr/local/bin/

RUN apk update \
    && apk add --no-cache gcc libstdc++ \
    && apk add --no-cache hwloc-dev --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

ENTRYPOINT ["xmr-stak"]

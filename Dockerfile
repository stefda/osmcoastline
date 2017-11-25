FROM ubuntu:trusty

MAINTAINER David Stefan <stefda@gmail.com>

RUN apt-get update && \
    apt-get install -y gcc g++ make cmake cmake-curses-gui make libexpat1-dev zlib1g-dev libbz2-dev libgdal1-dev \
    sqlite3 pandoc wget libsparsehash-dev libboost-dev libgdal-dev libproj-dev doxygen graphviz

RUN mkdir /var/install
WORKDIR /var/install

ENV OSMIUM_VERSION 2.13.1

RUN wget https://github.com/osmcode/libosmium/archive/v${OSMIUM_VERSION}.tar.gz && \
    tar xzvf v${OSMIUM_VERSION}.tar.gz && \
    rm v${OSMIUM_VERSION}.tar.gz && \
    mv libosmium-${OSMIUM_VERSION} libosmium

RUN cd libosmium && \
    mkdir build && cd build && \
    cmake .. && make

ENV OSMCOASTLINE_VERION 2.1.4

RUN wget https://github.com/osmcode/osmcoastline/archive/v${OSMCOASTLINE_VERION}.tar.gz && \
    tar xzvf v${OSMCOASTLINE_VERION}.tar.gz && \
    rm v${OSMCOASTLINE_VERION}.tar.gz && \
    mv osmcoastline-${OSMCOASTLINE_VERION} osmcoastline

RUN cd osmcoastline && \
    mkdir build && cd build && \
    cmake .. && make

RUN ln -s /var/install/osmcoastline/build/src/osmcoastline /usr/bin/osmcoastline && \
    ln -s /var/install/osmcoastline/build/src/osmcoastline_filter /usr/bin/osmcoastline_filter && \
    ln -s /var/install/osmcoastline/build/src/osmcoastline_segments /usr/bin/osmcoastline_segments && \
    ln -s /var/install/osmcoastline/build/src/osmcoastline_ways /usr/bin/osmcoastline_ways

#!/usr/bin/env bash

set -e

ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

unset HOST \
    && . ./env.sh \
    || yes | ns-package-install \
    && . ./env.sh \
    && ns-clone \
    && ns-pull-install \
    && rm env.sh \
    && cd ~/dev-netsurf/workspace \
    && source env.sh \
    && cd netsurf \
    && make -j`nproc --all` TARGET=framebuffer

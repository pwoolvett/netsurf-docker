#!/usr/bin/env bash

set -e

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
    && make TARGET=framebuffer

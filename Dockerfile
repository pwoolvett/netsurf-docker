FROM ubuntu:latest

ENV TZ=America/Santiago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y \
        wget \
        sudo \
        libsdl1.2debian \
        libsdl1.2-dev

RUN ["wget", "https://git.netsurf-browser.org/netsurf.git/plain/docs/env.sh"]
COPY setup.sh setup.sh
RUN bash -c "./setup.sh"

WORKDIR /root/dev-netsurf/workspace/netsurf/

ENTRYPOINT ./nsfb
# RUN unset HOST \
#     && . ./env.sh \
#     && ns-package-install \
#     && ns-clone \
#     && ns-pull-install \
#     && rm env.sh \
#     && cd ~/dev-netsurf/workspace \
#     && source env.sh \
#     && cd netsurf \
#     && make TARGET=framebuffer \
#     && ./nsfbmake

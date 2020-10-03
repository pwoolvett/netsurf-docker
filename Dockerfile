FROM ubuntu:latest

RUN apt-get update \
    && apt-get install -y \
        wget \
        sudo

RUN ["wget", "https://git.netsurf-browser.org/netsurf.git/plain/docs/env.sh"]
COPY setup.sh setup.sh
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# RUN bash -c "./setup.sh"
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

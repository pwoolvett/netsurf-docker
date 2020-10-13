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

ENTRYPOINT ["/root/dev-netsurf/workspace/netsurf/nsfb", "-f", "sdl"]
CMD ["-w", "400", "-h", "400", "google.com"]

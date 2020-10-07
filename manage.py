#!/usr/bin/env python
# -*- coding: utf-8 -*-
""""""

from textwrap import dedent as _
from shlex import split
import subprocess
import sys


DEFAULT_ARGS = "-w 1920 -h 1080 google.com"


class Commands:
    def call(cmd, **kw):
        return subprocess.run(split(cmd), **kw)

    def build():
        cmd = "docker build -t pwoolvett/netsurf-fb ."
        return Commands.call(cmd)

    def bash():
        cmd = "docker run --rm -it --privileged --entrypoint bash pwoolvett/netsurf-fb"
        return Commands.call(cmd)

    def run():
        cmd = "docker run --rm -it --privileged pwoolvett/netsurf-fb "
        return Commands.call(cmd)

    def install():
        Commands.build()
        loc = "/usr/local/bin/netsurf"
        script = _(
            """\
            #!/usr/bin/env bash
            docker run --rm -it --privileged pwoolvett/netsurf-fb $@
            """
        )

        cmd = '''sh -c "echo -n '{}' | sudo tee {}"'''.format(r"{}".format(script), loc)

        r1 = subprocess.check_output(split(cmd))
        r2 = subprocess.check_output(split(f"sudo chmod +x {loc}"))

        print(f"Succesfully installed netsurf at {loc}")
        return r1 + r2


def cli():
    try:
        cmdname = sys.argv[1]
        func = getattr(Commands, cmdname)
    except IndexError:
        return Commands.install()
    except (AttributeError):
        print(f"Available Commands: build, install, bash, run")
        return 1
    return func()


if __name__ == "__main__":
    cli()

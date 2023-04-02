# syntax=docker/dockerfile:1
ARG VERSION=latest
FROM debian:${VERSION}
ARG VERSION
LABEL maintainer "Vijay Lulla <vijaylulla@gmail.com>"

SHELL ["/bin/bash", "-c"]

## Useful tools for all of my exploratory work.
RUN <<EOT
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq --yes

apt-get install --yes --auto-remove --no-install-recommends build-essential tini coreutils findutils git tree jq git htop vim ripgrep curl perf strace psmisc

apt-get autoclean && rm -rf /var/lib/apt/lists/*
unset DEBIAN_FRONTEND
EOT

## ## install the packages that you need
## RUN <<EOT
## apt-get update --yes
## apt-get install --yes --auto-remove zsh
## EOT

ARG USR=usr
ARG GRP=grp

## ## See the rules that ADD obeys at https://docs.docker.com/engine/reference/builder/#add
## ## <src> path must be **inside of the context** of the build! And, that is why I cannot do ADD --chown=${USR}:${GRP} /home/vijay /home/usr !
##
## ADD --chown=${USR}:${GRP} . /home/usr

RUN <<EOT
adduser --group ${GRP}
adduser --shell /bin/bash --ingroup ${GRP} ${USR}
EOT

WORKDIR /home/${USR}
USER ${USR}

## ## Understanding interaction between ENTRYPOINT and CMD is helpful. https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact
## Might resolve timedatectl/systemd issues that I saw in R console on Vertex AI??
ENTRYPOINT ["tini", "--"]

CMD ["/bin/bash"]

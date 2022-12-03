# syntax=docker/dockerfile:1
ARG VERSION=latest
FROM debian:${VERSION}
ARG VERSION
LABEL maintainer "Vijay Lulla <vijaylulla@gmail.com>"

RUN <<EOT
apt-get update -qq --yes 

apt-get install --yes --auto-remove --no-install-recommends build-essential
apt-get install --yes --auto-remove zsh 
apt-get install --yes --auto-remove jq git # install packages you need here...

apt-get autoclean && rm -rf /var/lib/apt/lists/*
EOT


ARG USR=usr
ARG GRP=grp

RUN <<EOT
adduser --group ${GRP}
adduser --shell /bin/bash --ingroup ${GRP} ${USR}
EOT

WORKDIR /home/${USR}
USER ${USR}

CMD ["/bin/bash"]

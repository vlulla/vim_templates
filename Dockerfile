ARG VERSION=latest
FROM ubuntu:${VERSION}
ARG VERSION
LABEL maintainer "Vijay Lulla <vijaylulla@gmail.com>"

RUN apt-get update -qq --yes && apt-get install --yes --auto-remove --no-install-recommends build-essential \
  && apt-get autoclean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

# build ntttcp
FROM golang:1.10 AS ntttcp

LABEL maintainer="eric.ernst@intel.com"

RUN git clone -q --depth 1 https://github.com/Microsoft/ntttcp-for-linux.git /ntttcp-for-linux
WORKDIR /ntttcp-for-linux/src
RUN make

# final image:
FROM ubuntu
WORKDIR /run
COPY --from=ntttcp  /ntttcp-for-linux/src/ntttcp .
RUN apt-get update && apt-get install -y dnsutils

ENTRYPOINT ["/run/ntttcp"]

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libssl-dev

COPY live /opt/live

WORKDIR /opt/live
RUN ./genMakefiles linux
RUN make clean
RUN make

WORKDIR /run_env
COPY videos/* .

CMD ["/opt/live/mediaServer/live555MediaServer"]

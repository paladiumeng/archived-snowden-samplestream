FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    wget \
    ffmpeg \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/bluenviron/mediamtx/releases/download/v1.8.3/mediamtx_v1.8.3_linux_amd64.tar.gz -O /mediamtx.tar.gz \
    && tar -xzf /mediamtx.tar.gz -C / \
    && rm /mediamtx.tar.gz

EXPOSE 8554

WORKDIR /
COPY mediamtx.yaml /mediamtx.yaml
COPY video.mp4 /video.mp4

ENTRYPOINT ["/mediamtx", "mediamtx.yaml"]

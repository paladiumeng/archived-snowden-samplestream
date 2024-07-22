FROM rust:latest


RUN apt-get update && apt-get install -y \
    clang \
    libavdevice-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/snowden-samplestream
COPY oddity-rtsp ./oddity-rtsp 

WORKDIR /opt/snowden-samplestream/oddity-rtsp
RUN cargo build --release

WORKDIR /opt/snowden-samplestream
COPY config.yaml .

COPY videos/incendies.mp4 /opt/snowden-samplestream/videos/incendies.mp4

CMD ["oddity-rtsp/target/release/oddity-rtsp-server", "config.yaml"]

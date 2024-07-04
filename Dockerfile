FROM rust:latest

WORKDIR /opt/snowden-samplestream

COPY oddity-rtsp .

COPY videos /opt/snowden-samplestream/videos

WORKDIR /opt/snowden-samplestream/oddity-rtsp/oddity-rtsp-server
COPY config.yaml .
RUN cargo build --release

CMD ["cargo run config.yaml"]

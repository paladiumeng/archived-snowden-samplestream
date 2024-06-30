FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libssl-dev

# Install Live555
WORKDIR /opt
COPY live /opt/live

WORKDIR /opt/live
RUN ./genMakefiles linux
RUN make
RUN make install

# Set up the project
WORKDIR /app
COPY . .
RUN make

CMD ["./samplestream"]

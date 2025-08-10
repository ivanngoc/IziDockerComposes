FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
# Install clang/zlib1g-dev dependencies for publishing to native
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    clang \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies and Podman
RUN apt-get update && \
    apt-get install -y podman fuse-overlayfs uidmap slirp4netns iptables iproute2 && \
    rm -rf /var/lib/apt/lists/*

# Configure rootless runtime dir for Podman
ENV XDG_RUNTIME_DIR=/tmp/run
RUN mkdir -p $XDG_RUNTIME_DIR && chmod 700 $XDG_RUNTIME_DIR
RUN mkdir -p /tmp/runroot /tmp/graphroot && chmod 700 /tmp/runroot /tmp/graphroot

# Configure Podman to use fuse-overlayfs as mount_program
RUN mkdir -p /etc/containers && \
    printf '[storage]\ndriver = "overlay"\nrunroot = "/tmp/runroot"\ngraphroot = "/tmp/graphroot"\n[storage.options]\nmount_program = "/usr/bin/fuse-overlayfs"\n' > /etc/containers/storage.conf

CMD ["podman", "--version"]
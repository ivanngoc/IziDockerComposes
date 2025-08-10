FROM mcr.microsoft.com/dotnet/sdk:9.0

# Install packages needed for Docker
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    iptables \
    iproute2 \
    libseccomp2 \
    bash \
    iputils-ping \
    procps \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y \
       docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Create Docker socket directory with permissions
RUN mkdir -p /var/run && chmod 777 /var/run

# Copy entrypoint script that starts dockerd and runs your commands
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

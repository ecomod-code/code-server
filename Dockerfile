# syntax=docker/dockerfile:1.7

FROM lscr.io/linuxserver/code-server:latest

USER root

# System packages with cached apt downloads
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt-get update && \
    apt-get install -y \
        curl \
        openssh-client \
        gcc \
        g++ \
        make \
        python3 \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Node
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Playwright with cached browser downloads
RUN --mount=type=cache,target=/root/.cache \
    npm install -g playwright && \
    npx playwright install --with-deps

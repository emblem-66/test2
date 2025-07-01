FROM quay.io/fedora/fedora-bootc:latest AS base
#FROM quay.io/fedora/fedora-silverblue:latest AS base

# Base image
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/Base | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Workstation image
#FROM ghcr.io/emblem-66/test2:base AS silverblue
FROM base AS silverblue
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/Silverblue | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Server image
#FROM ghcr.io/emblem-66/test2:base AS serverblue
FROM base AS serverblue
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/Serverblue | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

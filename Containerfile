# to be deleted
FROM docker.io/archlinux:latest AS arch
#RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/arch | bash \
# && dnf clean all \
# && rm -rf /tmp/* /var/* /usr/etc \
# && rpm-ostree cleanup -m \
# && ostree container commit
RUN bootc container lint


# to be deleted
FROM quay.io/fedora/fedora-silverblue:latest AS silverblue
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/silverblue | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# to be deleted
FROM quay.io/fedora-ostree-desktops/base-atomic:42 AS fedora-ostree-desktops
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/fedora-ostree-desktops | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Base image
FROM quay.io/fedora/fedora-bootc:latest AS base
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/base | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Workstation image
#FROM ghcr.io/emblem-66/test2:base AS desktop
FROM base AS desktop
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/desktop | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Server image
#FROM ghcr.io/emblem-66/test2:base AS server
FROM base AS server
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/server | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* /usr/etc \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

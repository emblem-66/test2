FROM quay.io/fedora/fedora-bootc:latest AS base

RUN <<EOF uname -r
# System auto updates
sed -i 's/#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf 
systemctl enable rpm-ostreed-automatic.timer || true 
# Tailscale
dnf -y install tailscale 
systemctl enable tailscaled.service || true 
# SSH
systemctl enable sshd.service || true 
# Common packages
dnf -y install git
# Toolbox to Distrobox
dnf -y install distrobox
dnf -y remove toolbox
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOF
RUN bootc container lint

# Base image
#RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/Base | bash \
# && dnf clean all \
# && rm -rf /tmp/* /var/* \
# && rpm-ostree cleanup -m \
# && ostree container commit
#RUN bootc container lint

# Workstation image
#FROM ghcr.io/emblem-66/test2:base AS silverblue
FROM base AS silverblue
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/Silverblue | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Server image
#FROM ghcr.io/emblem-66/test2:base AS serverblue
FROM base AS serverblue
RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/Serverblue | bash \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# base
# && dnf install --assumeyes dnf5-plugins langpacks-en firewalld openssh tailscale git curl wget rsync \
# && systemctl enable firewalld.service sshd.service tailscaled.service  \
#
#
#
# desktop
# && dnf install --assumeyes flatpak gdm gnome-shell nautilus ptyxis adw-gtk3-theme \
# && systemctl set-default graphical.target \
# && git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/ \
#
#
#
# server
# && dnf install -y cockpit podman podman-compose toolbox distrobox \ 
# && dnf config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo" \
# && dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
# && systemctl enable cockpit.socket docker \
#
#

FROM quay.io/fedora/fedora-bootc:latest AS base-bootc
RUN uname -r \
 && rpm -qa | sort \
 && dnf install --assumeyes dnf5-plugins langpacks-en firewalld openssh tailscale git curl wget rsync \
 && systemctl enable firewalld.service sshd.service tailscaled.service \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint

FROM base-bootc AS desktop-bootc
RUN uname -r \
 && rpm -qa | sort \
 && dnf install --assumeyes flatpak gdm gnome-shell nautilus ptyxis adw-gtk3-theme \
 && systemctl set-default graphical.target \
 && git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/ \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint

FROM base-bootc AS server-bootc
RUN uname -r \
 && rpm -qa | sort \
 && dnf install -y cockpit podman podman-compose toolbox distrobox \ 
 && dnf config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo" \
 && dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
 && systemctl enable cockpit.socket docker \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint



FROM quay.io/fedora/fedora-silverblue:latest AS base-silverblue
RUN uname -r \
 && rpm -qa | sort \
 && dnf install --assumeyes dnf5-plugins langpacks-en firewalld openssh tailscale git curl wget rsync \
 && systemctl enable firewalld.service sshd.service tailscaled.service  \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint

FROM base-silverblue AS desktop-silverblue
RUN uname -r \
 && rpm -qa | sort \
 && dnf install --assumeyes flatpak gdm gnome-shell nautilus ptyxis adw-gtk3-theme \
 && systemctl set-default graphical.target \
 && git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/ \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint

FROM base-silverblue AS server-silverblue
RUN uname -r \
 && rpm -qa | sort \
 && dnf install -y cockpit podman podman-compose toolbox distrobox \ 
 && dnf config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo" \
 && dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
 && systemctl enable cockpit.socket docker \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint



FROM quay.io/fedora-ostree-desktops/base-atomic:42 AS base-fedora-ostree-desktops
RUN uname -r \
 && rpm -qa | sort \
 && dnf install --assumeyes dnf5-plugins langpacks-en firewalld openssh tailscale git curl wget rsync \
 && systemctl enable firewalld.service sshd.service tailscaled.service  \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint

FROM base-fedora-ostree-desktops AS desktop-fedora-ostree-desktops
RUN uname -r \
 && rpm -qa | sort \
 && dnf install --assumeyes flatpak gdm gnome-shell nautilus ptyxis adw-gtk3-theme \
 && systemctl set-default graphical.target \
 && git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/ \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint

FROM base-fedora-ostree-desktops AS server-fedora-ostree-desktops
RUN uname -r \
 && rpm -qa | sort \
 && dnf install -y cockpit podman podman-compose toolbox distrobox \ 
 && dnf config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo" \
 && dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin \
 && systemctl enable cockpit.socket docker \
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint



FROM docker.io/archlinux:latest AS base-arch
FROM base-arch AS desktop-arch
FROM base-arch AS server-arch


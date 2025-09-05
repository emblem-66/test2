FROM quay.io/fedora/fedora-bootc:latest AS bootc
#RUN mkdir -p /root/.gnupg
#RUN chmod +x /root/*
RUN dnf install -y dnf5-plugins && dnf clean all
RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
#RUN rm -rf /root/.gnupg && dnf group install -y core && dnf clean all
#RUN dnf group install -y core && dnf clean all
#RUN dnf group install -y base-graphical && dnf clean all
RUN dnf install -y langpacks-en firewalld openssh tailscale git curl wget rsync gnome-shell ptyxis nautilus xdg-user-dirs xdg-user-dirs-gtk flatpak bash-completion tar bzip2
RUN systemctl enable firewalld.service sshd.service tailscaled.service
RUN systemctl enable gdm
RUN systemctl set-default graphical.target
RUN systemctl mask remount-fs.service
RUN dnf autoremove -y
RUN dnf clean all
RUN rpm-ostree cleanup -m 
RUN ostree container commit 
RUN bootc container lint  
RUN rpm -qa | sort
RUN jq -r .packages[] /usr/share/rpm-ostree/treefile.json
























FROM quay.io/fedora/fedora-bootc:latest AS base-bootc
RUN echo "Starting" \
 && rpm -qa | sort \
 && dnf install -y dnf5-plugins langpacks-en firewalld openssh tailscale git curl wget rsync \
 && systemctl enable firewalld.service sshd.service tailscaled.service \
 && dnf clean all \
 && rpm-ostree cleanup -m \
 && ostree container commit \
 && bootc container lint \
 && echo "Finished" 

FROM base-bootc AS desktop-bootc
RUN uname -r \
 && rpm -qa | sort \
 && dnf install -y flatpak gdm gnome-shell nautilus ptyxis adw-gtk3-theme cups hplip \
 && systemctl set-default graphical.target \
 && git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/ \
 && dnf clean all \
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
 && rpm-ostree cleanup -m \
 && ostree container commit && bootc container lint

FROM quay.io/fedora/fedora-silverblue:latest AS base-silverblue
FROM base-silverblue AS desktop-silverblue
FROM base-silverblue AS server-silverblue

FROM quay.io/fedora-ostree-desktops/base-atomic:42 AS base-fedora-ostree-desktops
FROM base-fedora-ostree-desktops AS desktop-fedora-ostree-desktops
FROM base-fedora-ostree-desktops AS server-fedora-ostree-desktops



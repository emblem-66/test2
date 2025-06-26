FROM quay.io/fedora/fedora-silverblue:latest AS base
RUN \
# Repo cleanup
 && rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo \
 && rm -rf /etc/yum.repos.d/fedora-cisco-openh264.repo \
 && rm -rf /etc/yum.repos.d/google-chrome.repo \
 && rm -rf /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo \
 && rm -rf /etc/yum.repos.d/rpmfusion-nonfree-steam.repo \
# DNF auto updates
 && sed -i 's/#AutomaticUpdatePolicy=none/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf \
 && dnf -y install tailscale \
 && systemctl enable tailscaled \
# Debloat
 && dnf -y remove firefox* gnome-shell-extension* gnome-tour yelp* gnome-software-rpm-ostree virtualbox-guest-additions malcontent-control fedora-chromium-config* \
# Cleanup
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Workstation variant
FROM base AS silverblue
RUN dnf -y install adw-gtk3-theme \
# Flatpak setup
 && echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Silverblue/refs/heads/main/flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat /var/home/$(whoami)/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service \
 && echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer \
# Morewaita Icons
 && git clone https://github.com/somepaulo/MoreWaita.git /usr/share/icons/MoreWaita/ \
# Cleanup
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

# Server variant
FROM base AS serverblue
RUN dnf -y install smartmontools libvirt cockpit cockpit-machines cockpit-podman cockpit-files cockpit-navigator cockpit-selinux \
 && systemctl enable cockpit.socket || true \
# Cleanup
 && dnf clean all \
 && rm -rf /tmp/* /var/* \
 && rpm-ostree cleanup -m \
 && ostree container commit
RUN bootc container lint

#!/bin/bash

dnf_in() {
dnf install -y "$@"
dnf clean all
}

dnf_in_() {
dnf install -y --nogpgcheck "$@"
dnf clean all
}

dnf_rm() {
dnf remove -y "$@"
dnf autoremove
dnf clean all
}

systemd_enable() {
systemctl enable "$@"
}

systemd_disable() {
systemctl disable "$@"
}

flatpak() {
echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/packages | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat ~/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer
systemctl enable flatpak-update.timer
}

gnome() {
sudo dnf install -y --nogpgcheck --setopt=install_weak_deps=False \

}

sound() {
sudo dnf install -y --nogpgcheck \
pipewire pipewire-pulseaudio wireplumber alsa-lib alsa-ucm
}

network() {

}

printing() {

}

containers() {

}


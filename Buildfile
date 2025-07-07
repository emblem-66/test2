#!/bin/bash

# Functions
f_dnf-in () {
dnf install -y "$@"
dnf clean all
}

f_dnf-in () {
dnf install -y --nogpgcheck "$@"
dnf clean all
}

f_dnf-rm () {
dnf remove -y "$@"
dnf autoremove
dnf clean all
}

f_systemd-enable () {
systemctl enable "$@"
}

f_systemd-disable () {
systemctl disable "$@"
}

f_flatpak () {
echo -e "[Unit]\nDescription=Update Flatpaks\n[Service]\nType=oneshot\nExecStart=/usr/bin/flatpak remote-modify --disable fedora ; /usr/bin/flatpak remote-modify --enable flathub ; /usr/bin/flatpak uninstall --unused -y --noninteractive ; /usr/bin/bash -c 'curl -sSL https://raw.githubusercontent.com/emblem-66/Linux-Stuff/refs/heads/main/flatpak/packages | xargs -r flatpak install -y --noninteractive' ; /usr/bin/bash -c 'cat ~/.flatpak-apps.list | xargs -r flatpak install -y --noninteractive' ; /usr/bin/flatpak update -y --noninteractive\n[Install]\nWantedBy=default.target\n" | tee /etc/systemd/system/flatpak-update.service
echo -e "[Unit]\nDescription=Update Flatpaks\n[Timer]\nOnCalendar=*:0/4\nPersistent=true\n[Install]\nWantedBy=timers.target\n" | tee /etc/systemd/system/flatpak-update.timer
systemctl enable flatpak-update.timer
}

f_gnome () {
sudo dnf install -y --nogpgcheck --setopt=install_weak_deps=False \

}

f_sound () {
sudo dnf install -y --nogpgcheck \
pipewire pipewire-pulseaudio wireplumber alsa-lib alsa-ucm
}

f_network () {

}

f_printing () {
f_dnf-inf cups system-config-printer
}

f_containers () {

}

# Call function from argument
for arg in "$@"; do
  case "$arg" in
    --gnome)
      f_gnome
      ;;
    --sound)
      f_sound
      ;;
    --printing)
      f_printing
      ;;
    *)
      echo "Unknown bundle: $arg"
      exit 1
      ;;
  esac
done

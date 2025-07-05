#!/usr/bin/env bash

install_packages() {
  sudo dnf install -y --nogpgcheck "$@"
}

install_packages() {
  sudo dnf install -y --nogpgcheck "$@"
}

remove_packages() {
  sudo dnf remove -y "$@"
}

enable_service() {
  sudo systemctl enable "$@"
}

disable_service() {
  sudo systemctl disable "$@"
}

gnome() {
sudo dnf install -y --nogpgcheck --setopt=install_weak_deps=False \
pipewire pipewire-pulseaudio wireplumber alsa-lib alsa-ucm
}

sound() {
sudo dnf install -y --nogpgcheck \
pipewire pipewire-pulseaudio wireplumber alsa-lib alsa-ucm
}

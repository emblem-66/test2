# test2

[![test2](https://github.com/emblem-66/test2/actions/workflows/main.yml/badge.svg)](https://github.com/emblem-66/test2/actions/workflows/main.yml)

## Images

**Prerequisites**

- installation of Fedora Atomic (Silverblue) with user/first run set up

## Base

From official fedora-bootc image with added stuff

- system autoupdates
- tailscale
- ssh
- firewalld
- cockpit base

```
FROM ghcr.io/emblem-66/test2:base
```

```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/emblem-66/test2:base
```

```
sudo bootc switch ghcr.io/emblem-66/test2:base
```

## Desktop

- GNOME desktop
- flatpak
  - flatpak autoupdate
  - flatpak app autoinstall

```
FROM ghcr.io/emblem-66/test2:desktop
```

```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/emblem-66/test2:desktop
```

```
sudo bootc switch ghcr.io/emblem-66/test2:desktop
```

## Server

- headless management
- cockpit extra
- virtual machines
- podman
- docker?

```
FROM ghcr.io/emblem-66/test2:server
```

```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/emblem-66/test2:server
```

```
sudo bootc switch ghcr.io/emblem-66/test2:server
```

# test2

[![test2](https://github.com/emblem-66/test2/actions/workflows/main.yml/badge.svg)](https://github.com/emblem-66/test2/actions/workflows/main.yml)

## Images


### Base

```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/emblem-66/test2:base
```

```
sudo bootc switch ghcr.io/emblem-66/test2:base
```


Common changes for Silverblue and Serverblue

- system autoupdates
- tailscale
- ssh

### Silverblue

```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/emblem-66/test2:silverblue
```

```
sudo bootc switch ghcr.io/emblem-66/test2:silverblue
```


- GNOME desktop
- flatpak
  - flatpak autoupdate
  - flatpak app autoinstall

### Serverblue

```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/emblem-66/test2:serverblue
```

```
sudo bootc switch ghcr.io/emblem-66/test2:serverblue
```


- headless management

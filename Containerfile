#RUN curl -s https://raw.githubusercontent.com/Emblem-66/test2/refs/heads/main/Buildfile | bash \
# && dnf clean all \
# && rm -rf /tmp/* /var/* \
# && rpm-ostree cleanup -m \
# && ostree container commit
#RUN bootc container lint

#dnf clean all
#rm -rf /tmp/* /var/*
#rpm-ostree cleanup -m
#ostree container commit

FROM quay.io/fedora/fedora-bootc:latest AS base-bootc
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
EOF
RUN ostree container commit && bootc container lint

FROM base-bootc AS desktop-bootc
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOF
RUN bootc container lint

FROM base-bootc AS server-bootc
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOFRUN bootc container lint



FROM quay.io/fedora/fedora-silverblue:latest AS base-silverblue
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOFRUN bootc container lint

FROM base-silverblue AS desktop-silverblue
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOFRUN bootc container lint

FROM base-silverblue AS server-silverblue
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOFRUN bootc container lint



FROM quay.io/fedora-ostree-desktops/base-atomic:42 AS base-fedora-ostree-desktops
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOFRUN bootc container lint

FROM base-fedora-ostree-desktops AS desktop-fedora-ostree-desktops
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOFRUN bootc container lint

FROM base-fedora-ostree-desktops AS server-fedora-ostree-desktops
RUN bash <<EOF
rpm -qa | sort
dnf clean all
rm -rf /tmp/* /var/*
rpm-ostree cleanup -m
ostree container commit
EOFRUN bootc container lint



FROM docker.io/archlinux:latest AS base-arch
FROM base-arch AS desktop-arch
FROM base-arch AS server-arch



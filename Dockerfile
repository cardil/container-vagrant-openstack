FROM docker.io/library/fedora:31

RUN dnf install -y \
    vagrant \
    vagrant-openstack-provider \
    ansible \
    openssh-clients \
    rsync \
    git \
    && dnf clean all
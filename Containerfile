FROM quay.io/fedora/fedora:37

RUN dnf install -y \
    vagrant \
    vagrant-openstack-provider \
    ansible \
    openssh-clients \
    rsync \
    git \
    && dnf clean all

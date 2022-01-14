FROM registry.fedoraproject.org/fedora:35

RUN dnf install -y \
    vagrant \
    vagrant-openstack-provider \
    ansible \
    openssh-clients \
    rsync \
    git \
    && dnf clean all

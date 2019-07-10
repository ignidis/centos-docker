FROM library/centos:7

ENV TERMTAG CentOS7Base
ENV container docker

#
# ADD REQUIRED APP FILES
#
# Import keys
#
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7; \
    rpm --import http://download.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7; \
#
# Install required packages
#
    yum -y --setopt=tsflags=nodocs install epel-release;

RUN (cd /lib/systemd/system/sysinit.target.wants/; \
    for i in *; \
        do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;\
#
#
# Update OS
#
    yum update --setopt=tsflags=nodocs -y && yum clean all -y;\
#
#
# Clean yum cache and logs
#
    rm -f /etc/yum.repos.d/*.rpm; \
#
# Rebuild the RPM Database
#
    rm -f /var/lib/rpm/__db*; \
    rpm --rebuilddb; \
#
    rm -rf /var/cache/*;\
    rm -rf /var/temp;\
    rm -f /var/log/*;

#
# 
#

#
# Remove locales other than english, it's a container ...
#
RUN for x in `ls /usr/share/locale | grep -v -i en | grep -v -i local`;do rm -fr /usr/share/locale/$x; done && \
    for x in `ls /usr/share/i18n/locales/ | grep -v en_`; do rm -fr /usr/share/i18n/locales/$x; done && \
    rm -fr /usr/share/locale/ca* /usr/share/locale/den /usr/share/locale/men /usr/share/locale/wen /usr/share/locale/zen && \
    cd /usr/lib/locale && \
    localedef --list-archive | grep -v -i ^en | xargs localedef --delete-from-archive && \
    mv -f locale-archive locale-archive.tmpl && \
    build-locale-archive

#
# Set the default Timezone to UTC, if you need another read-only mount from host
#
RUN rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/UTC /etc/localtime

# Remove docs, again it's a container
RUN rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/groff/* /usr/share/info/* /var/cache/man/*

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/bin/bash"]

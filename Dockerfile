FROM centos:8

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \

systemd-tmpfiles-setup.service ] || rm -f $i; done); \

rm -f /lib/systemd/system/multi-user.target.wants/*;\

rm -f /etc/systemd/system/*.wants/*;\

rm -f /lib/systemd/system/local-fs.target.wants/*; \

rm -f /lib/systemd/system/sockets.target.wants/*udev*; \

rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \

rm -f /lib/systemd/system/basic.target.wants/*;\

rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]



# Install Apache

RUN cd /etc/yum.repos.d/



RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*



RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*


RUN yum -y install java

CMD /bin/bash

RUN yum -y install httpd httpd-tools

RUN yum -y install openssh-server

RUN yum -y install passwd

RUN yum -y install which

RUN yum clean all


# Update Apache Configuration

# RUN sed -E -i -e '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf

# RUN sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf

EXPOSE 80

EXPOSE 22

WORKDIR /var/www/html/

COPY . .

RUN systemctl enable httpd.service
RUN systemctl enable sshd

FROM centos:7



RUN yum update -y



CMD /bin/bash



RUN yum -y install httpd httpd-tools



RUN yum clean all



WORKDIR /var/www/html/



COPY . .



EXPOSE 80



RUN systemctl enable httpd.service



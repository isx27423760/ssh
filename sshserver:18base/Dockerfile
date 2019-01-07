# Version: 0.0.1
# @edt M06 2018- 2019
#hostpam
#------------------------------------------
FROM fedora:27
LABEL author="@edt ASIX m06-ASO"
LABEL description="hostpam sshd  2018 2019"
RUN dnf -y install procps vim passwd openldap-clients nss-pam-ldapd authconfig pam_mount openssh-server nmap 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
EXPOSE 1022
CMD ["/opt/docker/startup.sh"]

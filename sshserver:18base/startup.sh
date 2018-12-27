#! /bin/bash
# @edt ASIX M06 2018-2019
# startup.sh hostpam
#--------------------------------------

/opt/docker/install.sh && echo "Install OK"
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
/usr/sbin/sshd && echo "sshd OK"
/bin/bash

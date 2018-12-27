# PAM
## @edt ASIX M06-ASO Curs 2018-2019

Repositori d'exemples de containers docker que utilitzen PAM i sshd

 * **sshserver:18base** host pam amb authenticació ldap. utilitza l'ordre authconfig per
configurar l'autenticació i utilitza el servei sshd per autenticar usuaris locals y ldap.

#### Execució

```
docker run -p 1022:1022 --privileged --rm --name sshd -h sshd --net ldapnet -it sshserver:18base

```

#### Utilització

```
getnet passwd local01
getent passwd pau
getent passwd

getent group localgrp01
getent group [alumnes, profes]
getent group

#ssh local01@lcoalhost
#ssh pere@localhost

```




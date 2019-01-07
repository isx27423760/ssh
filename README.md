# SSH
## @edt ASIX M06-ASO Curs 2018-2019 Franlin C.

ASIX M06-ASO EDT

* **sshserver:18base** ssh server amb authenticació ldap. Crea els homes de l'usuari ldap i locals.
Tambe permet inciar sessions remotes de users locals i usuaris ldap, el servidor ssh escoltara pel port 1022.

* **ldapserver:18group** conte els usuaris ldap del la base de dades *edt.org* .

#### Execució 

```
docker run --rm --name ldap -h ldap --net ldapnet -d ldapserver:18group

docker run -p 1022:1022 --privileged --rm --name sshd -h sshd --net ldapnet -it sshserver:18base

```


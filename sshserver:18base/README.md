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

#### Configuracions

cal instalar el servei ssh : openssh-server.

Tambe cal configurar el sshd de pam per que els homes dels usuaris ldap se monten.

```
session     sufficient    pam_mkhomedir.so
```

1. Configuracio de tipus ** AllowUsers **.

    Editem el ficher ** /etc/ssh/ssh_config ** on a final de linea afegim la restriccio als usuaris.

    ```
    AllowUsers pere pau marta jordi local01 local02
    ```

    I de pas posem el port 1022 en comptes del per defecte 22, nomes cal decomentar la linea **Port** :
    
	```
	Port 1022
	```


2. Configuració de ** pam_access.so **.

    Editem el seguent ficher ** /etc/pam.d/sshd **, afegim la seguent linea :

    ```
    account    required     pam_access.so accessfile=/etc/security/access-sshd.conf

    ```

    El ficher ** access-sshd.conf **: Posem la restriccio d'un usuari .

    Exemple:

    ```
    - : pere : ALL
    
    ```

3. Per ultim fem la restricció d'acces a un usuaria amb **pam_listfile.so.**
	
	Editem el seguent ficher ** /etc/pam.d/sshd **, afegim la seguent linea :
    
    ```
    auth       required     pam_listfile.so item=user sense=deny file=/opt/docker/sshd.deny onerr=succeed

    ```

    El ficher ** sshd.deny **: Posem la restriccio d'un usuari ldap .

    Exemple:

    ```
    marta
    
    ```

4. Comprovació

	```
	[root@sshd docker]# ssh pau@localhost -p 1022
	pau@localhost's password: 
	Creating directory '/tmp/home/pau'.
	[pau@sshd ~]$ pwd
	/tmp/home/pau
	[pau@sshd ~]$ 

	```
	
	```
	[root@sshd docker]# ssh pere@localhost -p 1022
	pere@localhost's password: 
	Connection closed by ::1 port 22

	```

	```
	[root@sshd docker]# ssh marta@localhost -p 1022
	marta@localhost's password: 
	Permission denied, please try again.
	marta@localhost's password: 
	Permission denied, please try again.
	marta@localhost's password: 
	marta@localhost: Permission denied (publickey,gssapi-keyex,gssapi-with-mic,password).
	```

	Si volem comprovar de un host diferent al servidor ,engegem un container de hostpam que tenim:
	
	```
 	$docker run --privileged --rm --name host -h host --net ldapnet -it hostpam:18auth
	
	Orden para provar : # ssh user@ipservidor -p numPort
	```
	
	```
	[root@host docker]# ssh pere@172.18.0.3 -p 1022

	[root@host docker]# ssh marta@172.18.0.3 -p 1022

	[root@host docker]# ssh pau@172.18.0.3 -p 1022
	pau@172.18.0.3's password: 
	Last login: Fri Jan 11 08:33:24 2019 from 172.18.0.1
	[pau@sshd ~]$ pwd
	/tmp/home/pau

	```


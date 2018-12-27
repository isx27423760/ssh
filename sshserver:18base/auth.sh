#! /bin/bash
# @edt ASIX-M06
#descripcio: scipt per generar automaticament la connexio amb usaris del servidor ldap
# ---------------------------------------------------------------------------------
authconfig  --enableshadow --enablelocauthorize --enableldap  --ldapserver='ldap' --ldapbase='dc=edt,dc=org' --enableldapauth  --updateall


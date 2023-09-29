#!/bin/bash

########################################################################
# Script: rootkey.sh
# Descripcion: Configurar la clave del usuario root
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V0.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
#source /home/pi/MiSimple/sistema/funciones.sh
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
###################################################
# OBTENER LA VARIABLE CONTRASEÑA ROOT (OK)
###################################################
# . variables.sh
. /SHConfig/db/variables.txt

rootkey.sh(){
clear  

rootkey=$(echo "$rootkey" | openssl enc -d -des3 -base64 -pass pass:Descifrando -pbkdf2)

echo -ne "-------------------------------------
CAMBIANDO LA CLAVE DEL USUARIO ROOT     
-------------------------------------
El clave del usuario root que elegiste es [$rootkey] :

Escribe otra si quieres cambiarla.
Despues pulsa [ENTER]: [$rootkey]  "    

read -s new_password
new_password="${new_password:-$rootkey}"

if [ -z "$new_password" ]
then
    conf_pass=false
else
    conf_pass=true
fi

if [ "$conf_pass" = true ]; then
clear
echo -n "-------------------------------------
CAMBIANDO LA CLAVE DEL USUARIO ROOT      
-------------------------------------"
echo " "
#echo "root:$new_password" | sudo chpasswd

echo -ne '##########                    (33%)\r'
sleep 1
echo -ne '####################          (66%)\r'
sleep 1
echo -ne '############################# (100%)\r'
sleep 1
echo -ne '\n'

echo -n "-------------------------------------
AUTORIZANDO AL USUARIO ROOT      
-------------------------------------"
echo " "
#modifica el archivo /etc/ssh/sshd_config
#sudo sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
sleep 3
#reinicia servicio ssh
#sudo service ssh restart

echo -ne '##########                    (33%)\r'
sleep 1
echo -ne '####################          (66%)\r'
sleep 1
echo -ne '############################# (100%)\r'
sleep 1
echo -ne '\n'
clear
echo -n "-------------------------------------
CLAVE CAMBIADA Y ROOT AUTORIZADO       
-------------------------------------"
sleep 3

1

else

clear
echo -n "-------------------------------------
    NO SE HAN REALIZADO CAMBIOS       
-------------------------------------"
sleep 3

fi
clear;
}


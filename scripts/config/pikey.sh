#!/bin/bash

########################################################################
# Script: pikey.sh
# Descripcion: Configurar la clave del usuario Pi
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
# OBTENER LA VARIABLE CONTRASEÑA PI (OK)
###################################################
# . variables.sh
. /SHConfig/db/variables.txt

pikey.sh(){
clear  

userpi=$(echo $pikey | openssl enc -d -des3 -base64 -pass pass:Descifrando -pbkdf2)

echo $userpi

echo -ne "-------------------------------------
CAMBIANDO LA CLAVE DEL USUARIO PI      
-------------------------------------
El clave del usuario pi que elegiste es [$userpi] :

Escribe otra si quieres cambiarla.
Despues pulsa [ENTER]: [$userpi]  "    

read -s new_password
new_password="${new_password:-$userpi}"

if [ -z "$new_password" ]
then
    conf_pass=false
else
    conf_pass=true
fi


if [ "$conf_pass" = true ]; then
clear
        
echo -n "-------------------------------------
CAMBIANDO LA CLAVE DEL USUARIO PI      
-------------------------------------"
echo " "
echo "pi:$new_password" | sudo chpasswd

echo -ne '##########                    (33%)\r'
sleep 1
echo -ne '####################          (66%)\r'
sleep 1
echo -ne '############################# (100%)\r'
sleep 1
echo -ne '\n'

clear
echo -n "-------------------------------------
CLAVE CAMBIADA       
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


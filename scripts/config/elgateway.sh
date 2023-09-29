#!/bin/bash

########################################################################
# Script: elgateway
# Descripcion: Configurar el gateway de la Raspberry
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
. /SHConfig/db/variables.txt
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
#hostname="$(cat /etc/hostname)"
#addrs=( $(arp -ni eth0 | grep -o '^[0-9][^ ]*') )
#default_ip="192.168.1.105"
#default_gtw="192.168.1.1"
#default_nmsrv="8.8.8.8"
#default="Si"
#default_ssid="nombre-de-tu-wifi"
#default_psk="password-de-tu-wifi"
#default_key="WPA-PSK"
# WPA/WPA2 TKIP/AES
#ip=192.168.1.105
#mask=255.255.255.0
###################################################
# OBTENER LA VARIABLE CONTRASEÑA PI (OK)
###################################################
hostname="$(cat /etc/hostname)"
# . variables.sh


elgateway.sh(){
###################################################
#          OBTENER LA VARIABLE GATEWAY            #
###################################################
echo -ne "-------------------------------------
ASIGNAR UNA PUERTA DE ACCESO    
-------------------------------------
La Puerta de acceso que has elegido es [$default_gtw] :

Escribe otra si quieres cambiarla.
Despues pulsa [ENTER]: [$default_gtw]  " 

read -s gateway
gateway="${gateway:=$default_gtw}"

sleep 3

if [ -z "$gateway" ]
then
    conf_gate=false
else
    conf_gate=true
fi

if [ "$conf_gate" = true ]; then
clear


echo -n "-------------------------------------
CONFIGURANDO EL GATEWAY     
-------------------------------------"
echo " " 

sudo echo "static routers=$gateway" >> /etc/dhcpcd.conf
#

echo -ne '##########                    (33%)\r'
sleep 1
echo -ne '####################          (66%)\r'
sleep 1
echo -ne '############################# (100%)\r'
sleep 1
echo -ne '\n'

clear
echo -n "-------------------------------------
RED CONFIGURADA       
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
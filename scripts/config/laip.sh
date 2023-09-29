#!/bin/bash

########################################################################
# Script: laip.sh
# Descripcion: Configurar IP fija de la Raspberry
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
#hostname="$(cat /etc/hostname)"
# . variables.sh
. /SHConfig/db/variables.txt

laip.sh(){

###################################################
#            OBTENER LA VARIABLE IP               #
###################################################
clear
echo -ne "-------------------------------------
ASIGNAR UNA IP FIJA     
-------------------------------------
La IP que has elegido es [$default_ip] :

Escribe otra si quieres cambiarla.
Despues pulsa [ENTER]: [$default_ip]  " 

read -s ipadress
ip_address="${ipadress:=$default_ip}"

sleep 3

if [ -z "$ipadress" ]
then
    conf_ip=false
else
    conf_ip=true
fi

if [ "$conf_ip" = true ]; then
clear

echo -n "-------------------------------------
CONFIGURANDO LA IP     
-------------------------------------"
echo " " 

sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/dhcpcd.conf
sudo echo "interface eth0" >> /etc/dhcpcd.conf
sudo echo "static ip_address=$ipadress/24" >> /etc/dhcpcd.conf
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


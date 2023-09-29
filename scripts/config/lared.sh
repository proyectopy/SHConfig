#!/bin/bash

########################################################################
# Script: la red.sh
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
#hostname="$(cat /etc/hostname)"
#. variables.sh
. /SHConfig/db/variables.txt

lared.sh(){

###################################################
#              CONFIGURAR EL HOSTNAME             #
###################################################

clear
echo -ne "-------------------------------------
CAMBIAR EL NOMBRE DE HOST      
-------------------------------------
El nuevo hostname elegido es [$new_hostname]

Escribe otro si quieres cambiarla.
Despues pulsa [ENTER] [$new_hostname]:  "    

read -s nuevohost
nuevohost="${nuevohost:-$new_hostname}"

if [ -z "$nuevohost" ]
then
    conf_hostname=false
else
    conf_hostname=true
fi

if [ "$conf_hostname" = true ]; then
clear

echo -n "-------------------------------------
CAMBIANDO EL NOMBRE DE HOST      
-------------------------------------"
echo " "    
sudo cp /etc/hosts /etc/hosts.old
sudo sed -i "s/$hostname/$nuevohost/g" /etc/hosts    

sudo cp /etc/hostname /etc/hostname.old
sudo sed -i "s/$hostname/$nuevohost/g" /etc/hostname

echo -ne '##########                    (33%)\r'
sleep 1
echo -ne '####################          (66%)\r'
sleep 1
echo -ne '############################# (100%)\r'
sleep 1
echo -ne '\n'
clear
echo -n "-------------------------------------
NOMBRE DE HOST CAMBIADO      
-------------------------------------"
sleep 3

#1

else

clear
echo -n "-------------------------------------
    NO SE HAN REALIZADO CAMBIOS       
-------------------------------------"
sleep 3

fi

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

read ipadress : ${ipadress:=$default_ip}

sleep 3

if [ -z "$ipadress" ]
then
    conf_ip=false
else
    conf_ip=true
fi

if [ "$conf_ip" = true ]; then
clear

###################################################
#          OBTENER LA VARIABLE GATEWAY            #
###################################################
echo -ne "-------------------------------------
ASIGNAR UNA PUERTA DE ACCESO    
-------------------------------------
La Puerta de acceso que has elegido es [$default_gtw] :

Escribe otra si quieres cambiarla.
Despues pulsa [ENTER]: [$default_gtw]  " 

read gateway: ${gateway:=$default_gtw}

sleep 3

if [ -z "$gateway" ]
then
    conf_gate=false
else
    conf_gate=true
fi

if [ "$conf_gate" = true ]; then
clear

###################################################
#          OBTENER LA VARIABLE NAMESERVER         #
###################################################
echo -ne "-------------------------------------
ASIGNAR SERVIDORES DE NOMBRES    
-------------------------------------
El nameserver que has elegido es [$default_nmdrv] :

Escribe otro si quieres cambiarlo.
Despues pulsa [ENTER]: [$default_nmsrv]  " 

read nameservers : ${nameservers:=$default_nmsrv}

sleep 3

if [ -z "$nameservers" ]
then
    conf_nmsrv=false
else
    conf_nmsrv=true
fi

if [ "$conf_nmsrv" = true ]; then
clear

echo -n "-------------------------------------
CONFIGURANDO LA RED      
-------------------------------------"
echo " " 

sudo echo "# Añadido por el script de Configuracion Inicial" >> /etc/dhcpcd.conf
sudo echo "interface eth0" >> /etc/dhcpcd.conf
sudo echo "static ip_address=$ipadress/24" >> /etc/dhcpcd.conf
sudo echo "static routers=$gateway" >> /etc/dhcpcd.conf
sudo echo "static domain_name_servers=$gateway $nameservers" >> /etc/dhcpcd.conf
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


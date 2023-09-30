#!/bin/bash

########################################################################
# Script: expandir.sh
# Descripcion: Expandir toda la capacidad de la SD/HDD de la Raspberry
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V0.1.2
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
#source /home/pi/MiSimple/scripts/funciones
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
default="Si"
###################################################
# OBTENER LA VARIABLE CONTRASEÑA PI (OK)
###################################################

expandir.sh(){

clear
echo -ne "-------------------------------------
EXPANDIR EL DISCO/TARJETA 
-------------------------------------"
echo " "

echo -ne " Quieres expandir el sistema de archivos (Recomendado) y pulsa [ENTER]: [$default] "
read ex
ex="${ex:-$default}"

echo ""
echo -ne " Has elegido que $ex quieres expandir el sistema de archivos"
sleep 3
    

if [ $ex != $default ]
then
conf_expand=false
#   conf_expand
else
conf_expand=true
# echo "$conf_network"
sleep 3
#conf_expand
fi

if [ "$conf_expand" = true ]; 
then 
clear
echo -ne "-------------------------------------
EXPANDIENDO EL SISTEMA DE ARCHIVOS 
-------------------------------------"
echo " "

#Ejecuta el resize de la sd de la Raspberry
sudo raspi-config --expand-rootfs &>/dev/null

clear
echo -ne "---------------------------------------------
SISTEMA DE ARCHIVOS OCUPA EL 100% DEL DISCO 
---------------------------------------------"
echo " "
echo -ne "---------------------------------------------
NO TIENE EFECTO HASTA QUE REINICIES 
---------------------------------------------"
echo " "
sleep 3
clear

else
clear
echo -ne "-------------------------------------
SIN CAMBIOS
-------------------------------------"
echo " "
sleep 3

fi  
}


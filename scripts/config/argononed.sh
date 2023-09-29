#!/bin/bash

########################################################################
# Script: ereader.sh
# Descripcion: Instalar eReader ubooquity
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V0
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
. /SHConfig/db/variables.txt
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
#hostname="$(cat /etc/hostname)"
#export PATH_UBOOQUITY="/opt/ubooquity"
#export ja="default-jdk"
#export un="unzip"
argononed="true"
default="Si"
#export eReader="@reboot sleep 180 && cd $PATH_UBOOQUITY && nohup /usr/bin/java -jar $PATH_UBOOQUITY/Ubooquity.jar /opt/ubooquity/Ubooquity.jar --remoteadmin --headless"

#######################################################################
#  COMPROBAR INSTALACION DEL EREADER
########################################################################

argononed.sh() {
if [ -d /etc/systemd/system/argononed.service ];
then
clear
echo -ne "
-----------------------------------------
ARGONONED YA ESTA INSTALADO EN SU SISTEMA
-----------------------------------------"

else

clear

echo -ne "-------------------------------------
INSTALAR ARGONONE EN EL SISTEMA
-------------------------------------"
echo " "
echo -ne "Tienes la caja Argon ONE V2 pulsa [ENTER]: [$default] "
read ex
ex="${ex:-$default}"

if [ "$ex" = $default ]; then  
echo -ne "Quieres instalar argononed para gestionar el 
ventilador de tu Argon ONE V2 pulsa [ENTER]: [$default] "
read resp
resp="${resp:-$default}"

echo -ne "
-----------------------------------------
ESTAMOS INSTALANDO ARGONONED. ESPERE...
-----------------------------------------"

cd /home/pi/
git clone https://gitlab.com/DarkElvenAngel/argononed.git &>/dev/null
sleep 3
cd /home/pi/argononed
mv * /argonone
sudo rm -r /home/pi/argononed
cd /argonone;
./install 

echo -ne "
-------------------------------------
INSTALADO ARGONONED EN SU SISTEMA
-------------------------------------"    
sleep 3

fi

else
echo ""
echo -ne " Borraremos el directorio /argonone creado anteriormente"
sudo rm -d /argonone

sleep 3


#if dpkg-query -W -f'${db:Status-Abbrev}\n' git 2>/dev/null \ | grep -q '^.i $';
#then
#clear
#
#echo -ne "
#-----------------------------------------
#GIT ESTA INSTALADO EN SU SISTEMA
#-----------------------------------------"
#sleep 3 
##install_argon
##sleep 10
#else
#clear
#echo -ne "
#-----------------------------------------
#INSTALANDO GIT EN SU SISTEMA
#-----------------------------------------"
#
#sudo apt-get install git -y &>/dev/null
#
#echo -ne "
#-----------------------------------------
#INSTALADO CORRECTAMENTE GIT EN SU SISTEMA
#-----------------------------------------"
#
#sleep 3 
#install_argon
fi




#sudo cd /home/pi/


}  

  
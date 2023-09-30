#!/bin/bash

########################################################################
# Script: upgrade.sh
# Descripcion: Funcion para la actualizar el sistema de la raspberry
# Argumentoss: N/A
# Creacion/Actualizacion: DIC2021/SEPT2023
# Version: V1.1.1
# Author: Wildsouth
# Email: wildsout@gmail.com
########################################################################
########################################################################
########################################################################
# SCRIPS NECESARIOS
########################################################################
########################################################################
########################################################################
# VARIABLES USADAS EN ESTE SCRIPT
########################################################################
. SHConfig/db/variables.txt
# TEXTO DEL CRONTAB
updater="00 15 * * * /bin/bash /SHConfig/.act/updater"
########################################################################
# FUNCION ACTUALIZAR REVISADO (OK)
########################################################################

upgrade.sh(){
clear

if [ -d "$r_act" ]
then
clear
echo -ne "-------------------------------------
EL SISTEMA YA ESTA ACTUALIZADO     
-------------------------------------"
echo " "
sleep 3
else
install_sendmail
sleep 4
fi
}


install_sendmail() {
if dpkg-query -W -f'${db:Status-Abbrev}\n' ssmtp 2>/dev/null \ | grep -q '^.i $';
then
echo -ne "-------------------------------------
SENDMAIL YA ESTA INSTALADO    
-------------------------------------"
echo " "
existe
else
echo -ne "-------------------------------------
INSTALAR SENDMAIL Y MAILUTILS   
-------------------------------------"
echo " "
sudo rm /var/lib/dpkg/lock-frontend &>/dev/null
sudo dpkg --configure -a &>/dev/null
sudo apt-get -y install ssmtp &>/dev/null
sudo apt-get -y install mailutils &>/dev/null

echo -ne "-------------------------------------
CONFIGURANDO ...  
-------------------------------------"
echo " "

#Copia de seguridad del archivo de configuracion

sudo chown pi:pi /etc/ssmtp/ssmtp.conf
sudo chmod 777 /etc/ssmtp/ssmtp.conf
sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.orig

sleep 3

#Escribe el archivo updater

sudo echo '########################################################################' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null
sudo echo '# AÑADIDO POR EL SCRIPT DE CONFIGURACION' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null
sudo echo '########################################################################' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null
sudo echo 'AuthUser=proyectopy@gmx.es' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null
sudo echo 'AuthPass=L4cl4v3degmx.3s' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null
sudo echo 'FromLineOverride=YES' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null
sudo echo 'mailhub=mail.gmx.es:587' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null
sudo echo 'UseSTARTTLS=YES' | sudo tee --append /etc/ssmtp/ssmtp.conf &>/dev/null


sudo chown root:root /etc/ssmtp/ssmtp.conf
sudo chown root:root /etc/ssmtp/ssmtp.conf.orig

sudo chmod 777 /etc/ssmtp/ssmtp.conf
sudo chmod 777 /etc/ssmtp/ssmtp.conf.orig

echo -ne "-------------------------------------
CONFIGURADO  
-------------------------------------"
echo " "
existe
fi
}
function existe() {
actualizar=true
    
	
if [ "$actualizar" = true ]; 
then
            
clear

echo -ne "-------------------------------------
AUTOMATIZANDO LA CONFIGURACION 
-------------------------------------"
echo " "
sudo mkdir -p /$r_act
sudo chown pi:pi /$r_act
sudo mkdir -p /$r_act.logs/
sudo chown pi:pi /$r_act.logs/

echo -ne "-------------------------------------
CREANDO EL SCRIPT UPDATER 
-------------------------------------"
echo " "
sudo touch updater
sudo chown pi:pi updater

sudo chmod +x updater
#Escribe el archivo updater
sudo echo "#!/bin/bash" >> updater
sudo echo "########################################################################" >> updater
sudo echo "# SCRIPS NECESARIOS" >> updater
sudo echo "########################################################################" >> updater
sudo echo "#. SHConfig/db/variables.txt" >> updater
sudo echo "########################################################################" >> updater
sudo echo "# Script: updater                                                    " >> updater
sudo echo "# Descripcion: Configuracion del cron para actualizaciones    "  >> updater
sudo echo "########################################################################" >> updater
sudo echo "#" >> updater
sudo echo "act=\`date +%d%m%Y\`" >> updater
sudo echo "dt=\`date +'%A, %d del %m de %Y a las %H:%M ' \` " >> updater
sudo echo "#" >> updater
sudo echo "sudo apt-get update >/dev/null >> $r_act/.logs/update.log" >> updater
sudo echo "sudo apt-get upgrade >/dev/null -y >> $r_act/.logs/upgrade.log" >> updater
sudo echo "sudo apt-get autoremove >/dev/null -y >> $r_act.logs/autoremove.log" >> updater
sudo echo "sudo rpi-update -y >> /$r_act/.logs/rpi-update.log" >> updater
sudo echo "#" >> updater
sudo echo "echo Script ejecutado el \$dt >> /$r_act/.logs/ejecuciones_\$act.log ">> updater

sudo echo "sudo sendmail -t < /SHConfig/mail_templates/update.html">> updater

sudo echo "echo Hemos enviado un emal el \$dt >> $r_act/.logs/emails_\$act.log ">> updater

#Situa en su directorio definitivo el archivo updater
sudo mv updater $r_act

#crea el crontab
(crontab -u pi -l; echo "$updater" ) | crontab -u pi -

echo -ne "-------------------------------------
EJECUTANDO EL SCRIPT UPDATER 
-------------------------------------"
echo " "

#ejecuta por primera vez el archivo updater
clear
echo -ne "----------------------------------------
ACTUALIZANDO EL SISTEMA POR PRIMERA VEZ
----------------------------------------"
echo " "
source $r_act/updater

clear
echo -ne "----------------------------------------
SCRIPT EJECUTADO Y SISTEMA ACTUALIZADO
----------------------------------------"
echo " "
else
source /SHConfig/menu.sh    
fi     
} 
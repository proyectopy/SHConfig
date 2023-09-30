#!/bin/bash

########################################################################
# Script: duckdns.sh
# Descripcion: Funcion para la actualizar los DND de Duckdns.org de la raspberry
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
default="Si"
# TEXTO DEL CRONTAB
duckdns="*/2 * * * * /bin/bash /SHConfig/.conf/.duckdns/duckdns >/dev/null 2>&1"
########################################################################
# FUNCION AUTOMATIZAR DUCKDNS REVISADO (OK)
########################################################################

duckdns.sh(){
#clear
echo $r_duck
if [ -d "$r_duck" ]
then
#clear
echo -ne "-------------------------------------
DUCKDNS YA ESTA CONFIGURADO     
-------------------------------------"
sleep 6
else
#clear
sleep 2
install_sendmail
fi
}


###################################################
#        INSTALAR SENDMAIL (OK)   
###################################################

sendmail() {
#clear
echo -ne "-------------------------------------
COMPROBAMOS SI ESTAN INSTALADOS SENDMAIL Y MAILUTILS   
-------------------------------------"   
sleep 6
if dpkg-query -W -f'${db:Status-Abbrev}\n' ssmtp 2>/dev/null \ | grep -q '^.i $';
then
echo -ne "-------------------------------------
SENDMAIL YA ESTA INSTALADO 
EJECUTAMOS COMPROBAR   
-------------------------------------"
sleep 6
comprobar
else
echo -ne "-------------------------------------
COMO NO ESTA INSTALADO VAMOS A 
INSTALAR SENDMAIL Y MAILUTILS   
-------------------------------------"
sleep 6
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
CONFIGURADO DEL TODO ...
AHORA EJECUTAMOS COMPROBAR 
-------------------------------------"
sleep 6
comprobar
fi
}
###################################################
#       FUNCION comprobar PARA COMPROBAR 
###################################################

comprobar() {
upd_dns=false
#clear
echo -ne "-------------------------------------
EMPIEZA LA FUNCION COMPROBAR    
-------------------------------------"
sleep 6    
	
if [ "$upd_dns" = true ]; 
then
            
#clear
echo -ne "-------------------------------------
VALOR DE ACTUALIZAR ES TRUE Y PO LO TANTO
ESTAMOS CONFIGURANDO LA AUTOMATIZACION
DE DUCKDNS.ORG.  ESPERE POR FAVOR     
-------------------------------------"
sleep 6
echo " "
sudo mkdir -p $r_duck
sudo chown -R $USER:$USER $r_duck
        #sudo chmod -R 777 $r_duck/
        #sudo touch $r_duck/duckdns
echo -ne "-------------------------------------
CREANDO EL SCRIPT DUCKDNS
-------------------------------------"
sleep 6
        echo " "
        sudo touch duckdns
        sudo chown pi:pi duckdns

        sudo chmod +x duckdns

        sudo chmod -R 777 duckdns
        #!/bin/bash
        sudo echo "#!/bin/bash" >> duckdns
        sudo echo "########################################################################" >> duckdns
        sudo echo "# SCRIPS NECESARIOS" >> duckdns
        sudo echo "########################################################################" >> duckdns
        sudo echo "#. SHConfig/db/variables.txt" >> duckdns
        sudo echo "########################################################################" >> duckdns
        sudo echo "# Script: duckdnsUPGRADE                                                    " >> duckdns
        sudo echo "# Descripcion: Configuracion del cron para duckdns    "  >> duckdns
        sudo echo "########################################################################" >> duckdns
        sudo echo "#">> duckdns
        sudo echo "act=\`date +%d%m%Y\`" >> duckdns
        sudo echo "dt=\`date +'%A, %d del %m de %Y a las %H:%M ' \` " >> duckdns
        sudo echo echo url="\"https://www.duckdns.org/update?domains=$domain&token=$token&ip=\" | curl -k -o $r_duck/.logs/duck.log -K -" >> duckdns
        sudo echo "sudo sendmail -t < /SHConfig/mail_templates/duckdns.html">> duckdns
        sudo echo "Hemos enviado un email el \$dt >> $r_duck//.logs/emails_\$act.log"  >> duckdns

        #Situa en su directorio definitivo el archivo updater
        echo -ne "-------------------------------------
        MUEVE EL SCRIPT DUCKDNS A SU CARPETA 
        -------------------------------------"
        sleep 6
        sudo mv duckdns $r_duck

        (crontab -u pi -l; echo "$duckdns" ) | crontab -u pi -
        
        echo -ne "-------------------------------------
        EJECUTANDO POR PRIMERA VEZ EL SCRIPT DUCKDNS 
        -------------------------------------"
        sleep 6

        #ejecuta por primera vez el archivo updater
        #clear
        echo -ne "----------------------------------------
        ACTUALIZANDO LOS DNS POR PRIMERA VEZ
        ----------------------------------------"
        echo " "

        source $r_duck/duckdns

        #clear
        echo -n "--------------------------------------
        SCRIPT PARA DUCKDNS EJECUTADO Y DNS ACTUALIZADA  
        --------------------------------------
        "
        sleep 6
        else
        source /SHConfig/menu.sh
    fi
}
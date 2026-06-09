#!/bin/bash

bleuclair='\e[1;34m'
BRED='\e[0;31m'
gras='\033[1m'
NC='\033[0m'

installation() {
    echo -e "${BRED} ${gras}--- Es-tu sur de vouloir installer les différents packages ? (y/n) --- ${NC}"
    read rep
    if [ "$rep" == "y" ]; then
        echo -e " ${gras} ${bleuclair} Installation des programmes en cours...${NC}"
        apt update &>/dev/null
        apt install -y quota &>/dev/null
        echo -e " ${gras} ${bleuclair} Quota installé ! ${NC}"
        apt install -y pure-ftpd &>/dev/null
        echo -e " ${gras} ${bleuclair} FTP installé ! ${NC}"
        apt install -y mariadb-server &>/dev/null
        echo -e " ${gras} ${bleuclair} Base de données installée ! ${NC}"
        apt install -y apache2 &>/dev/null
        echo -e "${gras} ${bleuclair} Apache installé ! ${NC}"
        sleep 1;
        echo -e "${BRED} ${gras}--- Tout est installé !! Tu peux maintenant créer un hébergement ---${NC}"
    else
        echo -e "${BRED} ${gras}--- Installation annulée ! ---${NC}"
    fi
mount -o remount,usrquota / &>/dev/null
quotacheck -cum / &>/dev/null
quotaon / &>/dev/null
sleep 1
}

#!/bin/bash
BVERT='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BCYAN='\033[1;36m'
GRAS='\033[1m'
NC='\033[0m'

server_info() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}==== Informations Serveur ==${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""

        echo -e "${BYELLOW}___ Espace disque ___${NC}"
        df -h /
        echo ""

        echo -e "${BYELLOW}___ Utilisateurs hébergés ___${NC}"
        count=0
        for dir in /home/*/; do
                user=$(basename "$dir")
                if [ -d "/home/$user/www" ] && id "$user" &>/dev/null; then
                        echo "  - $user"
                        count=$((count + 1))
                fi
        done
        echo -e "${GRAS}Total : $count utilisateur(s)${NC}"
        echo ""

        echo -e "${BYELLOW}___ Espace utilisé par utilisateur ___${NC}"
        for dir in /home/*/; do
                user=$(basename "$dir")
                if [ -d "/home/$user/www" ] && id "$user" &>/dev/null; then
                        used=$(du -sh /home/$user 2>/dev/null | cut -f1)
                        echo "  - $user : $used"
                fi
        done
        echo ""

        echo -e "${BYELLOW}___ Sites hébergés ___${NC}"
        ls /etc/apache2/sites-enabled/ 2>/dev/null
        echo ""

        echo -e "${BYELLOW}___ Statut des services ___${NC}"
        for service in apache2 pure-ftpd mariadb ssh; do
                if systemctl is-active --quiet "$service" 2>/dev/null; then
                        echo -e "  $service : ${BVERT}actif${NC}"
                else
                        echo -e "  $service : ${BRED}inactif${NC}"
                fi
        done
        echo ""

        echo -e "${BYELLOW}___ Adresse IP ___${NC}"
        hostname -I
        echo ""

        echo "Retour au menu dans 3.."; sleep 1
        echo "Retour au menu dans 2.."; sleep 1
        echo "Retour au menu dans 1.."; sleep 1
        sleep 1
}

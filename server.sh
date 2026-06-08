#!/bin/bash
BVERT='\033[1;32m'   # Vert gras
BRED='\033[1;31m'    # Rouge gras
BYELLOW='\033[1;33m' # Jaune gras
BCYAN='\033[1;36m'   # Cyan gras
GRAS='\033[1m'       # Gras
NC='\033[0m'         # No Color

server_info() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}==== Informations Serveur ==${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""

        # --- Espace disque ---
        echo -e "${BYELLOW}___ Espace disque ___${NC}"
        df -h / # Affiche l'espace disque total et utilisé
        echo ""

        # --- Nombre d'utilisateurs ---
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

        # --- Espace utilisé par utilisateur ---
        echo -e "${BYELLOW}___ Espace utilisé par utilisateur ___${NC}"
        for dir in /home/*/; do
                user=$(basename "$dir")
                if [ -d "/home/$user/www" ] && id "$user" &>/dev/null; then
                        used=$(du -sh /home/$user 2>/dev/null | cut -f1)
                        echo "  - $user : $used"
                fi
        done
        echo ""

        # --- Sites hébergés ---
        echo -e "${BYELLOW}___ Sites hébergés ___${NC}"
        ls /etc/apache2/sites-enabled/ 2>/dev/null  # Liste les VirtualHosts actifs
        echo ""

        # --- Statut des services ---
        echo -e "${BYELLOW}___ Statut des services ___${NC}"
        for service in apache2 pure-ftpd mariadb ssh; do
                if systemctl is-active --quiet "$service" 2>/dev/null; then
                        echo -e "  $service : ${BVERT}actif${NC}"
                else
                        echo -e "  $service : ${BRED}inactif${NC}"
                fi
        done
        echo ""

        # --- IP du serveur ---
        echo -e "${BYELLOW}___ Adresse IP ___${NC}"
        hostname -I  # Affiche les adresses IP du serveur
        echo ""

        echo "Retour au menu dans 3.."; sleep 1
        echo "Retour au menu dans 2.."; sleep 1
        echo "Retour au menu dans 1.."; sleep 1
        sleep 1
}

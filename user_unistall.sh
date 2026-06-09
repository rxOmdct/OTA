#!/bin/bash
BVERT='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BCYAN='\033[1;36m'
GRAS='\033[1m'
NC='\033[0m'

delete_user() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}===== Les utilisateurs =====${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        ls /home/
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}======== Suppression =======${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Quel utilisateur souhaites-tu supprimer ?${NC}"
        read nom
        echo -e "${GRAS}Suppression en cours...${NC}"
        if id "$nom" &>/dev/null; then
                userdel -r $nom &>/dev/null
                rm -rf /home/$nom
                pure-pw userdel $nom &>/dev/null
                pure-pw mkdb &>/dev/null
                mysql -u root -e "DROP DATABASE $nom;" &>/dev/null
                rm -f /etc/apache2/sites-available/$nom.conf &>/dev/null
                echo -e "${GRAS}$nom supprimé avec succès !${NC}"
        else
                echo -e "${GRAS}L'utilisateur n'existe pas !${NC}"
        fi
        echo ""
        echo -e "${GRAS}Voulez-vous en supprimer un autre ou réessayer ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                delete_user
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

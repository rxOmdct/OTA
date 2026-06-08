#!/bin/bash
BVERT='\033[1;32m'   # Vert gras
BRED='\033[1;31m'    # Rouge gras
BYELLOW='\033[1;33m' # Jaune gras
BCYAN='\033[1;36m'   # Cyan gras
GRAS='\033[1m'       # Gras
NC='\033[0m'         # No Color

delete_user() { # Fonction pour supprimer un utilisateur
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
                userdel -r $nom &>/dev/null    # Supprime l'utilisateur
                rm -rf /home/$nom              # Supprime le dossier si encore présent
                pure-pw userdel $nom &>/dev/null  # Supprime le FTP
                pure-pw mkdb &>/dev/null          # Met à jour la base FTP
                mysql -u root -e "DROP DATABASE $nom;" &>/dev/null  # Supprime la BDD
                rm -f /etc/apache2/sites-available/$nom.conf &>/dev/null  # Supprime le VirtualHost
                echo -e "${GRAS}$nom supprimé avec succès !${NC}"
        else
                echo -e "${GRAS}L'utilisateur n'existe pas !${NC}"
        fi
        echo ""
        echo -e "${GRAS}Voulez-vous en supprimer un autre ou réessayer ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                delete_user  # Rappelle la fonction
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

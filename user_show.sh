#!/bin/bash
BVERT='\033[1;32m'   # Vert gras
BRED='\033[1;31m'    # Rouge gras
BYELLOW='\033[1;33m' # Jaune gras
BCYAN='\033[1;36m'   # Cyan gras
GRAS='\033[1m'       # Gras
NC='\033[0m'         # No Color

show_user() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}===== Les utilisateurs =====${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        ls /home/
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}====== Voir un compte ======${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Quel utilisateur veux-tu voir ?${NC}"
        read nom
        if id "$nom" &>/dev/null; then  # Vérifie si l'utilisateur existe
                echo ""
                echo -e "${BVERT}============================${NC}"
                echo -e "${BVERT}====== Info de $nom ======${NC}"
                echo -e "${BVERT}============================${NC}"
                echo ""
                echo -e "${GRAS}___ Identité ___${NC}"
                id $nom                          # Affiche uid, gid de l'utilisateur
                echo ""
                echo -e "${GRAS}___ Espace disque utilisé ___${NC}"
                du -sh /home/$nom                # Espace disque utilisé
                echo ""
                echo -e "${GRAS}___ Quota ___${NC}"
                quota -u $nom 2>/dev/null                    # Quota de l'utilisateur
                echo ""
                echo -e "${GRAS}___ Shell et home ___${NC}"
                getent passwd $nom               # Infos complètes (shell, home...)
                echo ""
                echo -e "${GRAS}___ Fichiers du www ___${NC}"
                ls /home/$nom/www 2>/dev/null                # Fichiers dans www
                echo ""
                echo -e "${GRAS}___ Base de données ___${NC}"
                db=$(mysql -u root -e "SHOW DATABASES LIKE '$nom';" 2>/dev/null)
                if [ -z "$db" ]; then            # -z vérifie si la variable est vide
                        echo -e "${GRAS}Aucune base de données pour $nom${NC}"
                else
                        echo -e "${GRAS}$db${NC}"
                fi
        else
                echo -e "${GRAS}L'utilisateur $nom n'existe pas !${NC}"
        fi
        echo ""
        echo -e "${GRAS}Voulez-vous voir un autre utilisateur ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                show_user  # Rappelle la fonction
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

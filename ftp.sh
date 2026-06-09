#!/bin/bash
BVERT='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BCYAN='\033[1;36m'
GRAS='\033[1m'
NC='\033[0m'

manage_ftp() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}======= Gestion FTP ========${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Que veux-tu faire ?${NC}"
        echo -e "${GRAS}1 - Activer le FTP d'un utilisateur${NC}"
        echo -e "${GRAS}2 - Désactiver le FTP d'un utilisateur${NC}"
        echo -e "${GRAS}3 - Afficher les comptes FTP existants${NC}"
        echo -e "${BRED}0 - Retour au menu${NC}"
        echo ""
        read -rp "Votre choix : " choix

        case "$choix" in
                1)
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}======= Activer FTP ========${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        ls /home/
                        echo ""
                        echo -e "${GRAS}Quel utilisateur veux-tu activer ?${NC}"
                        read nom
                        if id "$nom" &>/dev/null; then
                                pure-pw useradd $nom -u $nom -d /home/$nom/www
                                pure-pw mkdb &>/dev/null
                                echo -e "${BVERT}FTP activé pour $nom !!${NC}"
                        else
                                echo -e "${BRED}L'utilisateur $nom n'existe pas !${NC}"
                        fi
                        ;;
                2)
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}====== Désactiver FTP ======${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        echo -e "${BYELLOW}Comptes FTP existants :${NC}"
                        pure-pw list 2>/dev/null
                        echo ""
                        echo -e "${GRAS}Quel utilisateur veux-tu désactiver ?${NC}"
                        read nom
                        pure-pw userdel $nom &>/dev/null
                        pure-pw mkdb &>/dev/null
                        echo -e "${BVERT}FTP désactivé pour $nom !!${NC}"
                        ;;
                3)
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}====== Comptes FTP =========${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        pure-pw list 2>/dev/null
                        ;;
                0)
                        return
                        ;;
                *)
                        echo -e "${BRED}Choix invalide !${NC}"
                        sleep 1
                        ;;
        esac
        echo ""
        echo -e "${GRAS}Voulez-vous faire autre chose ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                manage_ftp
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

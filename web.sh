#!/bin/bash
BVERT='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BCYAN='\033[1;36m'
GRAS='\033[1m'
NC='\033[0m'

manage_web_files() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}==== Fichiers Web ==========${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        ls /home/
        echo ""
        echo -e "${GRAS}Quel utilisateur veux-tu gérer ?${NC}"
        read nom
        if ! id "$nom" &>/dev/null; then
                echo -e "${BRED}L'utilisateur $nom n'existe pas !${NC}"
                sleep 1
                return
        fi
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}====== Info de $nom ========${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${BYELLOW}___ Espace disque utilisé ___${NC}"
        du -sh /home/$nom
        echo ""
        echo -e "${BYELLOW}___ Fichiers dans www ___${NC}"
        ls -lh /home/$nom/www 2>/dev/null
        echo ""
        echo -e "${GRAS}Que veux-tu faire ?${NC}"
        echo -e "${GRAS}1 - Installer WordPress${NC}"
        echo -e "${BRED}0 - Retour au menu${NC}"
        echo ""
        read -rp "Votre choix : " choix

        case "$choix" in
                1)
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}===== Install WordPress ====${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        echo -e "${GRAS}Téléchargement de WordPress...${NC}"
                        wget -q https://fr.wordpress.org/latest-fr_FR.tar.gz -O /tmp/wordpress.tar.gz
                        echo -e "${BVERT}Téléchargement terminé !!${NC}"
                        echo -e "${GRAS}Installation en cours...${NC}"
                        tar -xzf /tmp/wordpress.tar.gz -C /tmp/
                        cp -r /tmp/wordpress/. /home/$nom/www/
                        chown -R $nom:$nom /home/$nom/www
                        rm -f /tmp/wordpress.tar.gz
                        echo -e "${BVERT}WordPress installé pour $nom !!${NC}"
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
        echo -e "${GRAS}Voulez-vous gérer un autre utilisateur ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                manage_web_files
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

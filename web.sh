#!/bin/bash
BVERT='\033[1;32m'   # Vert gras
BRED='\033[1;31m'    # Rouge gras
BYELLOW='\033[1;33m' # Jaune gras
BCYAN='\033[1;36m'   # Cyan gras
GRAS='\033[1m'       # Gras
NC='\033[0m'         # No Color

manage_web_files() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}==== Fichiers Web ==========${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        ls /home/
        echo ""
        echo -e "${GRAS}Quel utilisateur veux-tu gérer ?${NC}"
        read nom
        if ! id "$nom" &>/dev/null; then  # Vérifie si l'utilisateur existe
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
        du -sh /home/$nom  # Espace disque utilisé
        echo ""
        echo -e "${BYELLOW}___ Fichiers dans www ___${NC}"
        ls -lh /home/$nom/www 2>/dev/null  # Liste les fichiers dans www
        echo ""
        echo -e "${GRAS}Que veux-tu faire ?${NC}"
        echo -e "${GRAS}1 - Installer WordPress${NC}"
        echo -e "${BRED}0 - Retour au menu${NC}"
        echo ""
        read -rp "Votre choix : " choix

        case "$choix" in
                1)
                        # --- Installer WordPress ---
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}===== Install WordPress ====${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        echo -e "${GRAS}Téléchargement de WordPress...${NC}"
                        wget -q https://fr.wordpress.org/latest-fr_FR.tar.gz -O /tmp/wordpress.tar.gz # Télécharge WordPress
                        echo -e "${BVERT}Téléchargement terminé !!${NC}"
                        echo -e "${GRAS}Installation en cours...${NC}"
                        tar -xzf /tmp/wordpress.tar.gz -C /tmp/ # Extrait l'archive
                        cp -r /tmp/wordpress/. /home/$nom/www/  # Copie dans le dossier www
                        chown -R $nom:$nom /home/$nom/www        # Donne les droits à l'utilisateur
                        rm -f /tmp/wordpress.tar.gz              # Supprime l'archive
                        echo -e "${BVERT}WordPress installé pour $nom !!${NC}"
                        ;;
                0)
                        return # Retourne au menu principal
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
                manage_web_files  # Rappelle la fonction
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

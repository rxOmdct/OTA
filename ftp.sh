#!/bin/bash
BVERT='\033[1;32m'   # Vert gras
BRED='\033[1;31m'    # Rouge gras
BYELLOW='\033[1;33m' # Jaune gras
BCYAN='\033[1;36m'   # Cyan gras
GRAS='\033[1m'       # Gras
NC='\033[0m'         # No Color

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
                        # --- Activer FTP ---
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}======= Activer FTP ========${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        ls /home/
                        echo ""
                        echo -e "${GRAS}Quel utilisateur veux-tu activer ?${NC}"
                        read nom
                        if id "$nom" &>/dev/null; then  # Vérifie si l'utilisateur existe
                                pure-pw useradd $nom -u $nom -d /home/$nom/www # Ajoute l'utilisateur FTP
                                pure-pw mkdb &>/dev/null  # Met à jour la base FTP
                                echo -e "${BVERT}FTP activé pour $nom !!${NC}"
                        else
                                echo -e "${BRED}L'utilisateur $nom n'existe pas !${NC}"
                        fi
                        ;;
                2)
                        # --- Désactiver FTP ---
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}====== Désactiver FTP ======${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        echo -e "${BYELLOW}Comptes FTP existants :${NC}"
                        pure-pw list 2>/dev/null  # Affiche les comptes FTP
                        echo ""
                        echo -e "${GRAS}Quel utilisateur veux-tu désactiver ?${NC}"
                        read nom
                        pure-pw userdel $nom &>/dev/null  # Supprime l'utilisateur FTP
                        pure-pw mkdb &>/dev/null           # Met à jour la base FTP
                        echo -e "${BVERT}FTP désactivé pour $nom !!${NC}"
                        ;;
                3)
                        # --- Afficher les comptes FTP ---
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}====== Comptes FTP =========${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        pure-pw list 2>/dev/null  # Liste tous les comptes FTP
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
        echo -e "${GRAS}Voulez-vous faire autre chose ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                manage_ftp  # Rappelle la fonction
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

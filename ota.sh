#!/bin/bash
VERT='\033[0;32m'
BVERT='\033[1;32m'
BRED='\033[1;31m'
BC='\e[1;34m'
SOULIGNE='\033[4m'
GRAS='\033[1m'
NC='\033[0m'

while true; do
    clear

    echo -e "${BRED} ╔══════════════════════════════════════╗${NC}"
    echo -e "${BRED} ║     Projet OTA - Hébergement WEB     ║${NC}"
    echo -e "${BRED} ╚══════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${GARS} ${BRED} AVANT TOUTE INSTALLATION VEUILLEZ FAIRE 9 !!! ${NC} "
    echo ""
    echo -e "${GRAS}  1 - Créer un hébergement${NC}"
    echo -e "${GRAS}  2 - Supprimer un hébergement${NC}"
    echo -e "${GRAS}  3 - Modifier un hébergement${NC}"
    echo ""
    echo -e "${GRAS}  4 - Liste des utilisateurs / détails${NC}"
    echo -e "${GRAS}  5 - Gestion des bases de données${NC}"
    echo -e "${GRAS}  6 - Gestion des fichiers web${NC}"
    echo ""
    echo -e "${GRAS}  7 - Gestion FTP${NC}"
    echo -e "${GRAS}  8 - Informations serveur${NC}"
    echo -e "${GRAS}  9 - Installer les paquets${NC}"
    echo ""
    echo -e "${BRED}  0 - Quitter${NC}"
    echo ""

    read -rp "  Votre choix : " choice

    case "$choice" in
        1) source user_install.sh; create_user ;;
        2) source user_unistall.sh; delete_user ;;
        3) source user_modify.sh; modify_user ;;
        4) source user_show.sh; show_user ;;
        5) source database.sh; manage_databases ;;
        6) source web.sh; manage_web_files ;;
        7) source ftp.sh; manage_ftp ;;
        8) source server.sh; server_info ;;
        9) source packages.sh; installation ;;
        0) echo -e "${BRED}  Merci d'avoir utilisé OTA !!${NC}"
            exit 0 ;;
        *) echo -e "${BRED}  SAPRISTI CECI EST UNE FAUTE !${NC}"; sleep 1 ;;
    esac
done

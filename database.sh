#!/bin/bash
BVERT='\033[1;32m'   # Vert gras
BRED='\033[1;31m'    # Rouge gras
BYELLOW='\033[1;33m' # Jaune gras
BCYAN='\033[1;36m'   # Cyan gras
GRAS='\033[1m'       # Gras
NC='\033[0m'         # No Color

manage_databases() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}==== Bases de données ======${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Que veux-tu faire ?${NC}"
        echo -e "${GRAS}1 - Créer une base de données${NC}"
        echo -e "${GRAS}2 - Supprimer une base de données${NC}"
        echo -e "${GRAS}3 - Afficher les bases existantes${NC}"
        echo -e "${BRED}0 - Retour au menu${NC}"
        echo ""
        read -rp "Votre choix : " choix

        case "$choix" in
                1)
                        # --- Créer une base de données ---
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}======= Création BDD =======${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        echo -e "${GRAS}Nom de la base de données :${NC}"
                        read dbnom
                        mysql -u root -e "CREATE DATABASE $dbnom;" # Crée la base de données
                        echo -e "${BVERT}Base de données $dbnom créée !!${NC}"
                        ;;
                2)
                        # --- Supprimer une base de données ---
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}======= Suppression BDD ====${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        # Affiche les bases existantes avant de demander
                        echo -e "${BYELLOW}Bases de données existantes :${NC}"
                        mysql -u root -e "SHOW DATABASES;" 2>/dev/null
                        echo ""
                        echo -e "${GRAS}Nom de la base à supprimer :${NC}"
                        read dbnom
                        mysql -u root -e "DROP DATABASE $dbnom;" # Supprime la base de données
                        echo -e "${BVERT}Base de données $dbnom supprimée !!${NC}"
                        ;;
                3)
                        # --- Afficher les bases existantes ---
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}====== Bases existantes ====${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        mysql -u root -e "SHOW DATABASES;" 2>/dev/null # Affiche toutes les bases
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
                manage_databases  # Rappelle la fonction
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

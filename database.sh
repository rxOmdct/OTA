#!/bin/bash
BVERT='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BCYAN='\033[1;36m'
GRAS='\033[1m'
NC='\033[0m'

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
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}======= Création BDD =======${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        echo -e "${GRAS}Nom de la base de données :${NC}"
                        read dbnom
                        mysql -u root -e "CREATE DATABASE $dbnom;"
                        echo -e "${BVERT}Base de données $dbnom créée !!${NC}"
                        ;;
                2)
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}======= Suppression BDD ====${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        echo -e "${BYELLOW}Bases de données existantes :${NC}"
                        mysql -u root -e "SHOW DATABASES;" 2>/dev/null
                        echo ""
                        echo -e "${GRAS}Nom de la base à supprimer :${NC}"
                        read dbnom
                        mysql -u root -e "DROP DATABASE $dbnom;"
                        echo -e "${BVERT}Base de données $dbnom supprimée !!${NC}"
                        ;;
                3)
                        echo ""
                        echo -e "${BVERT}============================${NC}"
                        echo -e "${BVERT}====== Bases existantes ====${NC}"
                        echo -e "${BVERT}============================${NC}"
                        echo ""
                        mysql -u root -e "SHOW DATABASES;" 2>/dev/null
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
                manage_databases
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

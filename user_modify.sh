#!/bin/bash
BVERT='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BCYAN='\033[1;36m'
GRAS='\033[1m'
NC='\033[0m'

modify_user() {
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}===== Les utilisateurs =====${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        ls /home/
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}===== Modifier un compte ===${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Quel utilisateur veux-tu modifier ?${NC}"
        read nom
        if ! id "$nom" &>/dev/null; then
                echo -e "${BRED}L'utilisateur $nom n'existe pas !${NC}"
                return
        fi
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}======= Mot de passe =======${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Veux-tu modifier le mot de passe ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                passwd $nom
                echo -e "${BVERT}Mot de passe changé !!${NC}"
        else
                echo -e "${BYELLOW}Mot de passe inchangé.${NC}"
        fi
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}======= Quota disque =======${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Veux-tu modifier le quota ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                echo -e "${GRAS}Nouveau quota (ex: 500M, 1G) :${NC}"
                read quota
                quota=$(echo "$quota" | tr '[:lower:]' '[:upper:]')
                setquota -u $nom 0 $quota 0 0 /
                echo -e "${BVERT}Quota changé à $quota !!${NC}"
        else
                echo -e "${BYELLOW}Quota inchangé.${NC}"
        fi
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}======= Accès SSH ==========${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Veux-tu modifier le SSH ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                echo -e "${GRAS}Activer ou désactiver ? (activer/desactiver)${NC}"
                read choix
                if [ "$choix" == "activer" ]; then
                        usermod -s /bin/bash $nom
                        echo -e "${BVERT}SSH activé pour $nom !!${NC}"
                else
                        usermod -s /usr/sbin/nologin $nom
                        echo -e "${BYELLOW}SSH désactivé pour $nom.${NC}"
                fi
        fi
        echo ""
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}====== Base de données =====${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Veux-tu modifier la base de données ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                echo -e "${GRAS}Créer ou supprimer ? (creer/supprimer)${NC}"
                read choix
                if [ "$choix" == "creer" ]; then
                        mysql -u root -e "CREATE DATABASE $nom;"
                        echo -e "${BVERT}Base de données $nom créée !!${NC}"
                else
                        mysql -u root -e "DROP DATABASE $nom;"
                        echo -e "${BYELLOW}Base de données $nom supprimée.${NC}"
                fi
        fi
        echo ""
        echo -e "${BCYAN}============================${NC}"
        echo -e "${BCYAN}== Modification terminée ! ==${NC}"
        echo -e "${BCYAN}============================${NC}"
        echo ""
        echo -e "${GRAS}Voulez-vous modifier un autre utilisateur ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                modify_user
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

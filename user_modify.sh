#!/bin/bash
BVERT='\033[1;32m'   # Vert gras
BRED='\033[1;31m'    # Rouge gras
BYELLOW='\033[1;33m' # Jaune gras
BCYAN='\033[1;36m'   # Cyan gras
GRAS='\033[1m'       # Gras
NC='\033[0m'         # No Color

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
        # Vérifie si l'utilisateur existe
        if ! id "$nom" &>/dev/null; then
                echo -e "${BRED}L'utilisateur $nom n'existe pas !${NC}"
                return
        fi
        echo ""
        # --- Modification du mot de passe ---
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}======= Mot de passe =======${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Veux-tu modifier le mot de passe ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                passwd $nom # Demande le nouveau mot de passe
                echo -e "${BVERT}Mot de passe changé !!${NC}"
        else
                echo -e "${BYELLOW}Mot de passe inchangé.${NC}"
        fi
        echo ""
        # --- Modification du quota disque ---
        echo -e "${BVERT}============================${NC}"
        echo -e "${BVERT}======= Quota disque =======${NC}"
        echo -e "${BVERT}============================${NC}"
        echo ""
        echo -e "${GRAS}Veux-tu modifier le quota ? (y/n)${NC}"
        read rep
        if [ "$rep" == "y" ]; then
                echo -e "${GRAS}Nouveau quota (ex: 500M, 1G) :${NC}"
                read quota
                quota=$(echo "$quota" | tr '[:lower:]' '[:upper:]') # Force la majuscule
                setquota -u $nom 0 $quota 0 0 / # Applique le nouveau quota
                echo -e "${BVERT}Quota changé à $quota !!${NC}"
        else
                echo -e "${BYELLOW}Quota inchangé.${NC}"
        fi
        echo ""
        # --- Modification de l'accès SSH ---
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
                        usermod -s /bin/bash $nom # Active le shell SSH
                        echo -e "${BVERT}SSH activé pour $nom !!${NC}"
                else
                        usermod -s /usr/sbin/nologin $nom # Bloque le SSH
                        echo -e "${BYELLOW}SSH désactivé pour $nom.${NC}"
                fi
        fi
        echo ""
        # --- Modification de la base de données ---
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
                        mysql -u root -e "CREATE DATABASE $nom;" # Crée la base de données
                        echo -e "${BVERT}Base de données $nom créée !!${NC}"
                else
                        mysql -u root -e "DROP DATABASE $nom;" # Supprime la base de données
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
                modify_user  # Rappelle la fonction
        else
                echo "Retour au menu dans 3.."; sleep 1
                echo "Retour au menu dans 2.."; sleep 1
                echo "Retour au menu dans 1.."; sleep 1
                sleep 1
        fi
}

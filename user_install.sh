#!/bin/bash
BVERT='\033[1;32m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BCYAN='\033[1;36m'
GRAS='\033[1m'
NC='\033[0m'

create_user() {
	echo -e "${BVERT}============================${NC}"
	echo -e "${BVERT}===== Nom d'utilsateur =====${NC}"
	echo -e "${BVERT}============================${NC}"
	echo ""
	echo -e "${GARS}Veuillez saisir un nom d'utilisateur :${NC}"
	read nom
	useradd -m $nom
	echo -e "${GRAS}Bien le bonjour $nom !${NC}"
	sleep 1;
	echo ""
	echo -e "${BVERT}============================${NC}"
	echo -e "${BVERT}======= Mot de passe =======${NC}"
	echo -e "${BVERT}============================${NC}"
	echo ""
	echo -e "${GRAS}Veuillez saisir le mot de passe de $nom ${NC}"
	passwd $nom
	echo -e "${GRAS}Mot de passe bien configurer !${NC}"
	sleep 1;
	echo ""
	echo -e "${BVERT}============================${NC}"
	echo -e "${BVERT}======= Quota disque =======${NC}"
	echo -e "${BVERT}============================${NC}"
	echo ""
	echo "Exemple : 50M (mo) // 15G (go), veuillez mettre la majuscule."
	read quota
	setquota -u $nom 0 $quota 0 0 /
	echo -e "${GRAS}Quota bien configurer !${NC}"
	sleep 1;
	echo ""
	echo -e "${BVERT}============================${NC}"
	echo -e "${BVERT}======= Création FTP =======${NC}"
	echo -e "${BVERT}============================${NC}"
	echo ""
	usermod -d /home/$nom/./www $nom
	pure-pw useradd $nom -u $nom -d /home/$nom/www
	pure-pw mkdb
	echo ""
	echo -e "${BVERT}============================${NC}"
	echo -e "${BVERT}====== Base de donnée ======${NC}"
	echo -e "${BVERT}============================${NC}"
	echo ""
	echo -e "${GRAS}Voulez-vous avoir une base de donnée pour $nom ? (y/n) ${NC}"
	read rep
	if [ "$rep" == "y" ]; then
		echo -e "${GRAS}Création de la base de donnée en cours... ${NC}"
		sleep 1;
		mysql -u root -e "CREATE DATABASE $nom;"
		echo "Base de donnée créer !"
	else
		echo -e "${GRAS}Ok, pas de base de donnée pour $nom ${NC}"
	fi
	echo ""
	echo -e "${BVERT}============================${NC}"
	echo -e "${BVERT}======= Création SSH =======${NC}"
	echo -e "${BVERT}============================${NC}"
	echo ""
	echo -e "${GRAS}Voulez-vous configurer le shh ? (y/n) ${NC}"
	read rep
	if [ "$rep" == "y" ]; then
		echo -e "${GRAS}Configuration du shh en cours...${NC}"
		sleep 1;
		usermod -s /bin/bash $nom
		echo -e "${GRAS}SSH configurer ! ${NC}"
	else
		echo -e "${GRAS}Annulation en cours... ${NC}"
		sleep 1;
		usermod -s /usr/sbin/nologin $nom
	fi
	echo ""
	echo -e "${BVERT}============================${NC}"
	echo -e "${BVERT}========== Autre ===========${NC}"
	echo -e "${BVERT}============================${NC}"
	echo ""
	echo -e "${GRAS}Création des fichiers quelconque... ${NC}"
	mkdir /home/$nom/www
	cat > /etc/apache2/sites-available/$nom.conf <<VHOST
<VirtualHost *:80>
    ServerName $nom.localhost
    DocumentRoot /home/$nom/www
</VirtualHost>
VHOST
a2ensite $nom.conf &>/dev/null
systemctl reload apache2 &>/dev/null
	echo -e "${GRAS}Création de $nom terminer ! ${NC}"
	echo "Retour au menu dans 3.."; sleep 1
	echo "Retour au menu dans 2.."; sleep 1
	echo "Retour au menu dans 1.."; sleep 1
	sleep 1;
}

# OTA — Gestion d'un hébergement web

**OTA** est un outil d'administration en ligne de commande, écrit en **Bash**, qui automatise la création et la gestion d'hébergements web sur un serveur Linux (Debian / Ubuntu). Il fonctionne comme un mini panneau de contrôle : un menu interactif appelle des scripts spécialisés selon le choix de l'administrateur.

Projet réalisé dans le cadre du **BTS SIO (SISR)** — Romain Dacet.

## Fonctionnalités

- **Créer un hébergement** : utilisateur Linux, mot de passe, quota disque, compte FTP, base de données et accès SSH en une seule procédure
- **Supprimer un hébergement** : suppression complète (compte, FTP, base de données, VirtualHost)
- **Modifier un hébergement** : mot de passe, quota, SSH et base de données
- **Lister les utilisateurs** et afficher le détail de chacun
- **Gestion des bases de données** (MariaDB) : créer, supprimer, afficher
- **Gestion des fichiers web** : avec installation de **WordPress en un clic**
- **Gestion FTP** (Pure-FTPd) : activer, désactiver, lister les comptes
- **Informations serveur** : espace disque, utilisateurs hébergés, sites actifs, statut des services, adresse IP
- **Installation des paquets** requis

## Prérequis

- Un serveur **Linux Debian / Ubuntu**
- Un accès **root** (les commandes administrent des utilisateurs, services et quotas)
- Services installés via l'option 9 du menu : `apache2`, `mariadb-server`, `pure-ftpd`, `quota`

## Installation & utilisation

```bash
git clone https://github.com/rxOmdct/OTA.git
cd OTA
chmod +x *.sh
sudo ./ota.sh
```

> À la première utilisation, choisissez l'option **9 — Installer les paquets** avant de créer un hébergement.

## Structure du projet

| Script              | Rôle                                              |
|---------------------|---------------------------------------------------|
| `ota.sh`            | Script principal — affiche le menu et appelle les modules |
| `packages.sh`       | Installation des paquets (Apache, MariaDB, Pure-FTPd, quota) |
| `user_install.sh`   | Création d'un hébergement complet                 |
| `user_unistall.sh`  | Suppression d'un hébergement                      |
| `user_modify.sh`    | Modification d'un compte existant                 |
| `user_show.sh`      | Affichage des informations d'un utilisateur       |
| `database.sh`       | Gestion des bases de données MariaDB              |
| `web.sh`            | Gestion des fichiers web et installation WordPress |
| `ftp.sh`            | Gestion des comptes FTP                           |
| `server.sh`         | Tableau de bord du serveur                        |

## Technologies

Bash · Linux · Apache2 · MariaDB · Pure-FTPd · Quotas disque · SSH · WordPress

## Auteur

**Romain Dacet** — BTS SIO 2025-2026

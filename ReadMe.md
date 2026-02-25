# GSB Feedback - Application de Suivi de Visites Médicales

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Express.js](https://img.shields.io/badge/Express.js-000000?style=for-the-badge&logo=express&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## 📋 Présentation du Projet

**GSB Feedback** est une application mobile et web de gestion des visites médicales, développée pour le laboratoire pharmaceutique fictif **Galaxy-Swiss Bourdin**. Ce projet a été réalisé dans le cadre du **BTS SIO** (Services Informatiques aux Organisations).

L'application a pour but de fluidifier et de moderniser le suivi des interactions entre les visiteurs médicaux, les professionnels de santé (clients) et les responsables régionaux.

---

## 🎯 Objectifs du Projet

Cette application vise à optimiser le processus de suivi des visites :

-   **Organiser les visites médicales** de manière centralisée.
-   **Simplifier la communication** entre les différents acteurs (visiteurs, clients, responsable).
-   **Assurer le suivi en temps réel** des visites réalisées et à venir.
-   **Centraliser les retours et feedbacks** pour améliorer la performance.

---

## 👥 Rôles et Permissions

L'application distingue trois types d'utilisateurs, chacun disposant d'accès et de fonctionnalités spécifiques :

### 🧑‍⚕️ Visiteur Médical

Le visiteur est le principal utilisateur sur le terrain. Il peut :

-   **Consulter le planning** de ses visites assignées.
-   **Accéder aux détails** de chaque rendez-vous.
-   **Créer des comptes-rendus (feedbacks)** après chaque visite.
-   **Visualiser son historique** de visites et de retours.

---

### 🧑 Client (Professionnel de Santé)

Le client est le professionnel de santé qui reçoit le visiteur. Il peut :

-   **Accéder à son espace profil** pour gérer ses informations.
-   **Consulter les visites** prévues à son attention.
-   **Accepter une visite** ou proposer une nouvelle date.
-   **Valider la bonne tenue** d'une visite.
-   **Consulter et valider** les feedbacks soumis par le visiteur.

---

### 🧑‍💼 Responsable

Le responsable supervise l'activité des visiteurs médicaux. Il peut :

-   **Créer et planifier** les visites.
-   **Assigner un visiteur médical** à une visite.
-   **Gérer les échantillons** de produits à présenter.
-   **Superviser le suivi** global des visites et des performances.

---

## 💡 Fonctionnalités Principales

-   **Gestion des Visites :** Création, assignation, et suivi du cycle de vie complet d'une visite.
-   **Gestion des Rôles :** Système d'authentification et de permissions adapté à chaque type d'utilisateur.
-   **Validation et Suivi :** Processus de validation des rendez-vous et des comptes-rendus.
-   **Gestion des Feedbacks :** Formulaires pour la saisie et la consultation des retours post-visite.
-   **Espace Profil Client :** Interface dédiée pour que les clients gèrent leurs informations et interagissent avec le système.
-   **Tableau de Bord :** (Fonctionnalité future) Visualisation des statistiques clés pour chaque rôle.

---

## Workflow d'une Visite

Une visite suit un processus en plusieurs étapes pour garantir un suivi optimal :

1.  **Création :** Le responsable crée la visite et y associe un client.
2.  **Assignation :** Le responsable assigne un visiteur médical et les échantillons nécessaires.
3.  **Planification :** Le client accepte la date proposée ou en suggère une nouvelle.
4.  **Réalisation :** Le visiteur médical effectue la visite chez le client.
5.  **Feedback :** Le visiteur rédige son compte-rendu de la visite.
6.  **Validation :** Le client consulte le feedback et valide la visite.
7.  **Clôture :** La visite est archivée dans l'historique.

---

## 🛠️ Technologies Utilisées

L'application repose sur une architecture moderne et découplée :

-   **Frontend (Mobile & Web) :**
    -   **Flutter :** Pour une expérience utilisateur unifiée sur Android, iOS et le web.
-   **Backend (API) :**
    -   **Node.js & Express :** Pour une API RESTful performante et évolutive.
-   **Base de données :**
    -   **PostgreSQL :** Pour la persistance et la sécurité des données.

---

## 👨‍💻 Auteur

**Nolan Liogier**

-   GitHub : [https://github.com/nolanliogier](https://github.com/nolanliogier)

---

## 📄 Licence

Ce projet est fictif et réalisé dans un cadre pédagogique. Il n'est pas destiné à être distribué sous une licence open-source.

---

## 📝 Contexte Pédagogique

Ce projet a été développé dans le cadre de la formation **BTS SIO** (Services Informatiques aux Organisations), option **SLAM** (Solutions Logicielles et Applications Métier). Il a permis de mettre en pratique les compétences suivantes :

-   Conception et développement d'une application multi-plateformes.
-   Création et consommation d'une API RESTful.
-   Gestion d'une base de données relationnelle.
-   Mise en place d'un système d'authentification et de gestion des rôles.
-   Architecture logicielle (Frontend/Backend).

---

*Dernière mise à jour : 2026*
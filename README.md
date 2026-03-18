# 🛡️ ECP Assurances

### Écoute • Conseil • Prévoyance

**Site vitrine professionnel — Courtier en assurances à Mérignac (33)**

Built with Flutter Web • Firebase • Made with ❤️

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)]()

---



---

## 📸 Aperçu

| Desktop | Mobile |
|---------|--------|
| ![Desktop Preview](docs/screenshots/desktop.png) | ![Mobile Preview](docs/screenshots/mobile.png) |

---

## Fonctionnalités

###  Frontend
- **Site vitrine complet** : Hero, Services, Avantages, CTA, Contact, Footer
- **Animations fluides** : Fade-in, Slide-up, Hover effects, Staggered animations au scroll
- **100% Responsive** : Mobile, Tablette, Desktop (3 breakpoints)
- **Formulaire de contact** avec validation côté client
- **Navigation smooth-scroll** entre les sections
- **Menu hamburger** adaptatif sur mobile
- **Bouton retour en haut** avec apparition conditionnelle

###  Backend
- **Firebase Firestore** : Stockage des leads / demandes de contact
- **Firebase Hosting** : Hébergement gratuit avec SSL
- **EmailJS** : Notifications email automatiques à chaque nouveau lead
- **Firebase Analytics** : Suivi du trafic et des conversions (optionnel)

###  Qualité
- Architecture propre et modulaire (sections, widgets, utils)
- Gestion sécurisée des secrets via `.env`
- Code documenté et maintenable

---

## Stack Technique

| Couche | Technologie | Rôle |
|--------|-------------|------|
| **Framework** | Flutter 3.27+ | UI cross-platform |
| **Langage** | Dart 3.6+ | Logique applicative |
| **Backend** | Firebase Firestore | Base de données NoSQL |
| **Hosting** | Firebase Hosting | CDN + SSL gratuit |
| **Emails** | EmailJS | Envoi d'emails côté client |
| **Fonts** | Google Fonts (Inter) | Typographie professionnelle |
| **Icons** | Material Icons + Font Awesome | Iconographie |
| **Animations** | Flutter built-in + visibility_detector | Animations au scroll |

---

## Installation & Lancement

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.27
- [Firebase CLI](https://firebase.google.com/docs/cli) (pour le déploiement)
- Un compte [Firebase](https://console.firebase.google.com/)

### 1. Cloner le repo

```bash
git clone https://github.com/TON_USERNAME/ecp-assurances.git
cd ecp-assurances
```

### 2. Configurer l'environnement

```bash 
cp .env.example .env
# Éditer .env avec tes clés Firebase et EmailJS
```

### 3. Installer les dépendances

flutter pub get

### 4. Lancer en mode développement

flutter run -d chrome --web-port 8080

### 5. Build de production

flutter build web --release --web-renderer canvaskit

### 6. Déployer sur Firebase
```bash 
firebase login
firebase init hosting   # Sélectionner build/web comme dossier public
firebase deploy --only hosting
```

## Structure du projet
```bash
ecp-assurances/
├── lib/
│   ├── main.dart                    # Point d'entrée
│   ├── app.dart                     # MaterialApp configuration
│   ├── theme/
│   │   └── app_theme.dart           # Couleurs, thème, typographie
│   ├── models/
│   │   └── service_model.dart       # Modèles de données
│   ├── sections/
│   │   ├── home_page.dart           # Page principale (orchestrateur)
│   │   ├── hero_section.dart        # Section héro avec animations
│   │   ├── services_section.dart    # Services Pro & Particuliers
│   │   ├── advantages_section.dart  # Grille des avantages
│   │   ├── cta_section.dart         # Bannière Call-to-Action
│   │   ├── contact_section.dart     # Formulaire de contact
│   │   └── footer_section.dart      # Pied de page
│   ├── widgets/
│   │   ├── nav_bar.dart             # Barre de navigation responsive
│   │   ├── service_card.dart        # Carte service réutilisable
│   │   ├── advantage_card.dart      # Carte avantage réutilisable
│   │   └── responsive_wrapper.dart  # Wrapper responsive
│   └── utils/
│       ├── responsive.dart          # Breakpoints & helpers
│       ├── constants.dart           # Constantes de l'app
│       └── env_config.dart          # Chargement des variables .env
├── web/
│   ├── index.html                   # HTML de base
│   ├── manifest.json                # PWA manifest
│   └── favicon.png                  # Favicon
├── assets/
│   └── images/                      # Images du site
├── docs/
│   └── screenshots/                 # Captures d'écran
├── .env.example                     # Template variables d'environnement
├── .gitignore                       # Fichiers ignorés par Git
├── pubspec.yaml                     # Dépendances Flutter
├── firebase.json                    # Configuration Firebase Hosting
└── README.md                        # Ce fichier
```

Licence

Ce projet est propriétaire. Tous droits réservés © 2026 ECP Assurances SAS.

Le code source est partagé publiquement à des fins de transparence et de portfolio. Toute reproduction ou réutilisation commerciale est interdite sans autorisation écrite.

ECP Assurances — L'assurance d'un bon conseil 🛡️

1, avenue Neil Armstrong — 33700 Mérignac — ORIAS n°20005470
``` 



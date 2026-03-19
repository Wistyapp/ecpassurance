// lib/pages/mentions_legales_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';
import '../utils/ecp_constants.dart';

class MentionsLegalesPage extends StatelessWidget {
  const MentionsLegalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final contentWidth = Responsive.contentWidth(context);

    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 60,
            vertical: isMobile ? 40 : 60,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradient1, AppColors.gradient2],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => context.go('/'),
                    child: Text('Accueil', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.4), size: 16),
                  ),
                  const Text('Mentions légales', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Mentions Légales',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Dernière mise à jour : 23 décembre 2024',
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
              ),
            ],
          ),
        ),

        // Contenu
        Container(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
          color: AppColors.background,
          child: Center(
            child: SizedBox(
              width: contentWidth > 800 ? 800 : contentWidth,
              child: Container(
                padding: EdgeInsets.all(isMobile ? 24 : 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _section('1. Éditeur du site', [
                      'Raison sociale : ${AppConstants.companyName}',
                      'Forme juridique : SAS',
                      'Capital social : 1 000 €',
                      'Siège social : ${AppConstants.address}',
                      'SIRET : ${AppConstants.siret}',
                      'RCS : 828 185 066 R.C.S. Bordeaux',
                      'N° TVA intracommunautaire : FR23828185066',
                      'Email : ${AppConstants.email}',
                      'Téléphone : ${AppConstants.phone}',
                    ]),
                    _section('Immatriculation ORIAS', [
                      'Numéro ORIAS : ${AppConstants.orias}',
                      'ECP Assurances est immatriculé au Registre unique des intermédiaires en assurance, banque et finance (ORIAS) en qualité de Courtier en assurances.',
                      'Vérification sur : www.orias.fr',
                    ]),
                    _section('Responsabilité Civile Professionnelle', [
                      'Assureur : LLOYD\'S',
                      'Couverture géographique : France et Union Européenne',
                    ]),
                    _section('2. Directeur de la publication', [
                      'Nom : Loubacky DElross',
                      'Qualité : Président',
                    ]),
                    _section('3. Hébergement', [
                      'Hébergeur : IONOS SARL',
                      'Adresse : 7 place de la Gare – BP 70109 – 57201 Sarreguemines Cedex',
                      'Téléphone : 0970 808 911',
                      'Site web : www.ionos.fr',
                    ]),
                    _section('4. Propriété intellectuelle', [
                      'L\'ensemble du contenu de ce site (textes, images, vidéos, logos, icônes, etc.) est la propriété exclusive d\'ECP Assurances ou de ses partenaires.',
                      'Toute reproduction, représentation, modification, publication ou adaptation totale ou partielle des éléments du site est interdite sans l\'autorisation écrite préalable d\'ECP Assurances.',
                    ]),
                    _section('5. Protection des données (RGPD)', [
                      'Responsable du traitement : ECP Assurances.',
                      'Données collectées via le formulaire : nom, prénom, email, téléphone, message.',
                      'Finalité : répondre à vos demandes, proposer des devis, assurer le suivi client.',
                      'Durée de conservation : 3 ans à compter du dernier contact.',
                      'Droits : accès, rectification, effacement, limitation, opposition, portabilité.',
                      'Contact : ${AppConstants.email}',
                      'Réclamation : www.cnil.fr',
                    ]),
                    _section('6. Cookies', [
                      'Ce site n\'utilise pas de cookies de traçage publicitaire.',
                      'Des cookies techniques nécessaires au bon fonctionnement du site peuvent être utilisés.',
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _section(String title, List<String> lines) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          ...lines.map((line) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          )),
        ],
      ),
    );
  }
}

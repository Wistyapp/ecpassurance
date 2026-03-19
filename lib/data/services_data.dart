// lib/data/services_data.dart

import 'package:flutter/material.dart';

import '../models/services_model.dart';


class ServicesData {
  static const List<ServiceModel> all = [
    // ═══════════════════════════════════════
    // PROFESSIONNELS
    // ═══════════════════════════════════════
    ServiceModel(
      id: 'multirisque',
      title: 'Multirisque Professionnelle',
      shortTitle: 'Multirisque Pro',
      subtitle: 'Protection complète adaptée à votre secteur d\'activité',
      description: 'Contenu détaillé à venir...', // Ton pote remplira
      icon: Icons.business,
      category: ServiceCategory.professionnel,
      gradient: [Color(0xFF1B3A5C), Color(0xFF2A5298)],
      keyPoints: [
        'Couverture des locaux et du matériel',
        'Protection contre le vol et le vandalisme',
        'Garantie perte d\'exploitation',
        'Responsabilité civile incluse',
        'Adaptée à votre secteur d\'activité',
      ],
    ),
    ServiceModel(
      id: 'rc-pro',
      title: 'Responsabilité Civile Professionnelle',
      shortTitle: 'RC Pro',
      subtitle: 'Protégez-vous contre les réclamations de tiers',
      description: 'Contenu détaillé à venir...',
      icon: Icons.verified_user,
      category: ServiceCategory.professionnel,
      gradient: [Color(0xFF667EEA), Color(0xFF764BA2)],
      keyPoints: [
        'Couverture des dommages causés aux tiers',
        'Protection en cas de faute professionnelle',
        'Prise en charge des frais de défense',
        'Obligatoire pour de nombreuses professions',
        'Montants de garantie adaptés à votre activité',
      ],
    ),
    ServiceModel(
      id: 'decennale',
      title: 'Assurance Décennale',
      shortTitle: 'Décennale',
      subtitle: 'Indispensable pour les métiers du bâtiment',
      description: 'Contenu détaillé à venir...',
      icon: Icons.construction,
      category: ServiceCategory.professionnel,
      gradient: [Color(0xFFE65100), Color(0xFFFF8A65)],
      keyPoints: [
        'Garantie décennale obligatoire (loi Spinetta)',
        'Couverture des dommages structurels',
        'Tous corps de métiers du bâtiment',
        'Attestation délivrée rapidement',
        'Tarifs négociés auprès de nos partenaires',
      ],
    ),
    ServiceModel(
      id: 'flotte-auto',
      title: 'Assurance Flotte Automobile',
      shortTitle: 'Flotte Auto',
      subtitle: 'Gérez votre parc de véhicules en toute sérénité',
      description: 'Contenu détaillé à venir...',
      icon: Icons.directions_car,
      category: ServiceCategory.professionnel,
      gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
      keyPoints: [
        'Gestion centralisée de votre parc',
        'Tarifs dégressifs selon la taille de la flotte',
        'Couverture tous risques ou au tiers',
        'Assistance 24h/24 et 7j/7',
        'Gestion simplifiée des sinistres',
      ],
    ),
    ServiceModel(
      id: 'prevoyance-collective',
      title: 'Prévoyance Collective',
      shortTitle: 'Prévoyance',
      subtitle: 'Protégez vos salariés et leurs familles',
      description: 'Contenu détaillé à venir...',
      icon: Icons.groups,
      category: ServiceCategory.professionnel,
      gradient: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
      keyPoints: [
        'Garantie décès et invalidité',
        'Incapacité temporaire de travail',
        'Rente éducation pour les enfants',
        'Conformité aux obligations conventionnelles',
        'Avantages fiscaux pour l\'entreprise',
      ],
    ),
    ServiceModel(
      id: 'protection-juridique-pro',
      title: 'Protection Juridique Professionnelle',
      shortTitle: 'Protection Juridique Pro',
      subtitle: 'Défendez vos intérêts professionnels',
      description: 'Contenu détaillé à venir...',
      icon: Icons.gavel,
      category: ServiceCategory.professionnel,
      gradient: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
      keyPoints: [
        'Litiges avec les clients et fournisseurs',
        'Conflits avec les salariés',
        'Contentieux administratifs et fiscaux',
        'Prise en charge des frais d\'avocat',
        'Assistance juridique téléphonique',
      ],
    ),
    ServiceModel(
      id: 'cyber-assurance',
      title: 'Cyber-Assurance',
      shortTitle: 'Cyber',
      subtitle: 'Protégez votre entreprise contre les risques numériques',
      description: 'Contenu détaillé à venir...',
      icon: Icons.security,
      category: ServiceCategory.professionnel,
      gradient: [Color(0xFFF093FB), Color(0xFFF5576C)],
      keyPoints: [
        'Protection contre les cyberattaques',
        'Couverture en cas de violation de données',
        'Prise en charge de la gestion de crise',
        'Assistance technique d\'urgence',
        'Conformité RGPD',
      ],
    ),

    // ═══════════════════════════════════════
    // PARTICULIERS
    // ═══════════════════════════════════════
    ServiceModel(
      id: 'habitation',
      title: 'Assurance Habitation',
      shortTitle: 'Habitation',
      subtitle: 'Propriétaire ou locataire, protégez votre foyer',
      description: 'Contenu détaillé à venir...',
      icon: Icons.home,
      category: ServiceCategory.particulier,
      gradient: [Color(0xFF1B3A5C), Color(0xFF3B82F6)],
      keyPoints: [
        'Couverture propriétaire et locataire',
        'Protection contre incendie, dégâts des eaux, vol',
        'Responsabilité civile vie privée incluse',
        'Garantie objets de valeur',
        'Assistance en cas de sinistre',
      ],
    ),
    ServiceModel(
      id: 'auto-moto',
      title: 'Assurance Auto et Moto',
      shortTitle: 'Auto & Moto',
      subtitle: 'Roulez en toute tranquillité',
      description: 'Contenu détaillé à venir...',
      icon: Icons.two_wheeler,
      category: ServiceCategory.particulier,
      gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
      keyPoints: [
        'Formules au tiers, intermédiaire ou tous risques',
        'Assistance dépannage 0 km',
        'Prêt de véhicule en cas de panne',
        'Protection du conducteur',
        'Tarifs compétitifs jeunes conducteurs',
      ],
    ),
    ServiceModel(
      id: 'mutuelle',
      title: 'Mutuelle Santé',
      shortTitle: 'Mutuelle Santé',
      subtitle: 'Des remboursements adaptés à vos besoins',
      description: 'Contenu détaillé à venir...',
      icon: Icons.local_hospital,
      category: ServiceCategory.particulier,
      gradient: [Color(0xFFE91E63), Color(0xFFFF5252)],
      keyPoints: [
        'Remboursements optique, dentaire, hospitalisation',
        'Formules individuelles et familiales',
        'Tiers payant généralisé',
        'Médecines douces prises en charge',
        'Sans délai de carence',
      ],
    ),
    ServiceModel(
      id: 'emprunteur',
      title: 'Assurance Emprunteur',
      shortTitle: 'Emprunteur',
      subtitle: 'Sécurisez votre crédit immobilier',
      description: 'Contenu détaillé à venir...',
      icon: Icons.account_balance,
      category: ServiceCategory.particulier,
      gradient: [Color(0xFFFDA085), Color(0xFFF6D365)],
      keyPoints: [
        'Délégation d\'assurance (loi Lemoine)',
        'Économies jusqu\'à 50% vs banque',
        'Couverture décès, PTIA, ITT, IPT',
        'Questionnaire de santé simplifié',
        'Accompagnement dans le changement',
      ],
    ),
    ServiceModel(
      id: 'accidents-vie',
      title: 'Prévoyance Accidents de la Vie',
      shortTitle: 'Accidents de la vie',
      subtitle: 'Protégez-vous et vos proches face aux imprévus',
      description: 'Contenu détaillé à venir...',
      icon: Icons.health_and_safety,
      category: ServiceCategory.particulier,
      gradient: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
      keyPoints: [
        'Accidents domestiques, sport, loisirs',
        'Indemnisation en cas d\'invalidité',
        'Capital décès accidentel',
        'Couverture mondiale',
        'Protection de toute la famille',
      ],
    ),
    ServiceModel(
      id: 'protection-juridique',
      title: 'Protection Juridique',
      shortTitle: 'Protection Juridique',
      subtitle: 'Défendez vos droits au quotidien',
      description: 'Contenu détaillé à venir...',
      icon: Icons.gavel,
      category: ServiceCategory.particulier,
      gradient: [Color(0xFFA18CD1), Color(0xFFFBC2EB)],
      keyPoints: [
        'Litiges de la vie quotidienne',
        'Conflits de voisinage',
        'Litiges consommation et travaux',
        'Prise en charge des frais d\'avocat',
        'Conseil juridique téléphonique illimité',
      ],
    ),
  ];

  // ─── Helpers ───────────────────────────
  static List<ServiceModel> get professionnels =>
      all.where((s) => s.category == ServiceCategory.professionnel).toList();

  static List<ServiceModel> get particuliers =>
      all.where((s) => s.category == ServiceCategory.particulier).toList();

  static ServiceModel? getById(String id) {
    try {
      return all.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}

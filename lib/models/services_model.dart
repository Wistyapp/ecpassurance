// lib/models/service_model.dart

import 'package:flutter/material.dart';

enum ServiceCategory { professionnel, particulier }

class ServiceModel {
  final String id;           // slug pour l'URL : "rc-pro"
  final String title;        // "Responsabilité Civile Professionnelle"
  final String shortTitle;   // "RC Pro"
  final String subtitle;     // Court résumé
  final String description;  // Description longue (sera remplie plus tard)
  final IconData icon;
  final ServiceCategory category;
  final List<Color> gradient;
  final List<String> keyPoints; // Points clés à afficher
  final String? imageAsset;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.category,
    required this.gradient,
    this.keyPoints = const [],
    this.imageAsset,
  });
}

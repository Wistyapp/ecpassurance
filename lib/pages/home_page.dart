// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../sections/hero_section.dart';
import '../sections/services_section.dart';
import '../sections/advantages_section.dart';
import '../sections/cta_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeroSection(onCtaTap: () => context.go('/contact')),
        ServicesSection(onServiceTap: (_) => context.go('/services')),
        const AdvantagesSection(),
        CtaSection(onCtaTap: () => context.go('/contact')),
      ],
    );
  }
}

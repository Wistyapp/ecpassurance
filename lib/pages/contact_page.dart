// lib/pages/contact_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../sections/contact_section.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        // ── Header ──
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 60,
            vertical: isMobile ? 50 : 70,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.gradient1, AppColors.gradient2, AppColors.gradient3],
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
                  const Text('Contact', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 24),
              const Icon(Icons.mail_outline, color: AppColors.accentLight, size: 40),
              const SizedBox(height: 16),
              Text(
                'Contactez-nous',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 42,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Demandez votre audit gratuit ou un devis personnalisé',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 14 : 17, color: Colors.white.withOpacity(0.85)),
              ),
            ],
          ),
        ),

        // ── Formulaire (réutilisation de la section existante) ──
        const ContactSection(),
      ],
    );
  }
}

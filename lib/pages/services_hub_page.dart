// lib/pages/services_hub_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/services_data.dart';

import '../models/services_model.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';

class ServicesHubPage extends StatefulWidget {
  const ServicesHubPage({super.key});

  @override
  State<ServicesHubPage> createState() => _ServicesHubPageState();
}

class _ServicesHubPageState extends State<ServicesHubPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    // Animation directe au chargement de la page
    Future.delayed(const Duration(milliseconds: 100), () {
      _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final contentWidth = Responsive.contentWidth(context);
    final proServices = ServicesData.professionnels;
    final partServices = ServicesData.particuliers;

    return FadeTransition(
      opacity: _animController,
      child: Column(
        children: [
          // ═══════════════ Header ═══════════════
          _buildHeroHeader(context, isMobile),

          // ═══════════════ Professionnels ═══════════════
          Container(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 80),
            color: AppColors.background,
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  children: [
                    _buildSectionTitle(
                      icon: Icons.business_center,
                      title: 'Solutions Professionnels',
                      subtitle: 'Protégez votre activité, vos salariés et votre patrimoine professionnel',
                      isMobile: isMobile,
                    ),
                    SizedBox(height: isMobile ? 30 : 50),
                    _buildServicesGrid(context, proServices, isMobile),
                  ],
                ),
              ),
            ),
          ),

          // ═══════════════ Particuliers ═══════════════
          Container(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 80),
            color: Colors.white,
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  children: [
                    _buildSectionTitle(
                      icon: Icons.family_restroom,
                      title: 'Solutions Particuliers',
                      subtitle: 'Sécurisez votre quotidien, votre famille et votre patrimoine',
                      isMobile: isMobile,
                    ),
                    SizedBox(height: isMobile ? 30 : 50),
                    _buildServicesGrid(context, partServices, isMobile),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header de page ──
  Widget _buildHeroHeader(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: isMobile ? 50 : 80,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Text(
              'NOS EXPERTISES',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.accentLight,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tous nos services d\'assurance',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 28 : 44,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Découvrez l\'ensemble de nos solutions d\'assurance pour les professionnels et les particuliers. Chaque offre est personnalisable selon votre situation.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 14 : 17,
                color: Colors.white.withOpacity(0.85),
                height: 1.6,
              ),
            ),
          ),

          // ── Breadcrumb ──
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => context.go('/'),
                child: Text(
                  'Accueil',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.4), size: 16),
              ),
              const Text(
                'Services',
                style: TextStyle(
                  color: AppColors.accentLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Titre de section ──
  Widget _buildSectionTitle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isMobile,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: AppColors.primary, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 22 : 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: isMobile ? 13 : 15,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Grille de services ──
  Widget _buildServicesGrid(
      BuildContext context,
      List<ServiceModel> services,
      bool isMobile,
      ) {
    final crossAxisCount = Responsive.gridCrossAxisCount(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isMobile ? 1.6 : 1.35,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return _ServiceHubCard(service: services[index]);
      },
    );
  }
}

// ── Carte service cliquable ──
class _ServiceHubCard extends StatefulWidget {
  final ServiceModel service;
  const _ServiceHubCard({required this.service});

  @override
  State<_ServiceHubCard> createState() => _ServiceHubCardState();
}

class _ServiceHubCardState extends State<_ServiceHubCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/services/${widget.service.id}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -6.0 : 0.0),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? widget.service.gradient[0].withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.service.gradient[0].withOpacity(0.15)
                    : Colors.black.withOpacity(0.04),
                blurRadius: _isHovered ? 25 : 10,
                offset: Offset(0, _isHovered ? 10 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Icône ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: widget.service.gradient),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: _isHovered
                          ? [
                        BoxShadow(
                          color: widget.service.gradient[0].withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                          : [],
                    ),
                    child: Icon(widget.service.icon, color: Colors.white, size: 24),
                  ),
                  AnimatedOpacity(
                    opacity: _isHovered ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // ── Titre ──
              Text(
                widget.service.shortTitle,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),

              // ── Sous-titre ──
              Expanded(
                child: Text(
                  widget.service.subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),

              // ── Lien ──
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _isHovered ? widget.service.gradient[0] : AppColors.primary,
                ),
                child: const Row(
                  children: [
                    Text('En savoir plus'),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

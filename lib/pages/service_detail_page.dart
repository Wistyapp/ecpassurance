// lib/pages/service_detail_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/services_data.dart';
import '../models/services_model.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';
import '../utils/ecp_constants.dart';

class ServiceDetailPage extends StatefulWidget {
  final ServiceModel service;
  const ServiceDetailPage({super.key, required this.service});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _animController.forward();
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
    final service = widget.service;

    // Trouver les services du même type pour les suggestions
    final relatedServices = ServicesData.all
        .where((s) => s.category == service.category && s.id != service.id)
        .take(3)
        .toList();

    return FadeTransition(
      opacity: _animController,
      child: Column(
        children: [
          // ═══════════════ Header gradient ═══════════════
          _buildHeader(context, service, isMobile),

          // ═══════════════ Contenu principal ═══════════════
          Container(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 80),
            color: AppColors.background,
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: isMobile
                    ? Column(
                  children: [
                    _buildMainContent(service, isMobile),
                    const SizedBox(height: 40),
                    _buildSidebar(context, service, isMobile),
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildMainContent(service, isMobile),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 2,
                      child: _buildSidebar(context, service, isMobile),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ═══════════════ Services liés ═══════════════
          if (relatedServices.isNotEmpty)
            _buildRelatedServices(context, relatedServices, isMobile, contentWidth),

          // ═══════════════ CTA ═══════════════
          _buildCtaBanner(context, service, isMobile),
        ],
      ),
    );
  }

  // ── Header ──
  Widget _buildHeader(BuildContext context, ServiceModel service, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: isMobile ? 50 : 70,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            service.gradient[0],
            service.gradient[1],
          ],
        ),
      ),
      child: Column(
        children: [
          // Breadcrumb
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => context.go('/'),
                child: Text('Accueil', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
              ),
              _breadcrumbSeparator(),
              InkWell(
                onTap: () => context.go('/services'),
                child: Text('Services', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
              ),
              _breadcrumbSeparator(),
              Text(
                service.shortTitle,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Icône
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(service.icon, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 20),

          // Catégorie
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              service.category == ServiceCategory.professionnel ? 'PROFESSIONNEL' : 'PARTICULIER',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 1.5),
            ),
          ),
          const SizedBox(height: 16),

          // Titre
          Text(
            service.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 26 : 40,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              service.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 14 : 17,
                color: Colors.white.withOpacity(0.85),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _breadcrumbSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.4), size: 16),
    );
  }

  // ── Contenu principal ──
  Widget _buildMainContent(ServiceModel service, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 36),
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
          // Points clés
          const Text(
            'Points clés',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          ...service.keyPoints.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: service.gradient),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          )),

          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 30),

          // Description (à remplir plus tard par ton pote)
          const Text(
            'Description détaillée',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            service.description.isEmpty || service.description == 'Contenu détaillé à venir...'
                ? 'Cette page sera prochainement enrichie avec une description complète de notre offre ${service.title}. '
                'En attendant, n\'hésitez pas à nous contacter pour obtenir un devis personnalisé ou des informations complémentaires.'
                : service.description,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  // ── Sidebar ──
  Widget _buildSidebar(BuildContext context, ServiceModel service, bool isMobile) {
    return Column(
      children: [
        // ── Carte contact rapide ──
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: service.gradient,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: service.gradient[0].withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.support_agent, color: Colors.white, size: 36),
              const SizedBox(height: 16),
              const Text(
                'Besoin d\'un devis ?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Nos conseillers sont à votre écoute pour étudier votre situation',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.85), height: 1.5),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.go('/contact'),
                  icon: const Icon(Icons.send, size: 18),
                  label: const Text('Demander un devis', style: TextStyle(fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: service.gradient[0],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // url_launcher: tel
                  },
                  icon: const Icon(Icons.phone, size: 18),
                  label: const Text(AppConstants.phone, style: TextStyle(fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.4)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // ── Carte info ──
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Bon à savoir',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _infoRow(Icons.verified, 'Courtier indépendant ORIAS'),
              _infoRow(Icons.compare_arrows, 'Comparaison multi-assureurs'),
              _infoRow(Icons.search_off, 'Audit de vos contrats gratuit'),
              _infoRow(Icons.speed, 'Devis sous 48h'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.success, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // ── Services liés ──
  Widget _buildRelatedServices(
      BuildContext context,
      List<ServiceModel> services,
      bool isMobile,
      double contentWidth,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 50 : 70),
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: contentWidth,
          child: Column(
            children: [
              const Text(
                'Services complémentaires',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ces solutions pourraient aussi vous intéresser',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: services.map((s) => SizedBox(
                  width: isMobile ? double.infinity : 320,
                  child: _RelatedServiceCard(service: s),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Bannière CTA ──
  Widget _buildCtaBanner(BuildContext context, ServiceModel service, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 40),
      padding: EdgeInsets.all(isMobile ? 30 : 50),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gradient1, AppColors.gradient2],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Text(
            'Prêt à optimiser votre ${service.shortTitle} ?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 22 : 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Contactez-nous pour un audit gratuit et un devis personnalisé',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/contact'),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Demander mon devis gratuit', style: TextStyle(fontWeight: FontWeight.w700)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Carte service lié ──
class _RelatedServiceCard extends StatefulWidget {
  final ServiceModel service;
  const _RelatedServiceCard({required this.service});

  @override
  State<_RelatedServiceCard> createState() => _RelatedServiceCardState();
}

class _RelatedServiceCardState extends State<_RelatedServiceCard> {
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
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -4.0 : 0.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.service.gradient[0].withOpacity(0.12)
                    : Colors.black.withOpacity(0.04),
                blurRadius: _isHovered ? 20 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: widget.service.gradient),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.service.icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.service.shortTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.service.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

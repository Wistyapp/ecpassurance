import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';

class ServicesSection extends StatefulWidget {
  final Function(String serviceId)? onServiceTap;
  const ServicesSection({super.key, this.onServiceTap});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  bool _hasAnimated = false;

  final List<_ServiceCategory> _categories = [
    _ServiceCategory(
      title: 'Professionnels',
      subtitle: 'Protection complète pour votre entreprise',
      icon: Icons.business_center,
      color: Theme.of(context).colorScheme.primary,
      services: [
        'Multirisque Professionnelle adaptée à votre secteur',
        'Responsabilité Civile Professionnelle (RC Pro)',
        'Assurance Décennale pour les métiers du bâtiment',
        'Assurance Flotte automobile pour parcs de véhicules',
        'Prévoyance collective pour vos salariés',
        'Protection Juridique professionnelle',
        'Cyber-assurance et protection des données',
      ],
    ),
    _ServiceCategory(
      title: 'Particuliers',
      subtitle: 'Sécurité et sérénité au quotidien',
      icon: Icons.family_restroom,
      color: Theme.of(context).colorScheme.primaryContainer,
      services: [
        'Assurance Habitation (propriétaire et locataire)',
        'Assurance Auto et Moto',
        'Mutuelle Santé et complémentaire',
        'Assurance Emprunteur immobilier',
        'Prévoyance Accidents de la vie',
        'Assurance Dépendance',
        'Garantie Obsèques et capital décès',
        'Protection Juridique',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
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

    return VisibilityDetector(
      key: const Key('services-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_hasAnimated) {
          _hasAnimated = true;
          _animController.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100),
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: Column(
              children: [
                // Titre de section
                _SectionHeader(
                  animation: _animController,
                  overline: 'NOS SERVICES',
                  title: 'Des solutions adaptées à chaque besoin',
                  subtitle: 'Professionnels ou particuliers, nous vous proposons une gamme complète de produits d\'assurance.',
                ),
                SizedBox(height: isMobile ? 40 : 60),

                // Cartes de services
                if (isMobile)
                  Column(
                    children: _categories.map((cat) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _ServiceCard(category: cat, animation: _animController),
                    )).toList(),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _categories.map((cat) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _ServiceCard(category: cat, animation: _animController),
                      ),
                    )).toList(),
                  ),
                const SizedBox(height: 30),
                if (widget.onServiceTap != null)
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => widget.onServiceTap!(''),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text(
                        'Voir tous nos services',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(color: Theme.of(context).colorScheme.primary),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final AnimationController animation;
  final String overline;
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.animation,
    required this.overline,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                overline,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.secondary,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 26 : 38,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final _ServiceCategory category;
  final AnimationController animation;

  const _ServiceCard({required this.category, required this.animation});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.category.color.withOpacity(0.2)
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.06),
                blurRadius: _isHovered ? 30 : 15,
                offset: Offset(0, _isHovered ? 15 : 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header de la carte
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.category.color, widget.category.color.withOpacity(0.8)],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(widget.category.icon, color: Theme.of(context).colorScheme.onSecondary, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.category.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.category.subtitle,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Liste des services
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: widget.category.services.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 3),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.check, color: Theme.of(context).colorScheme.secondary, size: 16),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              service,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onSurface,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<String> services;

  _ServiceCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.services,
  });
}

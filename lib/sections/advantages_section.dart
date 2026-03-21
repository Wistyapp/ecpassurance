import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';

class AdvantagesSection extends StatefulWidget {
  const AdvantagesSection({super.key});

  @override
  State<AdvantagesSection> createState() => _AdvantagesSectionState();
}

class _AdvantagesSectionState extends State<AdvantagesSection>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  bool _hasAnimated = false;

  final List<_Advantage> _advantages = [
    _Advantage(
      icon: Icons.location_on,
      title: 'Expertise Locale',
      description:
      'Basés à Mérignac, nous connaissons parfaitement les besoins des professionnels et particuliers de la Gironde depuis de nombreuses années.',
      gradient: [const Color(0xFF667EEA), const Color(0xFF764BA2)],
    ),
    _Advantage(
      icon: Icons.handshake,
      title: 'Courtage Indépendant',
      description:
      'Aucun lien exclusif avec une compagnie : nous négocions pour vous les meilleures conditions auprès de nos partenaires assureurs.',
      gradient: [const Color(0xFF11998E), const Color(0xFF38EF7D)],
    ),
    _Advantage(
      icon: Icons.search,
      title: 'Audit Gratuit',
      description:
      'Analyse complète de vos contrats actuels pour identifier les économies possibles tout en améliorant votre couverture.',
      gradient: [const Color(0xFFF093FB), const Color(0xFFF5576C)],
    ),
    _Advantage(
      icon: Icons.flash_on,
      title: 'Réactivité',
      description:
      'Un interlocuteur dédié disponible pour répondre rapidement à vos questions et gérer efficacement vos sinistres.',
      gradient: [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
    ),
    _Advantage(
      icon: Icons.tune,
      title: 'Sur-Mesure',
      description:
      'Chaque situation est unique : nous élaborons des solutions d\'assurance parfaitement adaptées à votre profil et vos besoins.',
      gradient: [const Color(0xFFA18CD1), const Color(0xFFFBC2EB)],
    ),
    _Advantage(
      icon: Icons.support_agent,
      title: 'Accompagnement',
      description:
      'De la souscription à la gestion des sinistres, nous vous accompagnons à chaque étape pour votre tranquillité d\'esprit.',
      gradient: [const Color(0xFFFDA085), const Color(0xFFF6D365)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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
    final crossAxisCount = Responsive.gridCrossAxisCount(context);

    return VisibilityDetector(
      key: const Key('advantages-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_hasAnimated) {
          _hasAnimated = true;
          _animController.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: Column(
              children: [
                // Header
                FadeTransition(
                  opacity: _animController,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
                        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'POURQUOI NOUS CHOISIR',
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
                          'Nos engagements à vos côtés',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 26 : 38,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: isMobile ? 40 : 60),

                // Grille des avantages
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 1.4 : 1.25,
                  ),
                  itemCount: _advantages.length,
                  itemBuilder: (context, index) {
                    final delay = index * 0.1;
                    return _AdvantageCard(
                      advantage: _advantages[index],
                      animation: CurvedAnimation(
                        parent: _animController,
                        curve: Interval(delay, (delay + 0.5).clamp(0.0, 1.0), curve: Curves.easeOut),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AdvantageCard extends StatefulWidget {
  final _Advantage advantage;
  final Animation<double> animation;

  const _AdvantageCard({required this.advantage, required this.animation});

  @override
  State<_AdvantageCard> createState() => _AdvantageCardState();
}

class _AdvantageCardState extends State<_AdvantageCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(widget.animation),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()..translate(0.0, _isHovered ? -6.0 : 0.0),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                    : Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.advantage.gradient[0].withOpacity(0.15)
                      : Theme.of(context).colorScheme.shadow.withOpacity(0.04),
                  blurRadius: _isHovered ? 25 : 10,
                  offset: Offset(0, _isHovered ? 10 : 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icône avec gradient
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: widget.advantage.gradient),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isHovered
                        ? [
                      BoxShadow(
                        color: widget.advantage.gradient[0].withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ]
                        : [],
                  ),
                  child: Icon(widget.advantage.icon, color: Theme.of(context).colorScheme.onSecondary, size: 26),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.advantage.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    widget.advantage.description,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.6,
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

class _Advantage {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradient;

  _Advantage({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });
}

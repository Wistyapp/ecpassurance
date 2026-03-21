import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';

class CtaSection extends StatefulWidget {
  final VoidCallback onCtaTap;
  const CtaSection({super.key, required this.onCtaTap});

  @override
  State<CtaSection> createState() => _CtaSectionState();
}

class _CtaSectionState extends State<CtaSection> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _hasAnimated = false;

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

    return VisibilityDetector(
      key: const Key('cta-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_hasAnimated) {
          _hasAnimated = true;
          _animController.forward();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 60,
          vertical: isMobile ? 40 : 60,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Décorations
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.03),
                ),
              ),
            ),

            // Contenu
            FadeTransition(
              opacity: _animController,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 32 : 60),
                child: Column(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                      size: isMobile ? 40 : 50,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Optimisez vos assurances\ndès aujourd\'hui',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 36,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onPrimary,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 550),
                      child: Text(
                        'Bénéficiez d\'un audit gratuit de vos contrats actuels. Découvrez comment combiner meilleure protection et économies substantielles.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 17,
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.85),
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _CtaButton(onTap: widget.onCtaTap),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  final VoidCallback onTap;
  const _CtaButton({required this.onTap});

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: ElevatedButton.icon(
          onPressed: widget.onTap,
          icon: const Icon(Icons.arrow_forward),
          label: const Text(
            'Demander mon audit gratuit',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 22),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: _isHovered ? 12 : 4,
          ),
        ),
      ),
    );
  }
}

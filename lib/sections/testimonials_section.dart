import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';
import '../widgets/testimonial_card.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  bool _hasAnimated = false;

  final List<_Testimonial> _testimonials = [
    _Testimonial(
      quote: 'Grâce à ECP Assurances, nous avons réduit nos coûts de 30% tout en améliorant notre couverture. Leur expertise locale fait toute la différence.',
      author: 'Sophie Martin',
      role: 'Gérante, Boulangerie "Le Fournil"',
      avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),
    _Testimonial(
      quote: 'Un service réactif et des conseils personnalisés. Ils ont su comprendre nos besoins spécifiques en tant qu\'artisan.',
      author: 'Thomas Dubois',
      role: 'Artisan Menuisier',
      avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    ),
    _Testimonial(
      quote: 'L\'audit gratuit a révélé des lacunes dans nos contrats précédents. Nous sommes maintenant parfaitement couverts.',
      author: 'Claire Lambert',
      role: 'Directrice, Restaurant "Le Bistrot"',
      avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
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
      key: const Key('testimonials-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_hasAnimated) {
          _hasAnimated = true;
          _animController.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
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
                            'TÉMOIGNAGES CLIENTS',
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
                          'Ce que nos clients disent de nous',
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

                // Grille des témoignages
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: isMobile ? 1.4 : 1.25,
                  ),
                  itemCount: _testimonials.length,
                  itemBuilder: (context, index) {
                    final delay = index * 0.1;
                    return TestimonialCard(
                      quote: _testimonials[index].quote,
                      author: _testimonials[index].author,
                      role: _testimonials[index].role,
                      avatarUrl: _testimonials[index].avatarUrl,
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

class _Testimonial {
  final String quote;
  final String author;
  final String role;
  final String? avatarUrl;

  _Testimonial({
    required this.quote,
    required this.author,
    required this.role,
    this.avatarUrl,
  });
}

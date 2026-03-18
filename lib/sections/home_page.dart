import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'hero_section.dart';
import 'services_section.dart';
import 'advantages_section.dart';
import 'cta_section.dart';
import 'contact_section.dart';
import 'footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _advantagesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showBackToTop = _scrollController.offset > 400;
      });
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: NavBar(
                  onHomeTap: () => _scrollToSection(_heroKey),
                  onServicesTap: () => _scrollToSection(_servicesKey),
                  onAdvantagesTap: () => _scrollToSection(_advantagesKey),
                  onContactTap: () => _scrollToSection(_contactKey),
                ),
              ),
              SliverToBoxAdapter(
                child: HeroSection(key: _heroKey, onCtaTap: () => _scrollToSection(_contactKey)),
              ),
              SliverToBoxAdapter(
                child: ServicesSection(key: _servicesKey),
              ),
              SliverToBoxAdapter(
                child: AdvantagesSection(key: _advantagesKey),
              ),
              SliverToBoxAdapter(
                child: CtaSection(onCtaTap: () => _scrollToSection(_contactKey)),
              ),
              SliverToBoxAdapter(
                child: ContactSection(key: _contactKey),
              ),
              SliverToBoxAdapter(
                child: const FooterSection(),
              ),
            ],
          ),
          // Bouton retour en haut
          if (_showBackToTop)
            Positioned(
              bottom: 30,
              right: 30,
              child: AnimatedOpacity(
                opacity: _showBackToTop ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: const Color(0xFF1B3A5C),
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// lib/layouts/main_layout.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/nav_bar.dart';
import '../sections/footer_section.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String currentPath;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;
  bool _navElevated = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final newShowBack = offset > 400;
    final newElevated = offset > 50;
    if (newShowBack != _showBackToTop || newElevated != _navElevated) {
      setState(() {
        _showBackToTop = newShowBack;
        _navElevated = newElevated;
      });
    }
  }

  // Scroll en haut à chaque changement de route
  @override
  void didUpdateWidget(covariant MainLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPath != widget.currentPath) {
      // Petit délai pour laisser la page se construire
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ═══════════════ Contenu scrollable ═══════════════
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 80), // espace pour la navbar fixe
                  widget.child,               // ← la page courante
                  const FooterSection(),
                ],
              ),
            ),
          ),

          // ═══════════════ NavBar fixe ═══════════════
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: _navElevated
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  )
                ]
                    : [],
              ),
              child: SafeArea(
                bottom: false,
                child: NavBar(
                  currentPath: widget.currentPath,
                  onHomeTap: () => context.go('/'),
                  onServicesTap: () => context.go('/services'),
                  onAdvantagesTap: () {
                    // Si on est sur home, scroll vers avantages
                    // Sinon, aller sur home
                    if (widget.currentPath == '/') {
                      // On dispatch un event pour scroller
                      // (voir home_page.dart)
                      _scrollToAdvantages();
                    } else {
                      context.go('/');
                    }
                  },
                  onContactTap: () => context.go('/contact'),
                ),
              ),
            ),
          ),

          // ═══════════════ Bouton retour en haut ═══════════════
          Positioned(
            bottom: 30,
            right: 30,
            child: AnimatedScale(
              scale: _showBackToTop ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: const Color(0xFF1B3A5C),
                onPressed: _scrollToTop,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToAdvantages() {
    // Scroll approximatif vers la section avantages sur la home
    // On pourra améliorer avec un GlobalKey si besoin
    _scrollController.animateTo(
      1500, // valeur approximative, à ajuster
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}

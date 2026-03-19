// lib/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/services_data.dart';
import '../layouts/main_layout.dart';
import '../pages/contact_page.dart';
import '../pages/mentions_legales_page.dart';
import '../pages/not_found_page.dart';
import '../pages/service_detail_page.dart';
import '../pages/services_hub_page.dart';
import '../sections/home_page.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    // ─── 404 ──────────────────────────────
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const NotFoundPage(),
    ),

    // ─── Routes ───────────────────────────
    routes: [
      // Shell route = layout partagé (navbar + footer)
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(
            currentPath: state.uri.toString(),
            child: child,
          );
        },
        routes: [
          // ── Accueil ──
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const HomePage(),
            ),
          ),

          // ── Hub Services ──
          GoRoute(
            path: '/services',
            name: 'services',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const ServicesHubPage(),
            ),
            routes: [
              // ── Détail Service (route dynamique) ──
              GoRoute(
                path: ':serviceId',
                name: 'service-detail',
                pageBuilder: (context, state) {
                  final serviceId = state.pathParameters['serviceId']!;
                  final service = ServicesData.getById(serviceId);

                  if (service == null) {
                    return _buildPage(
                      key: state.pageKey,
                      child: const NotFoundPage(),
                    );
                  }

                  return _buildPage(
                    key: state.pageKey,
                    child: ServiceDetailPage(service: service),
                  );
                },
              ),
            ],
          ),

          // ── Contact ──
          GoRoute(
            path: '/contact',
            name: 'contact',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const ContactPage(),
            ),
          ),

          // ── Mentions légales ──
          GoRoute(
            path: '/mentions-legales',
            name: 'mentions-legales',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const MentionsLegalesPage(),
            ),
          ),
        ],
      ),
    ],
  );

  // ─── Transition de page personnalisée ───
  static CustomTransitionPage _buildPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }
}

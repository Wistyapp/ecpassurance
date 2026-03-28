import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/services_data.dart';
import '../layouts/main_layout.dart';
import '../layouts/admin_layout.dart';
import '../pages/admin_login_page.dart';
import '../pages/admin_dashboard_page.dart';
import '../pages/admin_leads_page.dart';
import '../pages/contact_page.dart';
import '../pages/home_page.dart';
import '../pages/mentions_legales_page.dart';
import '../pages/not_found_page.dart';
import '../pages/service_detail_page.dart';
import '../pages/services_hub_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    // ─── 404 ──────────────────────────────
    errorPageBuilder: (context, state) =>
        MaterialPage(key: state.pageKey, child: const NotFoundPage()),

    // ─── Routes ───────────────────────────
    routes: [
      // Shell route = layout partagé (navbar + footer)
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(currentPath: state.uri.toString(), child: child);
        },
        routes: [
          // ── Accueil ──
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const HomePage(),
              title: 'ECP Assurances | Courtier en assurances à Mérignac',
            ),
          ),

          // ── Hub Services ──
          GoRoute(
            path: '/services',
            name: 'services',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const ServicesHubPage(),
              title: 'Nos Services | ECP Assurances',
            ),
            routes: [
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
                      title: '404 | ECP Assurances',
                    );
                  }
                  return _buildPage(
                    key: state.pageKey,
                    child: ServiceDetailPage(service: service),
                    title: '${service.shortTitle} | ECP Assurances',
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
              title: 'Contact | ECP Assurances',
            ),
          ),

          // ==== Admin routes ====
          GoRoute(
            path: '/admin/login',
            name: 'admin-login',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const AdminLoginPage(),
              title: 'Login Admin',
            ),
          ),
          GoRoute(
            path: '/admin',
            name: 'admin-dashboard',
            redirect: (context, state) {
              final auth = context.read<AuthProvider>();
              return auth.isAuthenticated ? null : '/admin/login';
            },
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const AdminDashboardPage(),
              title: 'Dashboard Admin',
            ),
          ),
          GoRoute(
            path: '/admin/leads',
            name: 'admin-leads',
            redirect: (context, state) {
              final auth = context.read<AuthProvider>();
              return auth.isAuthenticated ? null : '/admin/login';
            },
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const AdminLeadsPage(),
              title: 'Leads Admin',
            ),
          ),

          // ── Mentions légales ──
          GoRoute(
            path: '/mentions-legales',
            name: 'mentions-legales',
            pageBuilder: (context, state) => _buildPage(
              key: state.pageKey,
              child: const MentionsLegalesPage(),
              title: 'Mentions Légales | ECP Assurances',
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
    String title = 'ECP Assurances',
  }) {
    return CustomTransitionPage(
      key: key,
      child: Title(title: title, color: const Color(0xFF1B3A5C), child: child),
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
    );
  }
}

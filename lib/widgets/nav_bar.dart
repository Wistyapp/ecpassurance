// lib/widgets/nav_bar.dart — VERSION AVEC ROUTING

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';
import '../providers/theme_provider.dart';

class NavBar extends StatefulWidget {
  final String currentPath;
  final VoidCallback onHomeTap;
  final VoidCallback onServicesTap;
  final VoidCallback onAdvantagesTap;
  final VoidCallback onContactTap;

  const NavBar({
    super.key,
    required this.currentPath,
    required this.onHomeTap,
    required this.onServicesTap,
    required this.onAdvantagesTap,
    required this.onContactTap,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isMenuOpen = false;

  @override
  void didUpdateWidget(covariant NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fermer le menu quand la route change
    if (oldWidget.currentPath != widget.currentPath && _isMenuOpen) {
      setState(() => _isMenuOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ── Logo ──
              InkWell(
                onTap: widget.onHomeTap,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryLight],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ECP',
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                            letterSpacing: 2,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'ASSURANCES',
                          style: TextStyle(
                            fontSize: isMobile ? 9 : 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Navigation Desktop ──
              if (!isMobile)
                Row(
                  children: [
                    _NavItem(
                      label: 'Accueil',
                      isActive: widget.currentPath == '/',
                      onTap: widget.onHomeTap,
                    ),
                    _NavItem(
                      label: 'Services',
                      isActive: widget.currentPath.startsWith('/services'),
                      onTap: widget.onServicesTap,
                    ),
                    _NavItem(
                      label: 'Nos atouts',
                      isActive: false,
                      onTap: widget.onAdvantagesTap,
                    ),
                    const SizedBox(width: 16),
                    _ContactButton(
                      isActive: widget.currentPath == '/contact',
                      onTap: widget.onContactTap,
                    ),
                    const SizedBox(width: 16),
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return _ThemeToggleButton(
                          isDarkMode: themeProvider.isDarkMode,
                          onToggle: () => themeProvider.toggleTheme(),
                        );
                      },
                    ),
                  ],
                ),

              // ── Hamburger Mobile ──
              if (isMobile)
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      _isMenuOpen ? Icons.close : Icons.menu,
                      key: ValueKey(_isMenuOpen),
                      color: AppColors.primary,
                    ),
                  ),
                  onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
                ),
            ],
          ),

          // ── Menu Mobile ──
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  _MobileNavItem(
                    label: 'Accueil',
                    isActive: widget.currentPath == '/',
                    onTap: () { widget.onHomeTap(); setState(() => _isMenuOpen = false); },
                  ),
                  _MobileNavItem(
                    label: 'Services',
                    isActive: widget.currentPath.startsWith('/services'),
                    onTap: () { widget.onServicesTap(); setState(() => _isMenuOpen = false); },
                  ),
                  _MobileNavItem(
                    label: 'Nos atouts',
                    isActive: false,
                    onTap: () { widget.onAdvantagesTap(); setState(() => _isMenuOpen = false); },
                  ),
                  _MobileNavItem(
                    label: 'Contact',
                    isActive: widget.currentPath == '/contact',
                    onTap: () { widget.onContactTap(); setState(() => _isMenuOpen = false); },
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: _ContactButton(
                      isActive: widget.currentPath == '/contact',
                      onTap: () { widget.onContactTap(); setState(() => _isMenuOpen = false); },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return _ThemeToggleButton(
                        isDarkMode: themeProvider.isDarkMode,
                        onToggle: () => themeProvider.toggleTheme(),
                      );
                    },
                  ),
                ],
              ),
            ),
            crossFadeState: _isMenuOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

// ── NavItem avec indicateur actif ──
class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.isActive, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final showUnderline = _isHovered || widget.isActive;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
                  color: widget.isActive
                      ? AppColors.primary
                      : (_isHovered ? AppColors.primaryLight : AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2.5,
                width: showUnderline ? 30 : 0,
                decoration: BoxDecoration(
                  color: widget.isActive ? AppColors.primary : AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _MobileNavItem({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? AppColors.primary : AppColors.textPrimary,
        ),
      ),
      onTap: onTap,
      trailing: Icon(
        isActive ? Icons.circle : Icons.arrow_forward_ios,
        size: isActive ? 8 : 14,
        color: isActive ? AppColors.accent : null,
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isActive;
  const _ContactButton({required this.onTap, required this.isActive});

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton.icon(
          onPressed: widget.onTap,
          icon: const Icon(Icons.calendar_today, size: 16),
          label: const Text('Audit gratuit'),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isActive
                ? AppColors.accent
                : (_isHovered ? AppColors.primaryLight : AppColors.primary),
            foregroundColor: widget.isActive ? AppColors.primary : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: _isHovered ? 8 : 2,
          ),
        ),
      ),
    );
  }
}

// ── Theme Toggle Button ──
class _ThemeToggleButton extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const _ThemeToggleButton({
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  State<_ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<_ThemeToggleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.accent.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 20,
                color: widget.isDarkMode ? AppColors.accent : AppColors.primary,
              ),
              const SizedBox(width: 8),
              if (!Responsive.isMobile(context))
                Text(
                  widget.isDarkMode ? 'Mode sombre' : 'Mode clair',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.isDarkMode ? AppColors.accent : AppColors.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
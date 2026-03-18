import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';


class NavBar extends StatefulWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onServicesTap;
  final VoidCallback onAdvantagesTap;
  final VoidCallback onContactTap;

  const NavBar({
    super.key,
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
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              InkWell(
                onTap: widget.onHomeTap,
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

              // Navigation desktop
              if (!isMobile)
                Row(
                  children: [
                    _NavItem(label: 'Accueil', onTap: widget.onHomeTap),
                    _NavItem(label: 'Services', onTap: widget.onServicesTap),
                    _NavItem(label: 'Nos atouts', onTap: widget.onAdvantagesTap),
                    const SizedBox(width: 16),
                    _ContactButton(onTap: widget.onContactTap),
                  ],
                ),

              // Hamburger menu mobile
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

          // Menu mobile déroulant
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  _MobileNavItem(label: 'Accueil', onTap: () { widget.onHomeTap(); setState(() => _isMenuOpen = false); }),
                  _MobileNavItem(label: 'Services', onTap: () { widget.onServicesTap(); setState(() => _isMenuOpen = false); }),
                  _MobileNavItem(label: 'Nos atouts', onTap: () { widget.onAdvantagesTap(); setState(() => _isMenuOpen = false); }),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: _ContactButton(onTap: () { widget.onContactTap(); setState(() => _isMenuOpen = false); }),
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

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _isHovered ? AppColors.primaryLight : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 30 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(1),
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
  final VoidCallback onTap;
  const _MobileNavItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ContactButton({required this.onTap});

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
            backgroundColor: _isHovered ? AppColors.primaryLight : AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: _isHovered ? 8 : 2,
          ),
        ),
      ),
    );
  }
}

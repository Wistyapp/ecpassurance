import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/ecp_responsive.dart';
import '../utils/ecp_constants.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final year = DateTime.now().year;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: 40,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primary,
      ),
      child: Column(
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 24),
                _buildLegalInfo(),
                const SizedBox(height: 24),
                _buildContactFooter(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildLogo()),
                Expanded(flex: 2, child: _buildLegalInfo()),
                Expanded(flex: 2, child: _buildContactFooter()),
              ],
            ),
          const SizedBox(height: 30),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              Text(
                '© $year ${AppConstants.companyName} - Tous droits réservés',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                'ORIAS n°${AppConstants.orias}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.shield_outlined, color: AppColors.accent, size: 22),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ECP',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'ASSURANCES',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          AppConstants.tagline,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.6),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildLegalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informations légales',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        _FooterLink(label: 'SIRET : ${AppConstants.siret}'),
        _FooterLink(label: 'ORIAS : ${AppConstants.orias}'),
        _FooterLink(label: 'RC Pro : Lloyd\'s'),
        _FooterLink(label: 'Mentions légales', isLink: true),
      ],
    );
  }

  Widget _buildContactFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        _FooterLink(label: AppConstants.phone, icon: Icons.phone),
        _FooterLink(label: AppConstants.email, icon: Icons.email),
        _FooterLink(label: AppConstants.address, icon: Icons.location_on),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool isLink;
  final VoidCallback? onTap;

  const _FooterLink({
    required this.label,
    this.icon,
    this.isLink = false,
    this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = widget.isLink),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.isLink ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: Colors.white.withOpacity(0.4), size: 14),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(
                      _isHovered ? 0.9 : (widget.isLink ? 0.7 : 0.5),
                    ),
                    decoration: widget.isLink ? TextDecoration.underline : null,
                    decorationColor: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TestimonialCard extends StatefulWidget {
  final String quote;
  final String author;
  final String role;
  final String? avatarUrl;
  final Animation<double> animation;

  const TestimonialCard({
    super.key,
    required this.quote,
    required this.author,
    required this.role,
    this.avatarUrl,
    required this.animation,
  });

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
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
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? AppColors.accent.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? AppColors.accent.withOpacity(0.15)
                      : Colors.black.withOpacity(0.04),
                  blurRadius: _isHovered ? 25 : 10,
                  offset: Offset(0, _isHovered ? 10 : 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quote
                Text(
                  widget.quote,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                // Author info
                Row(
                  children: [
                    if (widget.avatarUrl != null) ...[
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.avatarUrl!),
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                    ],
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.author,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          widget.role,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

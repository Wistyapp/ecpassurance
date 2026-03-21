import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final Widget child;

  const PageTitle({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    // Met à jour le titre du navigateur
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: undefined_prefixed_name
      // Pour Flutter Web, on utilise le package html
    });
    return Title(
      title: title,
      color: const Color(0xFF1B3A5C),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

/// Layout widget used for all admin pages.
/// Provides a persistent sidebar navigation and an AppBar.
class AdminLayout extends StatelessWidget {
  final Widget child;
  final String? currentPath;

  const AdminLayout({super.key, required this.child, this.currentPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back‑Office Admin'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Admin Menu', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pushReplacementNamed(context, '/admin'),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Leads'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/admin/leads'),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, '/admin/login'),
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}

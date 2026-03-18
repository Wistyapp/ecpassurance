import 'package:ecpassurances/sections/home_page.dart';
import 'package:ecpassurances/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ECPApp());
}

class ECPApp extends StatelessWidget {
  const ECPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECP Assurances - Courtier en assurances à Mérignac',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
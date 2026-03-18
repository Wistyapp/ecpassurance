// lib/utils/env_config.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get firebaseApiKey =>
      dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  static String get firebaseMessagingSenderId =>
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseAppId =>
      dotenv.env['FIREBASE_APP_ID'] ?? '';
  static String get firebaseMeasurementId =>
      dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';

  static String get emailjsServiceId =>
      dotenv.env['EMAILJS_SERVICE_ID'] ?? '';
  static String get emailjsTemplateId =>
      dotenv.env['EMAILJS_TEMPLATE_ID'] ?? '';
  static String get emailjsPublicKey =>
      dotenv.env['EMAILJS_PUBLIC_KEY'] ?? '';

  static bool get isDebug =>
      dotenv.env['APP_DEBUG']?.toLowerCase() == 'true';
  static String get appEnv =>
      dotenv.env['APP_ENV'] ?? 'development';
}

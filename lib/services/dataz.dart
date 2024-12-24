import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: ".env");
    if (kDebugMode) {
      print("Environment variables loaded successfully!");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error loading environment variables: $e");
    }
  }
}

// Use getters to access the environment variables
Future<String> getPublishableKey() async {
  await loadEnv();  // Ensure that dotenv is loaded
  String? key = dotenv.env['PUBLISHABLE_KEY'];
  if (key == null) {
    throw Exception("PUBLISHABLE_KEY not found in .env file");
  }
  return key;
}

Future<String> getSecretKey() async {
  await loadEnv();  // Ensure that dotenv is loaded
  String? key = dotenv.env['SECRET_KEY'];
  if (key == null) {
    throw Exception("SECRET_KEY not found in .env file");
  }
  return key;
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  const Environments._();

  static String? params(String paramName) => dotenv.env[paramName];

  static Future<void> loadEnvs() async => await dotenv.load();
}

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initEnvironment() async {
    await dotenv.load();
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'There isnt a api url configured';
}

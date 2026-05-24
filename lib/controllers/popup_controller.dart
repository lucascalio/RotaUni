import 'package:shared_preferences/shared_preferences.dart';

class PopupController {

  static Future<bool> deveMostrarPopup() async {

    final prefs = await SharedPreferences.getInstance();

    final ultimaData = prefs.getString('popup_data');

    final hoje = DateTime.now().toIso8601String().split('T')[0];

    final weekday = DateTime.now().weekday;

    // só segunda a sexta
    if (weekday < 1 || weekday > 5) return false;

    // só mostra se NÃO mostrou hoje
    if (ultimaData == hoje) return false;

    return true;
  }

  static Future<void> salvarResposta() async {

    final prefs = await SharedPreferences.getInstance();

    final hoje = DateTime.now().toIso8601String().split('T')[0];

    await prefs.setString('popup_data', hoje);
  }
}
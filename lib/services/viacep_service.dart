import 'dart:convert';
import 'package:http/http.dart' as http;

class ViaCepService {

  static Future<Map<String, dynamic>?>
  buscarCEP(String cep) async {

    final url =
    Uri.parse(
      'https://viacep.com.br/ws/$cep/json/',
    );

    final response =
    await http.get(url);

    if(response.statusCode == 200) {

      return jsonDecode(response.body);
    }

    return null;
  }
}
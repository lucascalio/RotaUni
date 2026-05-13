import 'dart:convert';
import 'package:http/http.dart' as http;

class CepService {
  static Future<String> getEndereco(String cep) async {
    final res =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    final data = jsonDecode(res.body);

    return "${data['logradouro']} - ${data['localidade']}";
  }
}
import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashUtil {
  static String gerarHash(String senha) {
    final bytes = utf8.encode(senha);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {

  final FirebaseFirestore _firestore =
  FirebaseFirestore.instance;

  Future<void> salvarUsuario({

    required String uid,
    required String nome,
    required String celular,
    required String endereco,
    required String email,
    required String tipoUsuario,

  }) async {

    await _firestore
        .collection('users')
        .doc(uid)
        .set({

      'nome': nome,
      'celular': celular,
      'endereco': endereco,
      'email': email,
      'tipoUsuario': tipoUsuario,
    });
  }
}
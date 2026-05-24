import 'package:firebase_auth/firebase_auth.dart';

class AuthController {

  final FirebaseAuth _auth =
  FirebaseAuth.instance;

  Future<String?> login(
      String email,
      String senha,
      ) async {

    try {

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;
    }
  }

  Future<String?> cadastrar(
      String email,
      String senha,
      ) async {

    try {

      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
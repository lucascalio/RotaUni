import '../models/user_model.dart';

class UserController {

  final List<UserModel> _usuarios = [];

  void cadastrarUsuario(UserModel user) {
    _usuarios.add(user);
  }

  List<UserModel> listarUsuarios() {
    return _usuarios;
  }
}
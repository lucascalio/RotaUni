import '../models/user_model.dart';
import '../services/db_service.dart';

class UserController {

  Future<bool> inserir(User user) async {
    final db = await DBService.database();

    try {
      await db.insert('users', user.toMap());
      return true;
    } catch (e) {
      return false; // usuário já existe (username UNIQUE)
    }
  }

  Future<User?> login(String username, String senha, String tipo) async {
    final db = await DBService.database();

    final result = await db.query(
      'users',
      where: 'username = ? AND senha = ? AND tipo = ?',
      whereArgs: [username, senha, tipo],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }

    return null;
  }

  Future<List<User>> listar() async {
    final db = await DBService.database();
    final result = await db.query('users');

    return result.map((e) => User.fromMap(e)).toList();
  }

  Future<void> atualizarVai(int userId, int vai) async {
    final db = await DBService.database();

    await db.update(
      'users',
      {'vai': vai},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}
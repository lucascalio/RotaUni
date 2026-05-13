import '../models/user_model.dart';
import '../services/db_service.dart';

class UserController {

  Future<void> inserir(User user) async {
    final db = await DBService.database();
    await db.insert('users', user.toMap());
  }

  Future<List<User>> listar() async {
    final db = await DBService.database();
    final result = await db.query('users');

    return result.map((e) => User.fromMap(e)).toList();
  }

  Future<void> atualizarVai(User user, int vai) async {
    final db = await DBService.database();

    await db.update(
      'users',
      {'vai': vai},
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
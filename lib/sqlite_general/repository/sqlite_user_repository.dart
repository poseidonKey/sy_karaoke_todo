import 'package:sqflite/sqflite.dart';
import 'package:sy_karaoke_todo/sqlite_general/models/sqlite_user_model.dart';

import '../db/local_database.dart';

class UserRepository {
  final Future<Database> _db = LocalDatabase.instance.database;

  /// 유저 추가
  Future<int> insertUser(SqlUserModel user) async {
    final db = await _db;
    return await db.insert('users', user.toMap());
  }

  /// 유저 전체 조회
  Future<List<SqlUserModel>> getAllUsers() async {
    final db = await _db;
    final result = await db.query('users');
    return result.map((e) => SqlUserModel.fromMap(e)).toList();
  }

  /// 유저 단건 조회 (id 기준)
  Future<SqlUserModel?> getUserById(int id) async {
    final db = await _db;
    final result = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return SqlUserModel.fromMap(result.first);
    }
    return null;
  }

  /// 유저 삭제
  Future<int> deleteUser(int id) async {
    final db = await _db;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  /// 유저 전체 삭제
  Future<int> clearUsers() async {
    final db = await _db;
    return await db.delete('users');
  }
}

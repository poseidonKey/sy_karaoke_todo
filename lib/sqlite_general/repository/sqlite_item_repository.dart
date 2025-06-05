import 'package:sqflite/sqflite.dart';

import '../db/local_database.dart';
import '../models/sqlite_item_model.dart';

class ItemRepository {
  final Future<Database> _db = LocalDatabase.instance.database;

  /// 아이템 추가
  Future<int> insertItem(SqlItemModel item) async {
    final db = await _db;
    return await db.insert('items', item.toMap());
  }

  /// 특정 카테고리의 아이템 목록 조회
  Future<List<SqlItemModel>> getItemsByCategoryId(int categoryId) async {
    final db = await _db;
    final result = await db.query(
      'items',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'createdAt DESC',
    );
    return result.map((e) => SqlItemModel.fromMap(e)).toList();
  }

  /// 아이템 단건 조회
  Future<SqlItemModel?> getItemById(int id) async {
    final db = await _db;
    final result = await db.query('items', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return SqlItemModel.fromMap(result.first);
    }
    return null;
  }

  /// 아이템 수정
  Future<int> updateItem(SqlItemModel item) async {
    final db = await _db;
    return await db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  /// 아이템 삭제
  Future<int> deleteItem(int id) async {
    final db = await _db;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }

  /// 특정 카테고리의 아이템 모두 삭제 (예: 카테고리 삭제 시)
  Future<int> deleteItemsByCategoryId(int categoryId) async {
    final db = await _db;
    return await db.delete(
      'items',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
  }

  /// 전체 아이템 삭제 (테스트용)
  Future<int> clearItems() async {
    final db = await _db;
    return await db.delete('items');
  }
}

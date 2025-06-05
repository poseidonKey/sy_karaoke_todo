import 'package:sqflite/sqflite.dart';
import 'package:sy_karaoke_todo/sqlite_general/models/sqlite_category_model.dart';

import '../db/local_database.dart';

class CategoryRepository {
  final Future<Database> _db = LocalDatabase.instance.database;

  /// 카테고리 추가
  Future<int> insertCategory(SqlCategoryModel category) async {
    final db = await _db;
    return await db.insert('categories', category.toMap());
  }

  /// 특정 유저의 카테고리 목록 조회
  Future<List<SqlCategoryModel>> getCategoriesByUserId(int userId) async {
    final db = await _db;
    final result = await db.query(
      'categories',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
    return result.map((e) => SqlCategoryModel.fromMap(e)).toList();
  }

  /// 카테고리 단건 조회
  Future<SqlCategoryModel?> getCategoryById(int id) async {
    final db = await _db;
    final result = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return SqlCategoryModel.fromMap(result.first);
    }
    return null;
  }

  /// 카테고리 수정
  Future<int> updateCategory(SqlCategoryModel category) async {
    final db = await _db;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  /// 카테고리 삭제
  Future<int> deleteCategory(int id) async {
    final db = await _db;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  /// 전체 카테고리 삭제 (테스트용)
  Future<int> clearCategories() async {
    final db = await _db;
    return await db.delete('categories');
  }

  Future<int> deleteCategoryWithItems(int categoryId) async {
    final db = await _db;
    return await db.transaction((txn) async {
      await txn.delete(
        'items',
        where: 'categoryId = ?',
        whereArgs: [categoryId],
      );
      return await txn.delete(
        'categories',
        where: 'id = ?',
        whereArgs: [categoryId],
      );
    });
  }
}

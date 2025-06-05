import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/category.dart';
import 'tables/item.dart';
import 'tables/user.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Categories, Items])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Optional: Clear all tables
  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(items).go();
      await delete(categories).go();
      await delete(users).go();
    });
  }

  // Category 관련 CRUD
  Future<List<Category>> getCategoriesByUserId(int userId) {
    return (select(
      categories,
    )..where((tbl) => tbl.userId.equals(userId))).get();
  }

  Future<int> insertCategory(CategoriesCompanion entry) =>
      into(categories).insert(entry);

  Future<bool> updateCategory(Category category) =>
      update(categories).replace(category);

  Future<int> deleteCategory(int id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> deleteCategoryWithItems({required int categoryId}) async {
    // 트랜잭션으로 묶어서 실행
    await transaction(() async {
      // 먼저 해당 categoryId를 가진 item들을 삭제
      await (delete(
        items,
      )..where((tbl) => tbl.categoryId.equals(categoryId))).go();

      // 그 다음 category 삭제
      await (delete(
        categories,
      )..where((tbl) => tbl.id.equals(categoryId))).go();
    });
  }

  // Item 관련 CRUD
  Future<List<Item>> getItemsByCategoryId(int categoryId) {
    return (select(
      items,
    )..where((tbl) => tbl.categoryId.equals(categoryId))).get();
  }

  Future<int> insertItem(ItemsCompanion entry) => into(items).insert(entry);

  Future<bool> updateItem(Item item) => update(items).replace(item);

  Future<int> deleteItem(int id) =>
      (delete(items)..where((tbl) => tbl.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}

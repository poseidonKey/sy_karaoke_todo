import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sy_karaoke_todo/sqlite/core/db/app_database.dart';

final sqliteDbProvider = Provider<AppDatabase>((ref) => AppDatabase());

// 테스트용 User ID
final testUserIdProvider = Provider<int>((ref) => 1);

// Category 목록
final sqliteCategoryListProvider = FutureProvider<List<Category>>((ref) {
  final db = ref.watch(sqliteDbProvider);
  final userId = ref.watch(testUserIdProvider);
  return db.getCategoriesByUserId(userId);
});

// Item 목록
final sqliteItemListProvider = FutureProvider.family<List<Item>, int>((
  ref,
  categoryId,
) {
  final db = ref.watch(sqliteDbProvider);
  return db.getItemsByCategoryId(categoryId);
});

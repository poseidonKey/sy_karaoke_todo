import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sqlite_item_model.dart';
import '../repository/sqlite_item_repository.dart';

// 아이템 레포지토리 Provider
final sqliteItemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

// categoryId를 받아 해당 카테고리의 아이템 목록을 가져오는 FutureProvider
final sqliteItemsByCategoryProvider =
    FutureProvider.family<List<SqlItemModel>, int>((ref, categoryId) async {
      final repo = ref.read(sqliteItemRepositoryProvider);
      return await repo.getItemsByCategoryId(categoryId);
    });

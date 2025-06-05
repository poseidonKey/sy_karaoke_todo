import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sqlite_category_model.dart';
import '../repository/sqlite_category_repository.dart';

// 카테고리 레포지토리 Provider
final sqliteCategoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

// userId를 받아 해당 유저의 카테고리 목록을 가져오는 FutureProvider
final sqliteCategoriesByUserProvider =
    FutureProvider.family<List<SqlCategoryModel>, int>((ref, userId) async {
      final repo = ref.read(sqliteCategoryRepositoryProvider);
      return await repo.getCategoriesByUserId(userId);
    });

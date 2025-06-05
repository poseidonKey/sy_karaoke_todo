import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/sqlite_category_model.dart';
import '../provider/sqlite_category_provider.dart';

class SqliteCategoryScreen extends ConsumerWidget {
  const SqliteCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 가상 유저 ID, 예를 들면 1 고정 (실제론 userProvider에서 받아와야 함)
    final userId = 1;

    final categoriesAsync = ref.watch(sqliteCategoriesByUserProvider(userId));

    return Scaffold(
      appBar: AppBar(title: Text('SQLite 카테고리')),
      body: categoriesAsync.when(
        data: (categories) => ListView.builder(
          itemCount: categories.length,
          itemBuilder: (_, i) {
            final category = categories[i];
            return ListTile(
              title: Text(category.name),
              onTap: () {
                context.push('/sqlite_items/${category.id}');
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  final repo = ref.read(sqliteCategoryRepositoryProvider);
                  await repo.deleteCategoryWithItems(category.id!);
                  ref.invalidate(sqliteCategoriesByUserProvider(userId));
                },
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('오류 발생: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final repo = ref.read(sqliteCategoryRepositoryProvider);
          final newCategory = SqlCategoryModel(
            userId: userId,
            name: '새 카테고리',
            createdAt: DateTime.now().toIso8601String(),
            updatedAt: DateTime.now().toIso8601String(),
            isSynced: false,
          );
          await repo.insertCategory(newCategory);
          ref.invalidate(sqliteCategoriesByUserProvider(userId));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

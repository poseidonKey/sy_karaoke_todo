import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sy_karaoke_todo/sqlite/core/db/app_database.dart';
import 'package:sy_karaoke_todo/sqlite/core/db/provider/db_provider.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(sqliteCategoryListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('카테고리')),
      body: categories.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(data[i].name),
            onTap: () {
              context.push('/items/${data[i].id}');
            },
            trailing: IconButton(
              onPressed: () async {
                final db = ref.read(sqliteDbProvider);
                // db.deleteCategory(data[i].id);
                await db.deleteCategoryWithItems(categoryId: data[i].id);
                ref.invalidate(sqliteCategoryListProvider);
              },
              icon: Icon(Icons.delete),
            ),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final db = ref.read(sqliteDbProvider);
          final userId = ref.read(testUserIdProvider);
          await db.insertCategory(
            CategoriesCompanion(
              userId: drift.Value(userId),
              name: drift.Value('새 카테고리 3'),
              createdAt: drift.Value(DateTime.now().toIso8601String()),
              updatedAt: drift.Value(DateTime.now().toIso8601String()),
            ),
          );
          ref.invalidate(sqliteCategoryListProvider); // 새로고침
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sqlite_item_model.dart';
import '../provider/sqlite_item_provider.dart';

class SqliteItemScreen extends ConsumerWidget {
  final int categoryId;

  const SqliteItemScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(sqliteItemsByCategoryProvider(categoryId));

    return Scaffold(
      appBar: AppBar(title: Text('SQLite 아이템 목록')),
      body: itemsAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, i) {
            final item = items[i];
            return ListTile(
              title: Text(item.title),
              subtitle: Text(item.description ?? ''),
              trailing: Checkbox(
                value: item.done,
                onChanged: (checked) async {
                  final repo = ref.read(sqliteItemRepositoryProvider);
                  final updatedItem = item.copyWith(
                    done: checked ?? false,
                    updatedAt: DateTime.now().toIso8601String(),
                  );
                  await repo.updateItem(updatedItem);
                  ref.invalidate(sqliteItemsByCategoryProvider(categoryId));
                },
              ),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('에러 발생: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final repo = ref.read(sqliteItemRepositoryProvider);
          final newItem = SqlItemModel(
            categoryId: categoryId,
            title: '새 아이템',
            description: null,
            done: false,
            createdAt: DateTime.now().toIso8601String(),
            updatedAt: DateTime.now().toIso8601String(),
            isSynced: false,
          );
          await repo.insertItem(newItem);
          ref.invalidate(sqliteItemsByCategoryProvider(categoryId));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

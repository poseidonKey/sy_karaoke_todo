import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sy_karaoke_todo/sqlite/core/db/app_database.dart';
import 'package:sy_karaoke_todo/sqlite/core/db/provider/db_provider.dart';

class ItemScreen extends ConsumerWidget {
  final int categoryId;

  const ItemScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(sqliteItemListProvider(categoryId));

    return Scaffold(
      appBar: AppBar(title: Text('할 일 목록')),
      body: items.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, i) => CheckboxListTile(
            value: data[i].done,
            title: Text(data[i].title),
            onChanged: (val) {
              final db = ref.read(sqliteDbProvider);
              final updateItem = data[i].copyWith(done: val);
              print(updateItem.done);
              db.updateItem(updateItem);
              ref.invalidate(sqliteItemListProvider(categoryId));
            },
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final db = ref.read(sqliteDbProvider);
          await db.insertItem(
            ItemsCompanion(
              categoryId: drift.Value(categoryId),
              title: drift.Value('새 할일 $categoryId'),
              createdAt: drift.Value(DateTime.now().toIso8601String()),
              updatedAt: drift.Value(DateTime.now().toIso8601String()),
            ),
          );
          ref.invalidate(sqliteItemListProvider(categoryId));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

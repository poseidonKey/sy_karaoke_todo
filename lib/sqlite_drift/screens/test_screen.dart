import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/db/app_database.dart';

final dbProvider = Provider<AppDatabase>((ref) => AppDatabase());

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider);

    return Scaffold(
      appBar: AppBar(title: Text('DB 테스트')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('샘플 유저 생성'),
              onPressed: () async {
                await db
                    .into(db.users)
                    .insert(
                      UsersCompanion(
                        email: drift.Value('test@example.com'),
                        nickname: drift.Value('tester'),
                        createdAt: drift.Value(
                          DateTime.now().toIso8601String(),
                        ),
                      ),
                    );
              },
            ),
            ElevatedButton(
              child: Text('전체 지우기'),
              onPressed: () async {
                await db.clearAllData();
              },
            ),
          ],
        ),
      ),
    );
  }
}

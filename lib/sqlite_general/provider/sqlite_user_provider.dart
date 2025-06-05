import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sy_karaoke_todo/sqlite_general/models/sqlite_user_model.dart';

import '../repository/sqlite_user_repository.dart';

final sqliteUserRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

// 가상 유저 1명 초기화 및 저장 (초기 실행 시 한번만 호출)
final sqliteInitUserProvider = FutureProvider<SqlUserModel>((ref) async {
  final repo = ref.read(sqliteUserRepositoryProvider);
  final users = await repo.getAllUsers();

  if (users.isNotEmpty) {
    // 이미 유저 존재하면 첫번째 유저 반환
    return users.first;
  } else {
    // 없으면 기본 가상 유저 생성 후 저장
    final newUser = SqlUserModel(
      email: 'virtual@user.com',
      nickname: '가상유저',
      createdAt: DateTime.now().toIso8601String(),
    );
    final id = await repo.insertUser(newUser);
    return newUser.copyWith(id: id);
  }
});

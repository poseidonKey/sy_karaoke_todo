class SqlUserModel {
  final int? id;
  final String email;
  final String? nickname;
  final String createdAt;

  const SqlUserModel({
    this.id,
    required this.email,
    this.nickname,
    required this.createdAt,
  });

  /// copyWith
  SqlUserModel copyWith({
    int? id,
    String? email,
    String? nickname,
    String? createdAt,
  }) {
    return SqlUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// fromMap (DB → 모델)
  factory SqlUserModel.fromMap(Map<String, dynamic> map) {
    return SqlUserModel(
      id: map['id'] as int?,
      email: map['email'] as String,
      nickname: map['nickname'] as String?,
      createdAt: map['createdAt'] as String,
    );
  }

  /// toMap (모델 → DB 저장용)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'nickname': nickname,
      'createdAt': createdAt,
    };
  }

  /// 디버깅용 toString
  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, nickname: $nickname, createdAt: $createdAt)';
  }
}

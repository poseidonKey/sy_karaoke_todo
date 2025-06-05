class SqlCategoryModel {
  final int? id;
  final int userId;
  final String name;
  final String createdAt;
  final String updatedAt;
  final bool isSynced;

  const SqlCategoryModel({
    this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });

  /// copyWith
  SqlCategoryModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? createdAt,
    String? updatedAt,
    bool? isSynced,
  }) {
    return SqlCategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  /// fromMap
  factory SqlCategoryModel.fromMap(Map<String, dynamic> map) {
    return SqlCategoryModel(
      id: map['id'] as int?,
      userId: map['userId'] as int,
      name: map['name'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      isSynced: map['isSynced'] == 1, // SQLite는 boolean을 0/1로 저장
    );
  }

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isSynced': isSynced ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, userId: $userId, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced)';
  }
}

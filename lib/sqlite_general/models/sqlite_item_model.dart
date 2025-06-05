class SqlItemModel {
  final int? id;
  final int categoryId;
  final String title;
  final String? description;
  final bool done;
  final String createdAt;
  final String updatedAt;
  final bool isSynced;

  const SqlItemModel({
    this.id,
    required this.categoryId,
    required this.title,
    this.description,
    required this.done,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });

  /// copyWith
  SqlItemModel copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? description,
    bool? done,
    String? createdAt,
    String? updatedAt,
    bool? isSynced,
  }) {
    return SqlItemModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      done: done ?? this.done,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  /// fromMap
  factory SqlItemModel.fromMap(Map<String, dynamic> map) {
    return SqlItemModel(
      id: map['id'] as int?,
      categoryId: map['categoryId'] as int,
      title: map['title'] as String,
      description: map['description'] as String?,
      done: map['done'] == 1,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      isSynced: map['isSynced'] == 1,
    );
  }

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'done': done ? 1 : 0,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isSynced': isSynced ? 1 : 0,
    };
  }

  @override
  String toString() {
    return 'ItemModel(id: $id, categoryId: $categoryId, title: $title, description: $description, done: $done, createdAt: $createdAt, updatedAt: $updatedAt, isSynced: $isSynced)';
  }
}

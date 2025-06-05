import '../app_database.dart';

extension CategoryCopyWith on Category {
  Category copyWith({
    int? id,
    int? userId,
    String? name,
    String? createdAt,
    String? updatedAt,
    bool? isSynced,
  }) {
    return Category(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}

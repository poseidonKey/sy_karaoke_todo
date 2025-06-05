import '../app_database.dart';

extension ItemCopyWith on Item {
  Item copyWith({
    int? id,
    int? categoryId,
    String? title,
    String? description,
    bool? done,
    String? createdAt,
    String? updatedAt,
    bool? isSynced,
  }) {
    return Item(
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
}

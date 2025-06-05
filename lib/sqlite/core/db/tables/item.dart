import 'package:drift/drift.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get done => boolean().withDefault(Constant(false))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  BoolColumn get isSynced => boolean().withDefault(Constant(false))();
}

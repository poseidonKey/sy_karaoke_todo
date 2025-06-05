import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text()();
  TextColumn get nickname => text().nullable()();
  TextColumn get createdAt => text()();
}

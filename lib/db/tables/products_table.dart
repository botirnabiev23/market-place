import 'package:drift/drift.dart';

@DataClassName('ProductSql')
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text()();
  TextColumn get name => text()();
  TextColumn get image => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  IntColumn get count => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

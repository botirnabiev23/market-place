import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:market_place/db/dao/product_dao.dart';
import 'package:market_place/db/tables/products_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [Products], daos: [ProductDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static AppDatabase? _instance;

  static AppDatabase get instance {
    _instance ??= AppDatabase._internal();
    return _instance!;
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'market_place.sqlite'));
    return NativeDatabase(file);
  });
}

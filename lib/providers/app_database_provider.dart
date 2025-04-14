import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/db/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase.instance;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/data/json_loader.dart';
import 'package:market_place/models/category_model.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  return await JsonLoader.loadCategories();
});

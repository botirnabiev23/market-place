import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:market_place/models/category_model.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/models/user_model.dart';

class JsonLoader {
  static Future<List<Category>> loadCategories() async {
    final jsonStr = await rootBundle.loadString('assets/categories.json');
    final List jsonList = jsonDecode(jsonStr);
    return jsonList.map((e) => Category.fromJson(e)).toList();
  }

  static Future<List<Product>> loadProducts() async {
    final jsonStr = await rootBundle.loadString('assets/product.json');
    final List jsonList = jsonDecode(jsonStr);
    return jsonList.map((e) => Product.fromJson(e)).toList();
  }

  static Future<User> loadUser() async {
    final jsonStr = await rootBundle.loadString('assets/user.json');
    final jsonMap = json.decode(jsonStr);
    return User.fromJson(jsonMap);
  }
}

import 'package:market_place/models/product_model.dart';

class BasketProduct {
  final Product product;
  int count;

  BasketProduct({required this.product, this.count = 1});

  double get totalPrice => product.price * count;
}
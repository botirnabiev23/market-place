import 'package:market_place/models/basket_product_model.dart';

class BasketState {
  final List<BasketProduct> items;
  final Map<String, BasketProduct> map;

  BasketState({
    required this.items,
    required this.map,
  });

  factory BasketState.fromList(List<BasketProduct> list) {
    final map = {for (var item in list) item.product.id: item};
    return BasketState(items: list, map: map);
  }

  static BasketState empty() => BasketState(items: [], map: {});
}

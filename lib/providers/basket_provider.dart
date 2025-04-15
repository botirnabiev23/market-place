import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/models/basket_product_model.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/db/dao/product_dao.dart';
import 'package:market_place/providers/app_database_provider.dart';
import 'package:market_place/providers/basket_state.dart';

final productDaoProvider = Provider<ProductDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProductDao(db);
});

final basketProvider =
StateNotifierProvider<BasketNotifier, BasketState>((ref) {
  final dao = ref.watch(productDaoProvider);
  return BasketNotifier(dao);
});

class BasketNotifier extends StateNotifier<BasketState> {
  final ProductDao _dao;

  BasketNotifier(this._dao) : super(BasketState.empty()) {
    _dao.watchAllProducts().listen((products) {
      _updateBasket(products);
    });
  }

  void _updateBasket(List<BasketProduct> basketItems) {
    state = BasketState.fromList(basketItems);
  }

  Future<void> addToBasket(Product product) async {
    await _dao.addProduct(product);
  }

  Future<void> increaseCount(Product product) async {
    await _dao.addProduct(product);
  }

  Future<void> decreaseCount(String productId) async {
    await _dao.decrementOrDeleteProduct(productId);
  }

  Future<void> clearBasket() async {
    await _dao.clearAllProducts();
  }
}


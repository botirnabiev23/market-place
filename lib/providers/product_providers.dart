import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/data/json_loader.dart';

class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    return await JsonLoader.loadProducts();
  }

  void addProduct(Product product) {
    if (state is AsyncData) {
      state = AsyncData([...state.value!, product]);
    }
  }
}

final allProductsProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(ProductNotifier.new);

final filteredProductsProvider = Provider.family<List<Product>, String>((
  ref,
  categoryId,
) {
  final asyncProducts = ref.watch(allProductsProvider);

  return asyncProducts.when(
    data:
        (products) =>
            products.where((p) => p.categoryId == categoryId).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

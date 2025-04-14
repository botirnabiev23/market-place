import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/pages/product/widgets/product_item_widget.dart';
import 'package:market_place/providers/product_providers.dart';

class ProductPage extends ConsumerWidget {
  final Category category;

  const ProductPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(allProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name, style: TextStyle(fontSize: 16)),
      ),
      body: asyncProducts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (products) {
          final filtered =
              products.where((p) => p.categoryId == category.id).toList();

          if (filtered.isEmpty) {
            return const Center(child: Text('Нет товаров в этой категории'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount:
                filtered.length % 2 == 0
                    ? filtered.length
                    : filtered.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              if (index >= filtered.length) {
                return const SizedBox();
              }

              final product = filtered[index];
              return ProductItemWidget(product: product);
            },
          );
        },
      ),
    );
  }
}

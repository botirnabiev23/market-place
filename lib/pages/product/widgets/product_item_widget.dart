import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/pages/product/widgets/add_basket_button.dart';
import 'package:market_place/pages/product/widgets/basket_counter.dart';
import 'package:market_place/providers/basket_provider.dart';
import 'package:collection/collection.dart';

class ProductItemWidget extends ConsumerWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketItems = ref.watch(basketProvider);
    final item = basketItems.firstWhereOrNull(
          (item) => item.product.id == product.id,
    );

    return Hero(
      tag: product.id,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: () => context.push('/productDetails/${product.id}', extra: product),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: item == null || item.count == 0
                          ? AddToBasketButton(product: product)
                          : BasketCounter(
                        product: product,
                        count: item.count,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.price} \$',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:market_place/models/basket_product_model.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/pages/product/widgets/basket_counter.dart';
import 'package:market_place/providers/basket_provider.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketState = ref.watch(basketProvider);
    final basketItems = basketState.items;
    final item = basketItems.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => BasketProduct(product: product, count: 0),
    );

    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Hero(
          tag: product.id,
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                    child: Image.asset(product.image),
                  ),
                  const Gap(10),
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const Gap(10),
                  Text(
                    '${product.price} \$',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Gap(10),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                  ),
                  const Gap(16),
                  Row(
                    children: [
                      BasketCounter(product: product, count: item.count),
                      const Gap(10),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(basketProvider.notifier).addToBasket(product);
                              context.pop();
                            },
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                              foregroundColor: WidgetStateProperty.all(Colors.white),
                              backgroundColor: WidgetStateProperty.all(Colors.black),
                              overlayColor: WidgetStateProperty.all(Colors.transparent),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              padding: WidgetStateProperty.all(EdgeInsets.zero),
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

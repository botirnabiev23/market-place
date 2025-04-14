import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:market_place/models/basket_product_model.dart';
import 'package:market_place/providers/basket_provider.dart';

class BasketItemWidget extends ConsumerWidget {
  final BasketProduct item;

  const BasketItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = item.product;

    return InkWell(
      onTap:
          () => context.push('/productDetails/${product.id}', extra: product),
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Hero(
              tag: product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  product.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('${(item.totalPrice).toStringAsFixed(2)} \$'),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap:
                        () =>
                        ref.read(basketProvider.notifier).decreaseCount(product.id),
                    child: const Icon(CupertinoIcons.minus, size: 20),
                  ),
                  const Gap(12),
                  GestureDetector(
                    onTap: () {},
                    child: Text('${item.count}'),
                  ),
                  const Gap(12),
                  GestureDetector(
                    onTap:
                        () =>
                        ref.read(basketProvider.notifier).increaseCount(product),
                    child: const Icon(CupertinoIcons.add, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

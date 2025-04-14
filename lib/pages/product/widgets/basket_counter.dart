import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/providers/basket_provider.dart';

class BasketCounter extends ConsumerWidget {
  final Product product;
  final int count;

  const BasketCounter({super.key, required this.product, required this.count});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
          Text('$count'),
          const Gap(12),
          GestureDetector(
            onTap:
                () =>
                    ref.read(basketProvider.notifier).increaseCount(product),
            child: const Icon(CupertinoIcons.add, size: 20),
          ),
        ],
      ),
    );
  }
}

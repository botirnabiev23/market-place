import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/providers/basket_provider.dart';

class AddToBasketButton extends ConsumerWidget {
  final Product product;

  const AddToBasketButton({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(basketProvider.notifier).addToBasket(product);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(CupertinoIcons.add, size: 20),
      ),
    );
  }
}

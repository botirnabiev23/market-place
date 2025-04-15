import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:market_place/pages/basket/widgets/basket_item_widget.dart';
import 'package:market_place/providers/basket_provider.dart';

class BasketPage extends ConsumerWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basketState = ref.watch(basketProvider);
    final basketItems = basketState.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина', style: TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(basketProvider.notifier).clearBasket();
            },
            icon: const Icon(CupertinoIcons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: basketItems.isEmpty
            ? const Center(child: Text('Корзина пуста'))
            : ListView.separated(
          separatorBuilder: (context, index) => const Gap(10),
          itemCount: basketItems.length,
          itemBuilder: (context, index) {
            final item = basketItems[index];
            return BasketItemWidget(item: item);
          },
        ),
      ),
    );
  }
}

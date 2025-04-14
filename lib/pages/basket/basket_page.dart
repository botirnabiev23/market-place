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
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина', style: TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(basketProvider.notifier).clearBasket();
            },
            icon: Icon(CupertinoIcons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer(
          builder: (context, ref, _) {
            final basket = ref.watch(basketProvider);

            if (basket.isEmpty) {
              return Center(child: Text('Корзина пуста'));
            }

            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Gap(10);
              },
              itemCount: basket.length,
              itemBuilder: (context, index) {
                final item = basket[index];
                return BasketItemWidget(item: item);
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market_place/models/category_model.dart';
import 'package:market_place/models/product_model.dart';
import 'package:market_place/pages/basket/basket_page.dart';
import 'package:market_place/pages/categories/categories_page.dart';
import 'package:market_place/pages/home/home_page.dart';
import 'package:market_place/pages/product/product_page.dart';
import 'package:market_place/pages/product/widgets/product_detail_page.dart';
import 'package:market_place/pages/profile/profile_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/catalog',
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/catalog',
              name: 'catalog',
              builder: (context, state) => const CategoriesPage(),
            ),
            GoRoute(
              path: '/product/:categoryId',
              name: 'product',
              builder: (context, state) {
                final category = state.extra as Category?;
                if (category == null) {
                  return Scaffold(
                    body: Center(child: Text('Category not found')),
                  );
                }
                return ProductPage(category: category);
              },
            ),
            GoRoute(
              path: '/productDetails/:productId',
              name: 'productDetails',
              builder: (context, state) {
                final product = state.extra as Product?;
                if (product == null) {
                  return Scaffold(
                    body: Center(child: Text('Category not found')),
                  );
                }
                return ProductDetailPage(product: product);
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/basket',
              name: 'basket',
              builder: (context, state) => const BasketPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
      builder:
          (_, __, navigationShell) =>
              HomePage(navigationShell: navigationShell),
    ),
  ],
);

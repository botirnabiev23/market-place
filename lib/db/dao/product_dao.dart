// lib/db/dao/product_dao.dart
import 'package:drift/drift.dart';
import 'package:market_place/db/app_database.dart';
import 'package:market_place/db/extensions/product_extension.dart';
import 'package:market_place/db/tables/products_table.dart';
import 'package:market_place/models/basket_product_model.dart';
import 'package:market_place/models/product_model.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Stream<List<BasketProduct>> watchAllProducts() =>
      select(products).watch().map((rows) {
        final products = rows.map((e) => e.toBasketItem()).toList();

        return products;
      });

  Future<void> addProduct(Product product) async {
    final existing =
        await (select(products)
          ..where((p) => p.id.equals(product.id))).getSingleOrNull();

    if (existing == null) {
      await into(products).insert(
        ProductsCompanion.insert(
          id: product.id,
          categoryId: product.categoryId,
          name: product.name,
          image: product.image,
          description: product.description,
          price: product.price,
          count: const Value(1),
        ),
      );
      return;
    }
    await (update(products)..where(
      (p) => p.id.equals(product.id),
    )).write(ProductsCompanion(count: Value(existing.count + 1)));
  }

  Future<void> deleteProduct(String id) async {
    await (delete(products)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> decrementOrDeleteProduct(String id) async {
    final existing =
        await (select(products)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

    if (existing != null) {
      if (existing.count > 1) {
        await (update(products)..where(
          (tbl) => tbl.id.equals(id),
        )).write(ProductsCompanion(count: Value(existing.count - 1)));
      } else {
        await deleteProduct(id);
      }
    }
  }

  Future<void> clearAllProducts() async {
    await delete(products).go();
  }
}

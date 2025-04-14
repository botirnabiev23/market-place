// lib/db/mappers/product_mapper.dart
import 'package:market_place/db/app_database.dart';
import 'package:market_place/models/basket_product_model.dart';
import 'package:market_place/models/product_model.dart';

extension ProductSqlMapper on ProductSql {
  Product toModel() {
    return Product(
      id: id,
      categoryId: categoryId,
      name: name,
      image: image,
      description: description,
      price: price,
    );
  }

  BasketProduct toBasketItem() {
    return BasketProduct(
      product: toModel(),
      count: count,
    );
  }
}


// extension ProductModelMapper on Product {
//   ProductSql toSql({int count = 1}) {
//     // Только если хочешь как data-класс, но Drift требует Companion
//     // Поэтому это будет использоваться только для удобства
//     throw UnimplementedError(
//         'Use .toCompanion() instead if needed in DB operations');
//   }
//
//   Map<String, dynamic> toColumns({int count = 1}) {
//     return {
//       'id': id,
//       'category_id': categoryId,
//       'name': name,
//       'image': image,
//       'description': description,
//       'price': price,
//       'count': count,
//     };
//   }
// }

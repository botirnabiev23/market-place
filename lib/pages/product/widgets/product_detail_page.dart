import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:market_place/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white),
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
                    child: Image(image: AssetImage(product.image)),
                  ),
                  Gap(10),
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  Gap(10),
                  Text(
                    '${product.price} \$',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Gap(10),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
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

class Product {
  final String id;
  final String categoryId;
  final String name;
  final String image;
  final String description;
  final double price;

  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? categoryId,
    String? name,
    String? image,
    String? description,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    categoryId: json['categoryId'],
    name: json['name'],
    image: json['image'],
    description: json['description'],
    price: (json['price'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'name': name,
    'image': image,
    'description': description,
    'price': price,
  };
}

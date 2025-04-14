class Category {
  final String id;
  final String name;
  final String image;

  const Category({
    required this.id,
    required this.name,
    required this.image,
  });

  Category copyWith({
    String? id,
    String? name,
    String? image,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'].toString(),
    name: json['name'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
  };
}

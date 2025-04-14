class User {
  final String name;
  final String email;
  final String phone;
  final List<String> avatars;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatars,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatars: List<String>.from(json['avatars']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatars': avatars,
    };
  }

  User copyWith({
    String? name,
    String? email,
    String? phone,
    List<String>? avatars,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatars: avatars ?? this.avatars,
    );
  }
}

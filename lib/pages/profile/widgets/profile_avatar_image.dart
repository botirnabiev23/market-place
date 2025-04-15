import 'package:flutter/material.dart';

class ProfileAvatarImage extends StatelessWidget {
  final String path;

  const ProfileAvatarImage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) {
      return Container(
        width: 150,
        height: 150,
        color: Colors.grey,
      );
    } else {
      return Image(
        image: AssetImage(path),
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      );
    }
  }
}

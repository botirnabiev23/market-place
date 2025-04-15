import 'dart:io';
import 'package:flutter/material.dart';
import 'package:market_place/pages/profile/widgets/profile_image_widget.dart';

class AvatarGallery extends StatelessWidget {
  final List<String> avatars;
  final bool isEditing;
  final VoidCallback onAdd;
  final void Function(int) onDelete;

  const AvatarGallery({
    super.key,
    required this.avatars,
    required this.isEditing,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (int i = 1; i < avatars.length; i++)
          Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.black,
                    pageBuilder: (_, __, ___) => ProfileImageWidget(
                      images: avatars,
                      initialIndex: i,
                    ),
                  ),
                ),
                child: ClipOval(
                  child: Image(
                    image: avatars[i].startsWith('http')
                        ? NetworkImage(avatars[i])
                        : FileImage(File(avatars[i])) as ImageProvider,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (isEditing)
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => onDelete(i),
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        if (isEditing)
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.add_a_photo, size: 28),
            ),
          ),
      ],
    );
  }
}

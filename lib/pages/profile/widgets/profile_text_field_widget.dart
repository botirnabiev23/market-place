import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;

  const ProfileTextField({
    super.key,
    required this.controller,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isEditing
            ? TextFormField(controller: controller)
            : Text(controller.text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

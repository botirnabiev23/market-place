import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/pages/profile/widgets/profile_image_widget.dart';
import 'package:market_place/pages/profile/widgets/profile_text_field_widget.dart';
import 'package:market_place/providers/user_provider.dart';
import 'widgets/profile_avatar_image.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _isEditing = false;

  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _phoneController = TextEditingController();

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final currentUser = ref.read(userProvider).value;
      if (currentUser != null) {
        final updatedAvatars = List<String>.from(currentUser.avatars)
          ..add(pickedFile.path);
        ref
            .read(userProvider.notifier)
            .updateUser(currentUser.copyWith(avatars: updatedAvatars));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (userAsync.hasValue)
            TextButton(
              onPressed: () {
                setState(() => _isEditing = !_isEditing);
                if (!_isEditing) {
                  final currentUser = userAsync.value;
                  if (currentUser != null) {
                    ref
                        .read(userProvider.notifier)
                        .updateUser(
                          User(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            phone: _phoneController.text.trim(),
                            avatars: currentUser.avatars,
                          ),
                        );
                  }
                }
              },
              child: Text(_isEditing ? 'Сохранить' : 'Изм.'),
            ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          _nameController.text = user.name;
          _emailController.text = user.email;
          _phoneController.text = user.phone;
          final avatars = user.avatars;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: avatars[0],
                      child: GestureDetector(
                        onTap: () {
                          if (avatars.isNotEmpty) {
                            showDialog(
                              useSafeArea: false,
                              context: context,
                              builder: (BuildContext context) {
                                return ProfileImageWidget(
                                  images: avatars,
                                  initialIndex: 0,
                                );
                              },
                            );
                          }
                        },
                        child: ClipOval(
                          child: ProfileAvatarImage(path: avatars[0]),
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Gap(20),
              ProfileTextField(
                controller: _nameController,
                isEditing: _isEditing,
              ),
              const Gap(12),
              ProfileTextField(
                controller: _phoneController,
                isEditing: _isEditing,
              ),
              const Gap(12),
              ProfileTextField(
                controller: _emailController,
                isEditing: _isEditing,
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Ошибка загрузки: $err')),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:market_place/models/user_model.dart';
import 'package:market_place/pages/profile/widgets/profile_image_widget.dart';
import 'package:market_place/pages/profile/widgets/profile_text_field_widget.dart';
import 'package:market_place/providers/user_provider.dart';

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
                child: Hero(
                  tag:
                      avatars.isNotEmpty
                          ? avatars[0]
                          : 'https://img.freepik.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3383.jpg',
                  child: GestureDetector(
                    onTap: () {
                      if (avatars.isNotEmpty) {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            barrierColor: Colors.black,
                            pageBuilder:
                                (_, __, ___) => ProfileImageWidget(
                                  images: avatars,
                                  initialIndex: 0,
                                ),
                          ),
                        );
                      }
                    },
                    child: ClipOval(
                      child: switch (avatars.isNotEmpty) {
                        true => Image.network(
                          avatars[0],
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        false => Container(
                          width: 150,
                          height: 150,
                          color: Colors.grey,
                        ),
                      },
                    ),
                  ),
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

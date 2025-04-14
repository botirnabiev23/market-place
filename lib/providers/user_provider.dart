import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:market_place/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

final userProvider = StateNotifierProvider<UserNotifier, AsyncValue<User>>(
      (ref) => UserNotifier(),
);

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  UserNotifier() : super(const AsyncValue.loading()) {
    _loadUser();
  }

  Future<File> _getUserFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/user.json');
  }

  Future<void> _loadUser() async {
    try {
      final file = await _getUserFile();

      if (await file.exists()) {
        final jsonStr = await file.readAsString();
        final json = jsonDecode(jsonStr);
        final user = User.fromJson(json);
        state = AsyncValue.data(user);
      } else {
        final jsonStr = await rootBundle.loadString('assets/user.json');
        final json = jsonDecode(jsonStr);
        final user = User.fromJson(json);
        state = AsyncValue.data(user);

        await file.writeAsString(jsonEncode(json));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateUser(User newUser) async {
    state = AsyncValue.data(newUser);

    try {
      final file = await _getUserFile();
      final json = newUser.toJson();
      await file.writeAsString(jsonEncode(json));
    } catch (e, st) {
      debugPrint('skfjsf $e');
      state = AsyncValue.error(e, st);
    }
  }
}

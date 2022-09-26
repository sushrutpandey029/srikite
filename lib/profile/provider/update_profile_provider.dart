import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kite/profile/repo/update_profile_repo.dart';
import 'package:kite/shared/ui/screens/wrapper.dart';
import 'package:kite/shared/ui/widgets/custom_dialouge.dart';
import 'package:provider/provider.dart';

import '../../authentication/provider/auth_provider.dart';

class UpdateProfileProvider extends ChangeNotifier {
  final UpdateProfileRepo _profileRepo = UpdateProfileRepo();
  bool isLoading = false;

  Future<void> updateProfile(
    BuildContext context, {
    required String userId,
    String? userName,
    String? userBio,
    String? userImage,
    String? userNumber,
    String? uuid,
    String? fcm,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      if (userName != null) {
        await _profileRepo.updateUserName(userId, userName);
      }
      if (userBio != null) {
        await _profileRepo.updateUserBio(userId, userBio);
      }
      if (userImage != null) {
        await _profileRepo.updateUserImage(userId, userImage);
      }
      if (userNumber != null) {
        await _profileRepo.updateUserNumber(userId, userNumber);
      }
      if (uuid != null) {
        await _profileRepo.updateuuid(userId, uuid);
      }
      if (fcm != null) {
        await _profileRepo.updatefcm(userId, fcm);
      }
      if (userName != null || userBio != null || userImage != null) {
        await context.read<AuthProvider>().getUser(
            await context.read<AuthProvider>().authUserModel!.userPhoneNumber);
      }

      isLoading = false;
      notifyListeners();
      log('here');
    } on DioError catch (e) {
      showDialog(
          context: context,
          builder: (context) => CustomDialogue(
                message: e.message,
              ));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodex/core/services/logout_service/logout_service.dart';
import 'package:prodex/core/storage/local_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final LogoutService logoutService = LogoutService();
  var isObscure = true.obs;

  final ImagePicker picker = ImagePicker();

  var userName =
      (LocalStorage().readData('username') ?? 'admin').toString().obs;
  var password =
      (LocalStorage().readData('password') ?? 'Pass@123').toString().obs;

  var selectedImagePath =
      (LocalStorage().readData('profileImg') ?? '').toString().obs;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    userNameController.text = userName.value;
    passwordController.text = password.value;
  }

  void pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      selectedImagePath.value = image.path;
      LocalStorage().saveData('profileImg', image.path);
      Get.back();
    } else {
      Get.snackbar('Cancelled', 'No image selected');
    }
  }

  void changeVisibility() {
    isObscure.value = !isObscure.value;
  }

  void updateProfile() {
    userName.value = userNameController.text.trim();
    password.value = passwordController.text.trim();

    LocalStorage().saveData('username', userName.value);
    LocalStorage().saveData('password', password.value);

    Get.snackbar('Updated', 'Profile updated successfully');
  }

  void logout() {
    logoutService.logout();
  }
}

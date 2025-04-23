import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prodex/core/storage/local_storage.dart';
import 'package:prodex/routes.dart';

class AuthController extends GetxController {
  var isObscure = true.obs;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void changeVisibility() {
    isObscure.value = !isObscure.value;
  }

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final String storedUname = LocalStorage().readData('username') ?? 'admin';
    final String storedUpassword =
        LocalStorage().readData('password') ?? 'Pass@123';

    if (username == storedUname && password == storedUpassword) {
      LocalStorage().saveData('isFirstTime', false);
      Get.offAllNamed(AppRoutes.product);
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }
}

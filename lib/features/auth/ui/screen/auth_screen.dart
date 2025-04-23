import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodex/features/auth/controllers/auth_controller.dart';
import 'package:prodex/utils/constants/colors.dart';
import 'package:prodex/utils/constants/image.dart';
import 'package:prodex/utils/constants/text_string.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
          child: ListView(
            children: [
              SizedBox(
                height: context.height * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(PImages.logo, scale: 2),
                  Text(
                    PStrings.appName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ],
              ),
              SizedBox(
                height: context.height * 0.03,
              ),
              Text(
                'Welcome to ${PStrings.appName}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(2, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.usernameController,
                  style: Theme.of(context).textTheme.labelLarge,
                  decoration: const InputDecoration(hintText: 'Username'),
                ),
              ),
              SizedBox(
                height: context.height * 0.03,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: Obx(() {
                  return TextField(
                    controller: controller.passwordController,
                    style: Theme.of(context).textTheme.labelLarge,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.changeVisibility();
                          },
                          icon: Icon(
                            controller.isObscure.value
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: PColors.primary,
                          )),
                    ),
                    obscureText: controller.isObscure.value,
                  );
                }),
              ),
              SizedBox(
                height: context.height * 0.08,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10)),
                  child: const Text('Log In'),
                ),
              ),
              //const Spacer(),
            ], //
          ),
        ),
      ),
    );
  }
}

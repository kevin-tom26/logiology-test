import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prodex/features/profile/controller/profile_controller.dart';
import 'package:prodex/utils/constants/colors.dart';

class ProfileUpdateCard extends StatelessWidget {
  ProfileUpdateCard({
    super.key,
  });

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Update Credentials",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600)),
          SizedBox(height: context.height * 0.024),
          Text(
            " Username",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Container(
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
            child: TextField(
              controller: controller.userNameController,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: PColors.textPrimary, fontWeight: FontWeight.w500),
              decoration: const InputDecoration(hintText: 'Username'),
            ),
          ),
          SizedBox(height: context.height * 0.025),
          Text(
            " Password",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Container(
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: PColors.textPrimary, fontWeight: FontWeight.w500),
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
          SizedBox(height: context.height * 0.028),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: controller.updateProfile,
              child: const Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
